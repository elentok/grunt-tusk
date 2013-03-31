_ = require 'lodash'
env = require './env'
NpmTaskLoader = require './npm_task_loader'



#module.exports =
  #initialize: (grunt, userConfig = {}) ->

    #modules =
      #tusk_coffee: true
      #jade2html: true
      #jade2js: true
      #compass: true
      #livereload: true
      #copy: true
      #uglify: true

    #grunt.loadNpmTasks 'grunt-tusk/node_modules/grunt-regarde'

    #config =
      #regarde: userConfig.regarde or {}

    #for moduleName of modules
      #if modules[moduleName]
        #module = require "./#{moduleName}"
        #module.initialize(grunt, config, userConfig)

    #grunt.initConfig(config)
    #registerTasks(grunt)

module.exports = class Tusk
  constructor: (@grunt) ->
    @taskLoader = new NpmTaskLoader(@grunt)
    @env = env
    @_config =
      regarde: {}

    @plugins =
      jade2html: true
      jade2js: true
      livereload: true
      uglify: true

    @coffee = @_createModule('coffee')
    @copy = @_createModule('copy')
    @css = @_createModule('css')
    @jade = @_createModule('jade')
    @uglify = @_createModule('uglify')
    @livereload = @_createModule('livereload')

  _createModule: (name) ->
    module = new (require "./modules/#{name}")(@grunt, @_config, @env)
    if module.getNpmTasks?
      for task in module.getNpmTasks()
        @taskLoader.load(task)
    module

  registerTasks: ->
    unless _.isEmpty(@_config.regarde)
      @taskLoader.load(package: 'grunt-regarde')
    buildTasks = ['tusk_coffee', 'compass', 'jade2html', 'jade2js', 'copy', 'uglify']
    buildTasks = _.filter buildTasks, (task) => @_config[task]?

    console.log "Registering tasks #{buildTasks}"

    @grunt.registerTask 'tusk', buildTasks
    @grunt.registerTask 'tusk_live',
      ['tusk', 'livereload-start', 'connect', 'regarde']


  getConfig: ->
    @registerTasks()
    @_config
