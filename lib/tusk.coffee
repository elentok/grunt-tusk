_ = require 'lodash'
env = require './env'
NpmTaskLoader = require './npm_task_loader'

module.exports = class Tusk
  constructor: (@grunt) ->
    @taskLoader = new NpmTaskLoader(@grunt)
    @env = env
    @_config =
      watch: {}

    @plugins =
      jade2html: true
      jade2js: true
      livereload: true
      uglify: true

    @coffee = @_createModule('coffee')
    @copy = @_createModule('copy')
    @sass = @_createModule('sass')
    @stylus = @_createModule('stylus')
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
    unless _.isEmpty(@_config.watch)
      @taskLoader.load(package: 'grunt-contrib-watch')
    buildTasks = ['tusk_coffee', 'compass', 'stylus', 'jade2html', 'jade2js', 'copy', 'uglify']
    buildTasks = _.filter buildTasks, (task) => @_config[task]?

    console.log "Registering tasks #{buildTasks}"

    @grunt.registerTask 'tusk', buildTasks
    @grunt.registerTask 'tusk_live',
      ['tusk', 'connect', 'watch']

  getConfig: ->
    @registerTasks()
    @_config
