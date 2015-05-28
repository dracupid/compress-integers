IC = require '../src'
kit = require 'nokit'
kit.require 'colors'
_ = kit._
util = require 'util'

report = (arr, msg = "Compare") ->
    res = IC.compare arr
    res = _.sortBy _.sortBy(res, 'time'), 'value'

    base = _.result _.find(res, 'name', 'plain'), 'value'
    # baseDeflate = _.result _.find(res, 'name', 'plain'), 'deflate'

    minVal = _.min(res, 'value').value
    minTime = _.min(res, 'time').time
    minValKey = []
    minTimeKey = []

    for {name, time, value} in res
        minTimeKey.push(name) if time is minTime
        minValKey.push(name) if value is minVal

    res = _.reduce res, (res, {name, value, time, timeZip, deflate}) ->
        res += "#{name}: #{value} (#{(value / base * 100).toFixed 2}%) #{(time + '').yellow}ms" +
            " ---- deflate: #{deflate}(#{(deflate / base * 100).toFixed 2}%) #{(timeZip + '').yellow}ms\n    "
        res
    , ''

    console.log """
    #{msg.cyan}:
        #{res}
        Best: #{(minValKey + '').green}
        Fast: #{(minTimeKey + '').green}

    """
ARR_SIZE = 200000

randomArray = require './random'

randomTimeStamp = ->
    base = Date.now()
    arr = []
    for i in [0...ARR_SIZE]
        arr.push base = base + randomArray.getRandom(0, 2) * 1000
    arr

randomIncrease = (step) ->
    base = 0
    arr = []
    for i in [0...ARR_SIZE]
        arr.push base = base + randomArray.getRandom(0, step)
    arr

slowly = (from, to) ->
    base = 0
    arr = []
    i = 0
    while i < ARR_SIZE
        increaseInterval = randomArray.getRandom(0, 10)
        base = base + randomArray.getRandom(from, to)
        for j in [0...increaseInterval]
            arr.push base
            i += 1

    arr

console.log "Array Size: ".blue, ARR_SIZE

report [0 ..ARR_SIZE], 'sequence from 0 to ARR_SIZE'
report (1000 for [0...ARR_SIZE]), "repeated sequence for 1000"
report randomArray(ARR_SIZE, 10, 100), "random array for small number(10, 100)"
report randomArray(ARR_SIZE, 100000, 100100), "random array for big number(100k, 100.1k)"
report randomArray(ARR_SIZE, 100000, 105000), "random array for big number(100k, 105k)"
report randomArray(ARR_SIZE, 0, 1000000), "pure random array for big number(0, 1000k)"
report randomTimeStamp(), "random increacing timestamp"
report randomIncrease(10), "random increacing integers by 0...10 from 0"
report randomIncrease(3), "random increacing integers by 0...3 from 0"
report slowly(-10, 10), "slowly changed integers"
report randomArray(ARR_SIZE, 0, 255), "Enums in large range"
report randomArray(ARR_SIZE, 0, 2), "Enums in small range"

kit.fs.readFile kit.path.join(__dirname, './data.txt'), encoding: 'utf-8'
.then (con) ->
    arr = con.split('\n').map (line) ->
        a = Number(line.trim())
    report arr, "high precision sensor data"

