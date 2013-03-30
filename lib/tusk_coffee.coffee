module.exports =
  initialize: (grunt, config, userConfig) ->
    scripts = userConfig.scripts or {}
    scripts.vendor or= []
    scripts.test_vendor or= []
    scripts.extra or= {}

    grunt.loadNpmTasks 'grunt-tusk/node_modules/grunt-tusk-coffee'

    config.regarde.app_coffee =
      files: 'app/coffee/**/*.coffee'
      tasks: ['tusk_coffee:app']

    config.regarde.test_coffee =
      files: 'test/**/*.coffee'
      tasks: ['tusk_coffee:test']

    config.tusk_coffee =
      app:
        options:
          root: 'app/coffee'
        files:
          'public/javascripts/app.js': ['app/coffee/**/*.coffee'],
      i18n:
        options:
          root: 'app/i18n'
          join: false
          runtime: false
          wrap: false
        files:
          'public/javascripts/i18n/': 'app/i18n/*.coffee'
      vendor:
        options:
          wrap: false
          runtime: false
        files:
          'public/javascripts/vendor.js': scripts.vendor
      test:
        options:
          wrap: 'Function'
          runtime: false
        files:
          'public/javascripts/test.js': [
            'test/spec_helper.coffee',
            'test/**/*.coffee'
          ]
      test_vendor:
        options:
          wrap: false
          runtime: false
        files:
          'public/javascripts/test_vendor.js': scripts.test_vendor

    for own pkgName, pkg of scripts.extra
      config.tusk_coffee[pkgName] = pkg
      i = 0
      for own output, files of pkg.files
        config.regarde["#{pkgName}_coffee_#{i++}"] =
          files: files
          tasks: ["tusk_coffee:#{pkgName}"]
