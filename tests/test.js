'use strict';

var $RefParser = require('json-schema-ref-parser');
var $Validator = require('jsonschema').Validator;

var validator = new $Validator();
var core = require('../schema/SportsInJSON.json');

$RefParser.dereference(core, function(err, schema) {
    if (err) {
        console.error(err);
    }
    else {
        var sample  = require('../examples/sports-events-sample.json');
        var results = validator.validate(sample, schema);
        console.log(results.errors);
    }
});