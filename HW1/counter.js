var uri = document.location.search;
var uriDecoded = decodeURI(uri).toLowerCase();
var uriRegex = uriDecoded.replace(/[^a-z0-9]/, '');

var counter = {};

for (var i = 0; i < uriRegex.length; i++) {
  if (uriRegex[i] in counter) {
    counter[uriRegex[i]] += 1;
  }
  else {
    counter[uriRegex[i]] = 1;
  }
}