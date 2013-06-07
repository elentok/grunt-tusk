_ = require 'lodash'
path = require 'path'

module.exports = class TuskSassModule
  constructor: (@grunt, @config, @env) ->

  getNpmTasks: -> [package: 'grunt-contrib-compass']

  add: (dest, source, options = {}) ->
    defaults =
      sassDir: source,
      cssDir: path.join(@env.dest, dest),
      imagesDir: '.',
      importPath: 'components'
    options = _.extend(defaults, options)
    @config.compass or= {}
    @config.compass[source] =
      options: options

    @config.watch or= {}
    @config.watch[source] =
      files: path.join(source, '**/*')
      tasks: ["compass:#{source}"]



