async = require 'async'
require './env'
app = require '../index'

require('orm').connect process.env.DATABASE_URL, (err, db) ->
  throw err if err
  require('./models') app, db, (err, models) ->
    throw err if err
    models = (model for name, model of models when name.match /^[A-Z]/)

    seed = (model, callback) ->
      model._seed callback

    done = (err) ->
      if err
        console.error "Error:", err
        process.exit 1
      else
        console.log "All done"
        process.exit 0

    async.mapSeries models, seed, done
