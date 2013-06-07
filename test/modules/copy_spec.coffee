require '../spec_helper'
TuskCopyModule = require '../../lib/modules/copy'

describe "TuskCopyModule", ->
  beforeEach ->
    @grunt =
      loadNpmTasks: ->
      file:
        isDir: -> true
    @config = {}
    @env =
      current: 'dev'
      dest: 'build/the-env'
    @plugin = new TuskCopyModule(@grunt, @config, @env)

  describe "#add", ->
    describe "for a single file", ->
      it "adds an item to @config.copy", ->
        @stub(@grunt.file, 'isDir').withArgs('app/manifest.json').returns(false)
        @plugin.add('manifest.json', 'app/manifest.json')
        expect(@config.copy['app/manifest.json']).to.eql {
          files: [{
            dest: 'build/the-env/manifest.json'
            src: 'app/manifest.json'
          }]
        }

    describe "for directory", ->
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

      it "adds an item to @config.watch", ->
        @plugin.add('images', 'app/images')
        expect(@config.watch['app/images']).to.eql {
          files: 'app/images/**/*'
          tasks: ["copy:app/images"]
        }


