#
# grunt-husk
# https:#github.com/elentok/grunt-husk
#
# Copyright (c) 2013 David Elentok
# Licensed under the MIT license.
#


'use strict'

module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    simplemocha:
      all: ['test/**/*_spec.coffee']
      options:
        globals: ['window']
        reporter: 'spec'
        ui: 'bdd'

  # Actually load this plugin's task(s).
  grunt.loadTasks('tasks')

  # These plugins provide necessary tasks.
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-simple-mocha')

  # Whenever the "test" task is run, first clean the "tmp" dir, then run this
  # plugin's task(s), then test the result.
  grunt.registerTask('test', ['clean', 'simplemocha'])

  # By default, lint and run all tests.
  grunt.registerTask('default', ['test'])

