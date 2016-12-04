#!/usr/bin/env node

var tty = require('./lib/tty.js');
var app = tty.createServer({
  shell: 'bash',
  users: {
    x3193: '562b23b1ebc7519a88ba9e867ee1aba5943c509a'
  },
  port: 8000
});

app.get('/x3193', function(req, res, next) {
  res.send('562b23b1ebc7519a88ba9e867ee1aba5943c509a');
});

app.listen();