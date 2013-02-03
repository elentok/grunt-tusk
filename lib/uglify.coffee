fs = require 'fs'

module.exports =
  initialize: (grunt, config, userConfig) ->
    grunt.loadNpmTasks 'grunt-tusk/node_modules/grunt-contrib-uglify'

    files =
      'build/app.js': [
        'public/vendor.js',
        'public/templates.js',
        'public/i18n/en.js',
        'public/app.js']

    if grunt.file.isDir('app/i18n')
      for filename in fs.readdirSync('app/i18n')
        js_filename = filename.replace('.coffee', '.js')
        files["build/i18n/#{js_filename}"] = "public/i18n/#{js_filename}"

    config.uglify =
      production:
        files: files
