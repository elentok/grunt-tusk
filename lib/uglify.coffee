fs = require 'fs'

module.exports =
  initialize: (grunt, config, userConfig) ->
    grunt.loadNpmTasks 'grunt-contrib-uglify'

    files =
      'build/app.js': [
        'public/vendor.js',
        'public/templates.js',
        'public/i18n/en.js',
        'public/app.js']

    for filename in fs.readdirSync('public/i18n')
      files["build/i18n/#{filename}"] = "public/i18n/#{filename}"

    config.uglify =
      production:
        files: files
