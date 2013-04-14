#
# grunt-tusk
# https:#github.com/elentok/grunt-tusk
#
# Copyright (c) 2013 David Elentok
# Licensed under the MIT license.
#


'use strict'

module.exports = (grunt) ->

  Tusk = require './lib/tusk'
  tusk = new Tusk(grunt)

  tusk.coffee.add 'app.js',
    'test/fixtures/coffee/**/*.coffee'

  tusk.sass.add 'stylesheets-sass',
    'test/fixtures/stylesheets'

  tusk.stylus.add 'stylesheets-stylus',
    'test/fixtures/stylus'

  tusk.jade.add '', 'test/fixtures/pages'
  tusk.jade.add 'javascripts/templates.js', 'test/fixtures/templates'

  tusk.copy.add 'images', 'test/fixtures/images'
  tusk.copy.add 'file1.txt', 'test/fixtures/file1.txt'

  tusk.uglify.add 'app.min.js', ['app.js']

  config = tusk.getConfig()

  config.simplemocha =
    all: ['test/**/*_spec.coffee']
    options:
      globals: ['window']
      reporter: 'spec'
      ui: 'bdd'

  config.clean =
    tests: ['tmp']


  # Project configuration.
  grunt.initConfig(config)

  # These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-simple-mocha')

  # Whenever the "test" task is run, first clean the "tmp" dir, then run this
  # plugin's task(s), then test the result.
  grunt.registerTask('test', ['clean', 'tusk', 'simplemocha'])

  # By default, lint and run all tests.
  grunt.registerTask('default', ['test'])

