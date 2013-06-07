path = require 'path'

getLiveReloadMiddleware = ->
  LiveReload = require('connect-livereload')
  new LiveReload()

module.exports = class TuskLiveReloadModule

  constructor: (@grunt, @config, @env) ->
    @config.watch or= {}
    @config.watch.options =
      livereload: true
    @config.watch.public =
      files: path.join(@env.dest, '**/*')
      options:
        livereload: true

    @config.connect or= {}
    @config.connect =
      livereload:
        options:
          port: 9001
          middleware: (connect, options) =>
            liveReload = getLiveReloadMiddleware()
            staticFiles = connect.static(path.resolve(@env.dest))
            [liveReload, staticFiles]

  getNpmTasks: ->
    [ { package: 'grunt-contrib-connect' } ]

