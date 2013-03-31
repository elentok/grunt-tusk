path = require 'path'

module.exports = class TuskCopyModule
  constructor: (@grunt, @config, @env) ->
  
  getNpmTasks: -> [package: 'grunt-contrib-copy']

  add: (dest, source, options = {}) ->
    filter = options.filter or '**/*'

    if @grunt.file.isDir(source)
      file =
        expand: true
        cwd: source
        dest: path.join(@env.dest, dest)
        src: filter
    else
      file =
        dest: path.join(@env.dest, dest)
        src: source

    @config.copy or= {}
    @config.copy[source] = {
      files: [file]
    }

    @config.regarde or= {}
    @config.regarde[source] = {
      files: path.join(source, filter)
      tasks: ["copy:#{source}"]
    }
