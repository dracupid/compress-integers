'use strict'

Block = require 'binbone'

IC = {}

###*
 * Get an order N compressor with options
 * @param  {Object={}} opts    options
 * @option {boolean}   RLE     use Run-Length Encoding
 * @option {number=1}  order   order of the compressor (0, 1 or 2)
 * @return {Compressor}        an order N compressor
 * @noPrefix
###
IC.getCompressor = (opts = {}) ->
    defaults opts,
        order: 1

    switch opts.order
        when 0 then new CompressorOrder0 opts
        when 1 then new CompressorOrder1 opts
        when 2 then new CompressorOrder2 opts
        else
            throw new Error "Order should be in 0, 1, 2"

###*
 * A shortcut for get a Compressor
 * @param  {Array}      arr         array of integers
 * @param  {options={}} options     see getCompressor
 * @return {Buffer}     compressed data
 * @noPrefix
###
IC.compress = (arr, opts = {}) ->
    compressor = IC.getCompressor opts
    for i in arr
        compressor.write i
    compressor.getResult()

###*
 * Decompress a buffer to an array of integers
 * @param  {Buffer} buffer  buffer to compress
 * @return {Array}          array of integers
 * @noPrefix
###
IC.decompress = (buffer) ->
    if buffer.length is 0
        return []
    block = new Block buffer
    opt = block.readByte()

    RLE = !! (opt & 1)
    order = opt >>> 4
    unsigned = !! (opt >>> 5)

    compressor = IC.getCompressor {RLE, order, unsigned}
    compressor._data = block
    compressor._decompress()

IC.compare = (arr = []) ->
    zlib = require 'zlib'

    result = []

    build = (name, fun) ->
        t1 = Date.now()
        data = fun()
        t2 = Date.now()
        zipped = zlib.deflateRawSync(data)
        t3 = Date.now()

        result.push
            name: name
            value: data.length
            time: t2 - t1
            timeZip: t3 - t2
            deflate: zipped.length

    build "plain", ->
        IC.compress arr,
            order: 0
            RLE: no

    build "order0_RLE", ->
        IC.compress arr,
            order: 0
            RLE: yes

    build "order0_RLE_UNSIGNED", ->
        IC.compress arr,
            order: 0
            RLE: yes
            unsigned: yes

    build 'order1_RLE', ->
        IC.compress arr,
            order: 1
            RLE: yes
    build 'order1', ->
        IC.compress arr,
            order: 1
            RLE: no
    build 'order2_RLE', ->
        IC.compress arr,
            order: 2
            RLE: yes
    build 'order2', ->
        IC.compress arr,
            order: 2
            RLE: no

    result


writeOffset = (int) ->
    if int >= 0 then int + 1 else int

readOffset = (int) ->
    if int > 0 then int - 1 else int

defaults = (src, dest) ->
    for k, v of dest
        (src[k] is undefined) and src[k] = v
    src

class GeneralCompressor
    constructor: (@opts = {}) ->
        defaults @opts,
            RLE: true

        @_num = 0

        @_data = new Block()

        unless @opts.RLE
            @_flush = GeneralCompressor::_flush1
            @_writeBuf = GeneralCompressor::_writeBuf1
            @_readBuf = GeneralCompressor::_readBuf1
        else
            @_bufItem = null
            @_bufNum = 0
            @_readBufItem = null
            @_readBufNum = 0
            @_flush = GeneralCompressor::_flush2
            @_writeBuf = GeneralCompressor::_writeBuf2
            @_readBuf = GeneralCompressor::_readBuf2
        @

    _writeInt: (int) ->
        @_data.writeInt int

    _readInt: ->
        parseInt @_data.readInt()

    _flush1: -> return

    _flush2: ->
        return if @_bufNum is 0

        if @_bufNum > 3
            @_data.writeUInt 0
            @_writeInt writeOffset @_bufItem
            @_data.writeLength @_bufNum
        else
            for i in [0...@_bufNum]
                @_writeInt writeOffset @_bufItem

        @_bufItem = null
        @_bufNum = 0

    _readBuf1: ->
        @_readInt()

    _readBuf2: ->
        if @_readBufNum > 0
            @_readBufNum -= 1
            return @_readBufItem

        i1 = @_readInt()
        if i1 is 0
            item = readOffset @_readInt()
            len = @_data.readLength()
            @_readBufItem = item
            @_readBufNum = len - 1
            item
        else
            readOffset i1

    _writeBuf1: (int) ->
        @_writeInt int

    _writeBuf2: (int) ->
        if @_bufNum is 0
            @_bufItem = int
            @_bufNum += 1
        else if int is @_bufItem
            @_bufNum += 1
        else
            @_flush()
            @_bufItem = int
            @_bufNum = 1

    _write: (int) ->
        @_writeBuf int

    ###*
     * write an integer
     * @param  {number} int integer
     * @prefix Compressor.
    ###
    write: (int) ->
        @_num += 1
        int = parseInt int
        int = 0 if isNaN int
        @_write int

    _decompress: ->
        throw Error "This method should be overwritten by subclasses!"

    ###*
     * Get the result buffer
     * @return {Buffer} buffer
     * @prefix Compressor.
    ###
    getResult: ->
        if @_num is 0
            return new Buffer 0
        @_flush()
        res = @_data.getData()
        res


class CompressorOrder0 extends GeneralCompressor
    constructor: (opts) ->
        super
        if @opts.unsigned
            @__proto__._writeInt = CompressorOrder0::_writeUInt
            @__proto__._readInt = CompressorOrder0::_readUInt

        @_data.writeByte ~~@opts.RLE | ~~@opts.unsigned << 1
        @

    _writeUInt: (int) ->
        @_data.writeUInt int

    _readUInt: ->
        parseInt @_data.readUInt()

    _write: (int) ->
        @_writeBuf int

    _decompress: (limit) ->
        arr = []
        num = 0

        try
            while true
                return arr if num is limit
                int = @_readBuf()
                arr.push int
                num += 1
        catch e
            if e.name is 'QueueReadError'
                return arr
            else
                throw e


class CompressorOrder1 extends GeneralCompressor
    constructor: (opts) ->
        super
        @_base = @_prev = null
        @_data.writeByte (1 << 4) | ~~@opts.RLE
        @

    _writeFirst: (int) ->
        @_writeBuf int
        @_prev = @_base = int

        @_write = CompressorOrder1::_writeOthers

    _writeOthers: (int) ->
        @_writeBuf int - @_prev
        @_prev = int

    _write: CompressorOrder1::_writeFirst

    _decompress: (limit) ->
        if limit is 0
            return []
        base = @_readBuf()

        prev = base
        arr = [prev]
        num = 1

        try
            while true
                return arr if num is limit
                int = @_readBuf()
                cur = int + prev
                arr.push cur
                prev = cur
                num += 1
        catch e
            if e.name is 'QueueReadError'
                return arr
            else
                throw e


class CompressorOrder2 extends GeneralCompressor
    constructor: (opts) ->
        super
        @_base1 = @_base2 = @_prev1 = @_prev2 = null
        @_data.writeByte (2 << 4) | ~~@opts.RLE
        @

    _writeFirst: (int) ->
        @_writeBuf int
        @_base1 = int
        @_prev2 = int

        @_write = CompressorOrder2::_writeSecond

    _writeSecond: (int) ->
        @_base2 = int - @_prev2
        @_writeBuf @_base2
        @_prev1 = int

        @_write = CompressorOrder2::_writeOthers

    _writeOthers: (int) ->
        @_writeBuf int - 2 * @_prev1 + @_prev2

        [@_prev2, @_prev1] = [@_prev1, int]

    _write: CompressorOrder2::_writeFirst

    _decompress: (limit) ->
        if limit is 0
            return []

        base1 = @_readBuf()
        try
            base2 = @_readBuf()
        catch
            return [base1]

        prev1 = base1 + base2
        prev2 = base1
        arr = [prev2, prev1]
        num = 2

        if limit is 1
            return [prev2]

        try
            while true
                return arr if num is limit
                int = @_readBuf()
                cur = int + 2 * prev1 - prev2
                [prev2, prev1] = [prev1, cur]
                arr.push cur
                num += 1
        catch e
            return arr

module.exports = IC
