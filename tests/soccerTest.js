'use strict';

var tv4 = require('tv4');
var path = require('path');
var fs = require('fs');

var sample  = require('C:/Utvikling/SportsData_SportLite/json/2016-02-23-134548-1118347.json');
var core = require('../schema/SportsInJSON-Core.json');

var schemaDir = '../schema/';
fs.readdirSync(schemaDir).forEach(function(name) {
    if (name.indexOf('SportsInJSON') > -1) {
        var filePath = path.join(schemaDir, name);
        console.log('Adding ' + name);
        tv4.addSchema(name, require(filePath));
    }
});

var result =  tv4.validateMultiple(sample, core, true, true);
console.log(JSON.stringify(result, null, 4));

