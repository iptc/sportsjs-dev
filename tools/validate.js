'use strict';

var options = require('minimist')(process.argv.slice(2));
console.dir(options);

var fs = require('fs');

var tv4 = require('tv4');
var path = require('path');

if (options.file != null) {
  var sample  = fs.readFileSync(options.file);
  var schemaDir = '../specification/';
  var core = fs.readFileSync(schemaDir + 'SportsJS-Core.json');
  fs.readdirSync(schemaDir).forEach(function(name) {
      if (name.indexOf('SportsJS') > -1) {
          var filePath = path.join(schemaDir, name);
          console.log('Adding ' + name);
          tv4.addSchema(name, require(filePath));
      }
  });

  var result =  tv4.validateMultiple(sample, core, true, true);
  console.log(JSON.stringify(result, null, 4));
} else {
  console.error("Unable to load file for validation.");
}
