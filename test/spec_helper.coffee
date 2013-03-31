chai = require 'chai'
chai.use(require 'sinon-chai')

global.expect = chai.expect
global.sinon = require 'sinon'
global.sandbox = require 'sandboxed-module'

beforeEach ->
  @sinon = sinon.sandbox.create(
    injectInto: this,
    properties: ['spy', 'stub'])

afterEach ->
  @sinon.restore()

