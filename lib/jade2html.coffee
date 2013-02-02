fs = require 'fs'

module.exports =
  initialize: (grunt, config, userConfig) ->
    grunt.loadNpmTasks 'grunt-contrib-jade'
    grunt.renameTask('jade', 'jade2html')

    config.regarde.jade2html =
      files: ['app/pages/**/*.jade', 'test/*.jade']
      tasks: ['jade2html:dev']

    dev_files =
      'public/test.html': 'test/test.jade'
    production_files = {}

    for filename in fs.readdirSync('app/pages')
      continue if /.jade$/.test(filename)
      html_filename = file.replace('.jade', '.html')
      dev_files["public/#{html_filename}"] = "app/pages/#{html_filename}"
      production_files["build/#{html_filename}"] = "app/pages/#{html_filename}"

    config.jade2html =
      dev:
        options:
          pretty: true
          data:
            debug: true
            javascripts: ['vendor.js', 'templates.js', 'i18n/en.js', 'app.js']
        files: dev_files
      production:
        options:
          data:
            debug: false
            javascripts: ['app.js']
        files: production_files
