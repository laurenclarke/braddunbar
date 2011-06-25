_ = require 'underscore'
express = require 'express'

app = express.createServer()

app.configure ->
  app.use express.static __dirname + '/static',
    maxAge: 1000 * 60 * 60 * 24 * 14 # 2 weeks
  app.use express.bodyParser()
  app.set 'view engine', 'ejs'
  app.set 'host', 'braddunbar.net'
  app.set 'title', 'brad dunbar'
  app.set 'view options', {app, hash: require './static/hash'}

app.configure 'production', ->
  app.use express.logger()

app.get '/', (req, res) ->
  res.render 'index'

app.listen process.env.PORT || 8000
