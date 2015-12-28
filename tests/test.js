'use strict';

var tv4 = require('tv4');
var path = require('path');
var fs = require('fs');

var sample  = require('../samples/sportsEvent.json');
var core = require('../schema/SportsInJSON.json');

var schemaDir = '../schema/';
fs.readdirSync(schemaDir).forEach(function(name) {
    if (name.indexOf('SportsInJSON') > -1) {
        var filePath = path.join(schemaDir, name);
        console.log('Adding ' + name);
        tv4.addSchema(name, require(filePath));
    }
});

var result =  tv4.validateMultiple(sample, core, true);
console.log(result);

