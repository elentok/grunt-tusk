require '../spec_helper'
TuskCoffeeModule = require '../../lib/modules/coffee'

describe "TuskCoffeeModule", ->
  beforeEach ->
    @grunt =
      loadNpmTasks: ->
    @config = {}
    @env = {
      dest: 'build/the-env'
    }
    @module = new TuskCoffeeModule(@grunt, @config, @env)

  describe "#add", ->
    it "adds an item to @config.tusk_coffee", ->
      @module.add('app.js', ['app/coffee/**/*.coffee'])
      expect(@config.tusk_coffee['app.js']).to.eql {
        options: {}
        files:
          'build/the-env/javascripts/app.js': ['app/coffee/**/*.coffee']
      }

    it "adds an item with options to @config.tusk_coffee", ->
      @module.add('app.js', ['app/coffee/**/*.coffee'],
        modulesRoot: 'app/coffee')
      expect(@config.tusk_coffee['app.js']).to.eql {
        options:
          modulesRoot: 'app/coffee'
        files:
          'build/the-env/javascripts/app.js': ['app/coffee/**/*.coffee']
      }

    it "adds an item to @config.watch", ->
      @module.add('app.js', ['app/coffee/**/*.coffee'],
        modulesRoot: 'app/coffee')
      expect(@config.watch['app.js']).to.eql {
        files: ['app/coffee/**/*.coffee']
        tasks: ['tusk_coffee:app.js']
      }

