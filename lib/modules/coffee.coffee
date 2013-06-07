module.exports = class TuskCoffeeModule
  constructor: (@grunt, @config, @env) ->

  getNpmTasks: -> [package: 'grunt-tusk-coffee']

  add: (filename, sources, options = {}) ->
    files = {}
    files["#{@env.dest}/javascripts/#{filename}"] = sources
    @config.tusk_coffee or= {}
    @config.tusk_coffee[filename] = {
      options: options,
      files: files
    }

    @config.watch or = {}
    @config.watch[filename] = {
      files: sources,
      tasks: ["tusk_coffee:#{filename}"]
    }

# settings for i18n:
        #options:
          #root: 'app/i18n'
          #join: false
          #runtime: false
          #wrap: false
        #files:
          #'public/javascripts/i18n/': 'app/i18n/*.coffee'
