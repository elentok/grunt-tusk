path = require 'path'

module.exports = class TuskCopyModule
  constructor: (@grunt, @config, @env) ->
  
  getNpmTasks: -> [package: 'grunt-contrib-copy']

  add: (dest, source, options = {}) ->
    filter = options.filter or '**/*'
    @config.copy or= {}
    @config.copy[source] = {
      files: [{
        expand: true
        cwd: source
        dest: path.join(@env.dest, dest)
        src: filter
      }]
    }

    @config.regarde or= {}
    @config.regarde[source] = {
      files: path.join(source, filter)
      tasks: ["copy:#{source}"]
    }
