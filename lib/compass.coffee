module.exports =
  initialize: (grunt, config, userConfig) ->
    grunt.loadNpmTasks 'grunt-tusk/node_modules/grunt-compass'
    config.regarde.app_compass =
      files: 'app/stylesheets/**/*.scss'
      tasks: ['compass:dev']

    config.compass =
      dev:
        src: 'app/stylesheets'
        dest: 'public'
        images: '.'
        importPath: 'components'
      production:
        outputstyle: 'compressed'
        src: 'app/stylesheets'
        dest: 'build'
        images: '.'
        importPath: 'components'

