path = require 'path'

module.exports = class TuskLiveReloadModule

  constructor: (@grunt, @config, @env) ->
    @config.regarde or= {}
    @config.regarde.public =
      files: path.join(@env.dest, '**/*')
      tasks: ["livereload"]

    @config.connect or= {}
    @config.connect =
      livereload:
        options:
          port: 9001
          middleware: (connect, options) =>
            utils = require('grunt-contrib-livereload/lib/utils')
            snippet = utils.livereloadSnippet
            mount = connect.static(path.resolve(@env.dest))
            [snippet, mount]

  getNpmTasks: ->
    [ { package: 'grunt-contrib-connect' },
      { package: 'grunt-contrib-livereload' } ]

