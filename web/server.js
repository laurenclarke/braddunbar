var _ = require('underscore'),
  express = require('express'),

  app = express.createServer();

app.configure(function(){
  app.use(express.static(__dirname + '/static'));
  app.use(express.bodyParser());
  app.set('view engine', 'ejs');
  app.set('host', 'braddunbar.net');
  app.set('title', 'brad dunbar');
  app.set('view options', {
    app: app,
    hash: require('./static/hash')
  });
});

app.configure('production', function(){
  app.use(express.logger());
});

app.get('/', function(req, res){
  res.render('index');
});

app.listen(process.env.PORT || 8000);
