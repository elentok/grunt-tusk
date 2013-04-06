fs = require 'fs'
path = require 'path'
_ = require 'lodash'

module.exports = class TuskJadeModule

  getNpmTasks: -> [
    {package: 'grunt-contrib-jade', oldName: 'jade', newName: 'jade2html'},
    {package: 'grunt-jade-plugin', oldName: 'jade', newName: 'jade2js'}]

  constructor: (@grunt, @config, @env) ->

  add: (dest, source, options = {}) ->
    if /\.js$/.test(dest)
      @_addTemplates(dest, source, options)
      taskName = "jade2js"
    else
      @_addPages(dest, source, options)
      taskName = "jade2html"

    regarde_files = source
    regarde_files = path.join(source, '**/*.jade') if @grunt.file.isDir(source)
    @config.regarde or= {}
    @config.regarde[source] =
      files: [regarde_files]
      tasks: ["#{taskName}:#{source}"]

  _addTemplates: (dest, source, options = {})->
    defaults =
      includeRuntime: true
      namespace: 'JST'

    if @grunt.file.isDir(source)
      defaults.processName = (filepath) ->
        filepath.substring(source.length + 1).replace(/\.jade$/, '')

    options = _.extend(defaults, options)

    files = {}
    key = path.join(@env.dest, dest)
    if @grunt.file.isDir(source)
      files[key] = path.join(source, '**/*.jade')
    else
      files[key] = source

    @config.jade2js or= {}
    @config.jade2js[source] = { options: options, files: files }

  _addPages: (dest, source, options = {})->
    defaults =
      pretty: true

    options = _.extend(defaults, options)

    files = {}
    if @grunt.file.isDir(source)
      files = @_getFiles(source, dest)
    else
      key = path.join(@env.dest, dest)
      files[key] = source

    @config.jade2html or= {}
    @config.jade2html[source] = { options: options, files: files }

  _getFiles: (dir, dest) ->
    files = {}
    for filename in fs.readdirSync(dir)
      continue unless /.jade$/.test(filename)
      continue if /^_/.test(filename)
      html_filename = filename.replace('.jade', '.html')
      key = path.join(@env.dest, dest, html_filename)
      files[key] = path.join(dir, filename)
    files

    #config.regarde.jade2html =
      #files: ['app/pages/**/*.jade', 'test/*.jade']
      #tasks: ['jade2html:dev']

    #dev_files =
      #'public/test.html': 'test/test.jade'
    #production_files = {}


    #config.jade2html =
      #dev:
        #options:
          #pretty: true
          #data:
            #debug: true
            #javascripts: ['javascripts/vendor.js', 'javascripts/templates.js', 'javascripts/i18n/en.js', 'javascripts/app.js']
        #files: dev_files
      #production:
        #options:
          #data:
            #debug: false
            #javascripts: ['app.js']
        #files: production_files
