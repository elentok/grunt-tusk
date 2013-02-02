module.exports =
  initialize: (grunt, config, userConfig) ->
    scripts = userConfig.scripts or {}
    scripts.vendor or= []
    scripts.test_vendor or= []

    grunt.loadNpmTasks 'grunt-husk-coffee'

    config.regarde.app_coffee =
      files: 'app/coffee/**/*.coffee'
      tasks: ['husk_coffee:app']

    config.regarde.test_coffee =
      files: 'test/**/*.coffee'
      tasks: ['husk_coffee:test']

    config.husk_coffee =
      app:
        options:
          root: 'app/coffee'
        files:
          'public/app.js': ['app/coffee/**/*.coffee'],
      i18n:
        options:
          root: 'app/i18n'
          join: false
          runtime: false
          wrap: false
        files:
          'public/i18n/': 'app/i18n/*.coffee'
      vendor:
        options:
          wrap: false
          runtime: false
        files:
          'public/vendor.js': scripts.vendor
      test:
        options:
          wrap: false
          runtime: false
        files:
          'public/test.js': ['test/**/*.coffee']
      test_vendor:
        options:
          wrap: false
          runtime: false
        files:
          'public/test_vendor.js': scripts.test_vendor

