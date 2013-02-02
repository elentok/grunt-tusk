registerTasks = (grunt) ->
  grunt.registerTask 'husk_dev',
    ['husk_coffee', 'compass:dev', 'jade2html:dev', 'jade2js', 'copy:dev']

  grunt.registerTask 'husk_production',
    ['husk_coffee', 'compass:production', 'jade2html:production', 'jade2js', 'copy:production', 'uglify']

  grunt.registerTask 'husk_live',
    ['livereload-start', 'connect', 'regarde']


module.exports =
  initialize: (grunt, userConfig = {}) ->

    modules =
      husk_coffee: true
      jade2html: true
      jade2js: true
      compass: true
      livereload: true
      copy: true
      uglify: true

    grunt.loadNpmTasks 'grunt-regarde'

    config =
      regarde: {}

    for moduleName of modules
      if modules[moduleName]
        module = require "./#{moduleName}"
        module.initialize(grunt, config, userConfig)

    grunt.initConfig(config)
    registerTasks(grunt)



