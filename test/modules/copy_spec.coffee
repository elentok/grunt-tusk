require '../spec_helper'
TuskCopyModule = require '../../lib/modules/copy'

describe "TuskCopyModule", ->
  beforeEach ->
    @grunt =
      loadNpmTasks: ->
    @config = {}
    @env =
      current: 'dev'
      dest: 'build/the-env'
    @plugin = new TuskCopyModule(@grunt, @config, @env)

  describe "#add", ->
    it "adds an item to @config.copy", ->
      @plugin.add('images', 'app/images')
      expect(@config.copy['app/images']).to.eql {
        files: [{
          expand: true
          cwd: 'app/images'
          dest: 'build/the-env/images'
          src: '**/*'
        }]
      }

    it "adds an item with a filter to @config.copy", ->
      @plugin.add('images', 'app/images', filter: '*.png')
      expect(@config.copy['app/images']).to.eql {
        files: [{
          expand: true
          cwd: 'app/images'
          dest: 'build/the-env/images'
          src: '*.png'
        }]
      }

    it "adds an item to @config.regarde", ->
      @plugin.add('images', 'app/images')
      expect(@config.regarde['app/images']).to.eql {
        files: 'app/images/**/*'
        tasks: ["copy:app/images"]
      }


