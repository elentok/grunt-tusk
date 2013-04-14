require '../spec_helper'
TuskSassModule = require '../../lib/modules/sass'

describe "TuskSassModule", ->
  beforeEach ->
    @grunt =
      loadNpmTasks: ->
    @config = {}
    @env =
      current: 'dev'
      dest: 'build/the-env'
    @module = new TuskSassModule(@grunt, @config, @env)

  describe "#add", ->
    it "adds an item to @config.compass", ->
      @module.add('stylesheets', 'app/stylesheets')
      expect(@config.compass['app/stylesheets']).to.eql {
        options:
          sassDir: 'app/stylesheets',
          cssDir: 'build/the-env/stylesheets',
          imagesDir: '.'
          importPath: 'components'
      }

    it "adds an item with a different images path to @config.copy", ->
      @module.add('stylesheets', 'app/stylesheets', imagesDir: '../')
      expect(@config.compass['app/stylesheets']).to.eql {
        options:
          sassDir: 'app/stylesheets',
          cssDir: 'build/the-env/stylesheets',
          imagesDir: '../'
          importPath: 'components'
      }

    it "adds an item with a different import path to @config.copy", ->
      @module.add('stylesheets', 'app/stylesheets', importPath: 'other')
      expect(@config.compass['app/stylesheets']).to.eql {
        options:
          sassDir: 'app/stylesheets',
          cssDir: 'build/the-env/stylesheets',
          imagesDir: '.'
          importPath: 'other'
      }


    it "adds an item to @config.regarde", ->
      @module.add('stylesheets', 'app/stylesheets')
      expect(@config.regarde['app/stylesheets']).to.eql {
        files: 'app/stylesheets/**/*'
        tasks: ["compass:app/stylesheets"]
      }


