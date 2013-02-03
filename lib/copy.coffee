path = require 'path'

module.exports =
  initialize: (grunt, config, userConfig) ->
    grunt.loadNpmTasks 'grunt-tusk/node_modules/grunt-contrib-copy'
    config.regarde.images =
      files: 'app/images/**/*'
      tasks: ["copy"]

    copy = userConfig.copy || []
    copy.push({
      source: 'app/images',
      dest: 'images'
    })

    dev_files = []
    production_files = []

    for pair in copy
      dev_files.push({
        expand: true
        cwd: pair.source
        dest: path.join('public', pair.dest)
        src: pair.filter or '**'
      })
      production_files.push({
        expand: true
        cwd: pair.source
        dest: path.join('build', pair.dest)
        src: pair.filter or '**'
      })

    config.copy =
      dev:
        files: dev_files
      production:
        files: production_files
