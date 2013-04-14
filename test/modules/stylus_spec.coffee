require '../spec_helper'
TuskStylusModule = require '../../lib/modules/stylus'

describe "TuskStylusModule", ->
  beforeEach ->
    @grunt =
      loadNpmTasks: ->
    @config = {}
    @env =
      current: 'dev'
      dest: 'build/the-env'
    @module = new TuskStylusModule(@grunt, @config, @env)

  describe "#add", ->
    it "adds a directory to @config.stylus", ->
      @module.add('stylesheets', 'test/fixtures/stylus',
        { key1: 'value1' })
      expect(@config.stylus['test/fixtures/stylus']).to.eql {
        options:
          compress: false
          'include css': true
          paths: ['components']
          key1: 'value1'
        files:
          'build/the-env/stylesheets/file1.css':
            'test/fixtures/stylus/file1.styl'
          'build/the-env/stylesheets/file3.css':
            'test/fixtures/stylus/file3.styl'
      }

    it "adds an item to @config.regarde", ->
      @module.add('stylesheets', 'test/fixtures/stylus')
      expect(@config.regarde['test/fixtures/stylus']).to.eql {
        files: 'test/fixtures/stylus/**/*.styl'
        tasks: ["stylus:test/fixtures/stylus"]
      }

  #_getFiles: (dir, dest) ->
    #files = {}
    #for filename in fs.readdirSync(dir)
      #continue unless /.jade$/.test(filename)
      #continue if /^_/.test(filename)
      #html_filename = filename.replace('.jade', '.html')
      #key = path.join(@env.dest, dest, html_filename)
      #files[key] = path.join(dir, filename)
    #files

