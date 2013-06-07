_ = require 'lodash'
path = require 'path'
fs = require 'fs'

module.exports = class TuskStylusModule
  constructor: (@grunt, @config, @env) ->
    
  getNpmTasks: -> [package: 'grunt-contrib-stylus']

  add: (dest, source, options = {}) ->
    options = @_getOptions(options)
    dest = path.join(@env.dest, dest)
    
    @config.stylus or= {}
    @config.stylus[source] =
      options: options
      files: @_getFiles(dest, source)

    @config.watch or= {}
    @config.watch[source] =
      files: path.join(source, '**/*.styl')
      tasks: ["stylus:#{source}"]

  _getOptions: (options = {}) ->
    defaults =
      compress: false
      'include css': true
      paths: ['components']
    _.extend({}, defaults, options)

  _getFiles: (dest, source) ->
    files = {}
    for filename in fs.readdirSync(source)
      continue unless /.styl/.test(filename)
      continue if /^_/.test(filename)
      css_filename = filename.replace('.styl', '.css')
      key = path.join(dest, css_filename)
      files[key] = path.join(source, filename)
    files
