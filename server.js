var http = require('http');
var fs = require('fs');

const PORT = '3000';

const MIMES = {
  'html': 'text/html',
  'js': 'text/javascript',
  'css': 'text/css',
};

var mimeType = function(filename) {
  var match = filename.match(/\.([^\.]+)$/);
  var extension = match && match[1];

  var mime = MIMES[extension] || MIMES['html'];

  return `${mime}; charset=utf-8`;
};

var finalize = function(response, code, headers, data) {
  response.writeHead(code, headers);
  response.end(data);
};

var absolutePath = function(path) {
  return `${__dirname}/web` + path;
};

var server = http.createServer(function(request, response) {
  var path = request.url;
  var mime = mimeType(path);
  var filename;
  var method = request.method;

  console.log(`${request.method}: ${path}`);

  if (method !== 'GET') {
    finalize(response, 404);
    return;
  }

  if (path === '/') {
    path = '/index.html';
  }

  filename = absolutePath(path);

  fs.readFile(filename, function(err, data) {
    if (err) {
      finalize(response, 404);
      return;
    }

    finalize(response, 200, {'ContentType': mime}, data);
  });
});

server.listen(PORT);

console.log(`Server listening on ${PORT}`);
