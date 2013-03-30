fs = require 'fs'

module.exports =
  initialize: (grunt, config, userConfig) ->
    grunt.loadNpmTasks 'grunt-tusk/node_modules/grunt-contrib-jade'
    grunt.renameTask('jade', 'jade2html')

    config.regarde.jade2html =
      files: ['app/pages/**/*.jade', 'test/*.jade']
      tasks: ['jade2html:dev']

    dev_files =
      'public/test.html': 'test/test.jade'
    production_files = {}

    if grunt.file.isDir('app/pages')
      for filename in fs.readdirSync('app/pages')
        continue unless /.jade$/.test(filename)
        continue if /^_/.test(filename)
        html_filename = filename.replace('.jade', '.html')
        dev_files["public/#{html_filename}"] = "app/pages/#{filename}"
        production_files["build/#{html_filename}"] = "app/pages/#{filename}"

    config.jade2html =
      dev:
        options:
          pretty: true
          data:
            debug: true
            javascripts: ['javascripts/vendor.js', 'javascripts/templates.js', 'javascripts/i18n/en.js', 'javascripts/app.js']
        files: dev_files
      production:
        options:
          data:
            debug: false
            javascripts: ['app.js']
        files: production_files
