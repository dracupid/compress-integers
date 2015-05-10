getRandom = (min, max) ->
    Math.round Math.random() * (max - min) + min

randomArray = (size = 100, from = 0, to = 1) ->
    arr = new Array size
    for i in [0...size]
        arr[i] = getRandom(from, to)

module.exports = randomArray
module.exports.getRandom = getRandom
