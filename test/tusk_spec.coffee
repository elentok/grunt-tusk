Tusk = require '../lib/tusk'

expect = (require 'chai').expect

describe "Tusk", ->
  beforeEach ->
    @grunt =
      loadNpmTasks: ->
      registerTask: ->
      renameTask: ->
    @tusk = new Tusk(@grunt)

  describe "#env", ->
    it "returns the current environment hash", ->
      expect(@tusk.env).to.eql {
        current: 'dev',
        dest: 'build/dev'
      }

  describe "coffee", ->
    it "returns the coffee module", ->
      expect(@tusk.coffee.constructor.name).to.equal 'TuskCoffeeModule'

  describe "copy", ->
    it "returns the copy module", ->
      expect(@tusk.copy.constructor.name).to.equal 'TuskCopyModule'

  describe "css", ->
    it "returns the css module", ->
      expect(@tusk.css.constructor.name).to.equal 'TuskCssModule'

  describe "jade", ->
    it "returns the jade module", ->
      expect(@tusk.jade.constructor.name).to.equal 'TuskJadeModule'