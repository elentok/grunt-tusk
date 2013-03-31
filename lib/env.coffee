env = process.env['ENV'] or 'dev'

module.exports =
  current: env
  dest: "build/#{env}"
