module.exports =
  initialize: (grunt, config, userConfig) ->
    grunt.loadNpmTasks 'grunt-tusk/node_modules/grunt-jade-plugin'
    grunt.renameTask('jade', 'jade2js')

    config.regarde.jade2js =
      files: ['app/templates/**/*.jade']
      tasks: ['jade2js']

    config.jade2js =
      app:
        options:
          namespace: 'JST'
        files:
          'public/javascripts/templates.js': 'app/templates/**/*.jade'

