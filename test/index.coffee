{compress, decompress} = require '../src'
assert = require 'assert'
util = require 'util'

eq = assert.strictEqual
deq = assert.deepStrictEqual or assert.deepEqual
ts = assert.throws

randomArray = require './random'

buildTest = (order, RLE = true, lengths = []) ->
    it "compress length 0", ->
        res = compress [], {order, RLE}
        deq res, new Buffer 0

    it "compress length 1", ->
        res = compress [10], {order, RLE}
        eq res.length, 2
        deq decompress(res), [10]

    it "compress length 2", ->
        res = compress [10, 18], {order, RLE}
        eq res.length, 3
        deq decompress(res), [10, 18]

    it "compress length 3", ->
        res = compress [10, 18, -2], {order, RLE}
        eq res.length, 4
        deq decompress(res), [10, 18, -2]

    it "compress same arr", ->
        arr = (1 for i in [1...1000])
        res = compress arr, {order, RLE}
        eq res.length, lengths[0]
        deq decompress(res), arr

    it "compress sequence", ->
        arr = [1...1000]
        res = compress arr, {order, RLE}
        eq res.length, lengths[1]
        deq decompress(res), arr

    it "compress random", ->
        arr = randomArray 1000, 100, 200
        res = compress arr, {order, RLE}
        deq decompress(res), arr

describe "order1-RLE", ->
    buildTest 1, true, [6, 5]
describe "order1", ->
    buildTest 1, false, [1000, 1000]

describe "order2-RLE", ->
    buildTest 2, true, [6, 7]
describe "order2", ->
    buildTest 2, false, [1000, 1000]



