require '../spec_helper'
TuskJadeModule = require '../../lib/modules/jade'

describe "TuskJadeModule", ->
  beforeEach ->
    @grunt =
      loadNpmTasks: ->
      renameTask: ->
      file:
        isDir: ->
    @config = {}
    @env = {
      dest: 'build/the-env'
    }
    @module = new TuskJadeModule(@grunt, @config, @env)

  describe "#add", ->
    describe "for a single file html", ->
      beforeEach ->
        @stub(@grunt.file, 'isDir').withArgs('test/fixtures/pages/page.jade').returns(false)
        @module.add('page.html', 'test/fixtures/pages/page.jade')

      it "adds a file to @config.jade2html", ->
        settings = @config.jade2html['test/fixtures/pages/page.jade']
        expect(settings.files).to.eql {
          'build/the-env/page.html': 'test/fixtures/pages/page.jade'
        }

      it "adds an item to @config.regarde", ->
        expect(@config.regarde['test/fixtures/pages/page.jade']).to.eql {
          files: ['test/fixtures/pages/page.jade']
          tasks: ['jade2html:test/fixtures/pages/page.jade']
        }

    describe "for a directory of html files", ->
      beforeEach ->
        @stub(@grunt.file, 'isDir').withArgs('test/fixtures/pages').returns(true)
        @module.add('', 'test/fixtures/pages')

      it "adds an item to @config.jade2html (only files not starting with '_')", ->
        settings = @config.jade2html['test/fixtures/pages']
        expect(settings.files).to.eql {
          'build/the-env/page.html': 'test/fixtures/pages/page.jade'
          'build/the-env/page2.html': 'test/fixtures/pages/page2.jade'
        }
        expect(settings.options.client).not.to.exist
        expect(settings.options.processName).not.to.exist

      it "adds an item to @config.regarde)", ->
        expect(@config.regarde['test/fixtures/pages']).to.eql {
          files: ['test/fixtures/pages/**/*.jade']
          tasks: ['jade2html:test/fixtures/pages']
        }

    describe "for templates", ->
      beforeEach ->
        @stub(@grunt.file, 'isDir').withArgs('test/fixtures/templates').returns(true)
        @module.add('templates.js', 'test/fixtures/templates')

      it "adds an item to @config.jade2js", ->
        settings = @config.jade2js['test/fixtures/templates']
        expect(settings.files).to.eql {
          'build/the-env/templates.js': 'test/fixtures/templates/**/*.jade'
        }
        expect(settings.options.includeRuntime).to.be.true
        expect(settings.options.namespace).to.equal 'JST'
        expect(settings.options.processName).to.be.a 'function'

      it "adds an item to @config.regarde", ->
        expect(@config.regarde['test/fixtures/templates']).to.eql {
          files: ['test/fixtures/templates/**/*.jade']
          tasks: ['jade2js:test/fixtures/templates']
        }
