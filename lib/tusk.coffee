registerTasks = (grunt) ->
  grunt.registerTask 'tusk_dev',
    ['tusk_coffee', 'compass:dev', 'jade2html:dev', 'jade2js', 'copy:dev']

  grunt.registerTask 'tusk_production',
    ['tusk_coffee', 'compass:production', 'jade2html:production', 'jade2js',
      'copy:production', 'uglify']

  grunt.registerTask 'tusk_live',
    ['livereload-start', 'connect', 'regarde']


module.exports =
  initialize: (grunt, userConfig = {}) ->

    modules =
      tusk_coffee: true
      jade2html: true
      jade2js: true
      compass: true
      livereload: true
      copy: true
      uglify: true

    grunt.loadNpmTasks 'grunt-tusk/node_modules/grunt-regarde'

    config =
      regarde: userConfig.regarde or {}

    for moduleName of modules
      if modules[moduleName]
        module = require "./#{moduleName}"
        module.initialize(grunt, config, userConfig)

    grunt.initConfig(config)
    registerTasks(grunt)



