path = require 'path'
fs = require 'fs'

module.exports = class NpmTaskLoader
  constructor: (@grunt) ->

  load: (task) ->
    @grunt.loadNpmTasks @_getTaskPath(task.package)
    if task.oldName? and task.newName?
      @grunt.renameTask(task.oldName, task.newName)


  _getTaskPath: (name) ->
    if fs.existsSync(path.join('node_modules', name))
      name
    else
      path.join('grunt-tusk', 'node_modules', name)

