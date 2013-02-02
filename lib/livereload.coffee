module.exports =
  initialize: (grunt, config, userConfig) ->
    grunt.loadNpmTasks 'grunt-contrib-connect'
    grunt.loadNpmTasks 'grunt-contrib-livereload'

    config.regarde.public =
      files: 'public/**/*'
      tasks: ["livereload"]

    config.connect =
      livereload:
        options:
          port: 9001
          middleware: (connect, options) ->
            utils = require('grunt-contrib-livereload/lib/utils')
            snippet = utils.livereloadSnippet
            mount = connect.static(path.resolve('.'))
            [snippet, mount]
