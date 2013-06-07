require '../spec_helper'
TuskUglifyModule = require '../../lib/modules/uglify'

describe "TuskUglifyModule", ->
  beforeEach ->
    @grunt =
      loadNpmTasks: ->
    @config = {}
    @env =
      current: 'dev'
      dest: 'build/the-env'
    @module = new TuskUglifyModule(@grunt, @config, @env)

  describe "#add", ->
    it "adds an item to @config.uglify", ->
      @module.add('app.min.js', ['vendor.js', 'templates.js', 'app.js'], { option1: 'value1' })
      expect(@config.uglify['app.min.js']).to.eql {
        options:
          option1: 'value1'
        files:
          'build/the-env/javascripts/app.min.js': [
            'build/the-env/javascripts/vendor.js',
            'build/the-env/javascripts/templates.js',
            'build/the-env/javascripts/app.js']
      }

    it "adds an item to @config.watch", ->
      @module.add('app.min.js', ['vendor.js', 'templates.js', 'app.js'])
      expect(@config.watch['app.min.js']).to.eql {
        files: [
          'build/the-env/javascripts/vendor.js',
          'build/the-env/javascripts/templates.js',
          'build/the-env/javascripts/app.js']
        tasks: ["uglify:app.min.js"]
      }


