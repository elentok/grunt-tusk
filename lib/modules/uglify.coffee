path = require 'path'
_ = require 'lodash'

module.exports = class TuskUglifyModule
  constructor: (@grunt, @config, @env) ->
    
  getNpmTasks: -> [package: 'grunt-contrib-uglify']

  add: (dest, source, options = {}) ->
    full_dest = path.join(@env.dest, 'javascripts', dest)

    full_source = _.map source, (s) => path.join(@env.dest, 'javascripts', s)
    files = {}
    files[full_dest] = full_source

    @config.uglify or= {}
    @config.uglify[dest] =
      options: options
      files: files

    @config.regarde or= {}
    @config.regarde[dest] =
      files: full_source
      tasks: ["uglify:#{dest}"]



#module.exports =
  #initialize: (grunt, config, userConfig) ->
    #grunt.loadNpmTasks 'grunt-tusk/node_modules/grunt-contrib-uglify'

    #files =
      #'build/app.js': [
        #'public/vendor.js',
        #'public/templates.js',
        #'public/i18n/en.js',
        #'public/app.js']

    #if grunt.file.isDir('app/i18n')
      #for filename in fs.readdirSync('app/i18n')
        #js_filename = filename.replace('.coffee', '.js')
        #files["build/i18n/#{js_filename}"] = "public/i18n/#{js_filename}"

    #config.uglify =
      #production:
        #files: files
