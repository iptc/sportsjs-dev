'use strict';

var fs = require('fs');
var Ajv = require('ajv');

var ajvOps = {
  allErrors: true,
  verbose: true
}

var ajv = new Ajv(ajvOps);

var options = require('minimist')(process.argv.slice(2));

if (options.file != null) {

  var schemaDir = '../specification/';
  var coreSchemaName = 'SportsJS-Core.json';
  var schema = JSON.parse(fs.readFileSync(schemaDir + coreSchemaName, "utf8"));

  fs.readdirSync(schemaDir).forEach(function(name) {
      if (name.indexOf('SportsJS') > -1) {
          var filePath = schemaDir + name;
          var subSchema = JSON.parse(fs.readFileSync(filePath), "utf8");
          ajv.addSchema(subSchema, name);
          if (options.verbose == 'true') {
            console.log('Added ' + name);
            console.log('\t ' + subSchema.id);
          }
      }
  });

  console.log(JSON.stringify(ajv.getSchema("http://www.iptc.org/std/sportsjs/sportsjs-sport-extensions_1.0.draft.json#"), null, 4));
  var data  = fs.readFileSync(options.file);
  var valid = ajv.validate(schema, data);;

  if (valid) {
    console.log("Your sample is valid.");
  } else {
    console.log("Errors:" + JSON.stringify(ajv.errors, null, 4));
  }

} else {
  console.error("Unable to load file for validation.");
}
