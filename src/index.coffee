'use strict'

Block = require 'binbone'

writeOffset = (int) ->
    if int >= 0 then int + 1 else int

readOffset = (int) ->
    if int > 0 then int - 1 else int

class GeneralCompressor
    constructor: (@RLE = true, @peek = false) ->
        @_num = 0

        @_data = new Block()

        @arr = []

        unless @RLE
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

    _flush1: -> return

    _flush2: ->
        return if @_bufNum is 0

        if @_bufNum > 3
            @_data.writeUInt 0
            @_data.writeInt writeOffset @_bufItem
            @_data.writeLength @_bufNum
        else
            for i in [0...@_bufNum]
                @_data.writeInt writeOffset @_bufItem

        @_bufItem = null
        @_bufNum = 0

    _writeBuf1: (int) ->
        @peek and @arr.push int
        @_data.writeInt int

    _readBuf1: ->
        @_data.readInt()

    _readBuf2: ->
        if @_readBufNum > 0
            @_readBufNum -= 1
            return @_readBufItem

        i1 = @_data.readInt()
        if i1 is 0
            item = readOffset @_data.readInt()
            len = @_data.readLength()
            @_readBufItem = item
            @_readBufNum = len - 1
            item
        else
            readOffset i1

    _writeBuf2: (int) ->
        @peek and @arr.push int
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

    write: (int) ->
        @_num += 1
        @_write ~~int

    _decompress: ->
        throw Error("This method should be overwritten by subclasses!")

    getResult: ->
        if @_num is 0
            return new Buffer 0
        @_flush()
        @_data.getData()

class CompressorOrder2 extends GeneralCompressor
    constructor: (RLE, peek) ->
        super
        @_base1 = @_base2 = @_prev1 = @_prev2 = null
        @_data.writeByte if RLE then 0x21 else 0x20
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

    _decompress: ->
        base1 = @_readBuf()
        try
            base2 = @_readBuf()
        catch
            return [base1]

        prev1 = base1 + base2
        prev2 = base1
        arr = [prev2, prev1]

        try
            while true
                int = @_readBuf()
                cur = int + 2 * prev1 - prev2
                [prev2, prev1] = [prev1, cur]
                arr.push cur
        catch e
            return arr


class CompressorOrder1 extends GeneralCompressor
    constructor: (RLE, peek) ->
        super
        @_base = @_prev = null
        @_data.writeByte if RLE then 0x11 else 0x10
        @

    _writeFirst: (int) ->
        @_writeBuf int
        @_prev = @_base = int

        @_write = CompressorOrder1::_writeOthers

    _writeOthers: (int) ->
        @_writeBuf int - @_prev
        @_prev = int

    _write: CompressorOrder1::_writeFirst

    _decompress: ->
        base = @_readBuf()

        prev = base
        arr = [prev]

        try
            while true
                int = @_readBuf()
                cur = int + prev
                arr.push cur
                prev = cur
        catch e
            if e.name is 'QueueReadError'
                return arr
            else
                throw e

IC = {}

IC.getCompressor = (RLE = true, order = 2, peek = false) ->
    if order is 1
        new CompressorOrder1 RLE, peek
    else
        new CompressorOrder2 RLE, peek

IC.compress = (arr, opts = {}) ->
    {RLE, order, peek} = opts
    compressor = IC.getCompressor RLE, order, peek = true
    for i in arr
        compressor.write i
    compressor.getResult()

IC.decompress = (buffer) ->
    if buffer.length is 0
        return []
    block = new Block buffer
    opt = block.readByte()

    RLE = !! (opt & 1)
    order = opt >>> 4 or 2

    compressor = IC.getCompressor RLE, order
    compressor._data = block
    compressor._decompress()

IC.compare = (arr = []) ->
    result = []

    build = (name, fun) ->
        t1 = Date.now()
        len = fun()

        result.push
            name: name
            value: len
            time: Date.now() - t1

    build "plain", ->
        b = new Block()
        for i in arr
            b.writeInt i
        b.getData().length

    build 'order1_RLE', ->
        res = IC.compress arr,
            order: 1
            RLE: yes
        res.length
    build 'order1', ->
        res = IC.compress arr,
            order: 1
            RLE: no
        res.length
    build 'order2_RLE', ->
        res = IC.compress arr,
            order: 2
            RLE: yes
        res.length
    build 'order2', ->
        res = IC.compress arr,
            order: 2
            RLE: no
        res.length
    result


module.exports = IC
