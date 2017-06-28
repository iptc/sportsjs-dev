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

  var schemaDir = './';
  var coreSchemaName = 'sportsjs-core.json';
  var schema = JSON.parse(fs.readFileSync(schemaDir + coreSchemaName, "utf8"));

  fs.readdirSync(schemaDir).forEach(function(name) {
      if (name.indexOf('SportsJS') > -1) {
          var filePath = schemaDir + name;
          var subSchema = JSON.parse(fs.readFileSync(filePath), "utf8");
          ajv.addSchema(subSchema, subSchema.id);
          if (options.verbose == 'true') {
            console.log('Added ' + name);
            console.log('\t ' + subSchema.id);
          }
      }
  });

  var data  = JSON.parse(fs.readFileSync(options.file), "utf8");
  var valid = ajv.validate(schema, data);;

  if (valid) {
    console.log("Your sample is valid.");
  } else {
    console.log(ajv.errors);
  }

} else {
  console.error("Unable to load file for validation.");
}
