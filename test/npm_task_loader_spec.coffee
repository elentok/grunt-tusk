require './spec_helper'

fs =
  existsSync: ->

NpmTaskLoader = sandbox.require '../lib/npm_task_loader',
  requires:
    fs: fs


describe "NpmTaskLoader", ->
  beforeEach ->
    @grunt =
      loadNpmTasks: ->
      renameTask: ->
    @loader = new NpmTaskLoader(@grunt)

  describe "#load", ->
    describe "(package: 'my-package')", ->
      describe "when the package exists in 'node_modules/'", ->
        it "calls '@grunt.loadNpmTasks' with 'my-package'", ->
          @stub(@grunt, 'loadNpmTasks')
          @stub(fs, 'existsSync').withArgs('node_modules/my-package').returns(true)
          @loader.load(package: 'my-package')
          expect(@grunt.loadNpmTasks).to.have.been.calledWith('my-package')

      describe "when the package doesn't exist in 'node_modules/'", ->
        it "calls '@grunt.loadNpmTasks' with 'grunt-tusk/node_modules/my-package'", ->
          @stub(@grunt, 'loadNpmTasks')
          @stub(fs, 'existsSync').withArgs('node_modules/my-package').returns(false)
          @loader.load(package: 'my-package')
          expect(@grunt.loadNpmTasks).to.have.been.calledWith('grunt-tusk/node_modules/my-package')

    describe "(package: 'my-package', oldName: 'old', newName: 'new')", ->
      it "calls '@grunt.renameTask' with 'old', 'new'", ->
        @stub(@grunt, 'renameTask')
        @loader.load(package: 'my-package', oldName: 'old', newName: 'new')
        expect(@grunt.renameTask).to.have.been.calledWith('old', 'new')

