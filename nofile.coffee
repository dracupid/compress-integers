kit = require 'nokit'
_ = kit._
drives = kit.require 'drives'
$ = require('dracupid-no')(kit)

module.exports = (task) ->
    task 'build', "Build Project", (opts) ->
        $.coffee()

    # task 'doc', ->
    #     {generate: gen} = require 'nodoc'
    #     data = {}

    #     kit.Promise.all [gen('./src/Encoder.coffee'), gen('./src/Decoder.coffee'), kit.readFile('./src/Readme.tpl', encoding: 'utf8')]
    #     .then ([api1, api2, tpl]) ->
    #         _.template(tpl) {api: api1 + api2}
    #     .then (md)->
    #         kit.writeFile 'Readme.md', md

    task 'test', ->
        $.mocha()

    task 'compare', ->
        kit.spawn 'coffee', ['./test/compare.coffee']
        .catch ->
            process.exit 1

    task 'default', ['build']
