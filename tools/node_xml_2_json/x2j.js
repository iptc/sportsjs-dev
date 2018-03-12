var fs = require('fs')
var libxslt = require('libxslt');
var libxmljs = libxslt.libxmljs;
var xml2js = require('xml2js');
var path = require('path');

var options = require('minimist')(process.argv.slice(2));

var stylesheetString  = fs.readFileSync(options.xslt);
var stylesheetObj = libxmljs.parseXml(stylesheetString);
var stylesheet = libxslt.parse(stylesheetObj);
 
var documentString  = fs.readFileSync(options.file);
var filnamn = path.basename(options.file);
var document = libxmljs.parseXml(documentString);

var result = stylesheet.apply(document);

var dir = './output';

if (!fs.existsSync(dir)){
    fs.mkdirSync(dir);
}

fs.writeFile(dir + "/clean_" + filnamn, result.toString(), function(err) {
    if(err) {
        return console.log(err);
    }
    console.log('xml conversion done and saved.');

    var parseString = require('xml2js').parseString;
    var xml = result.toString()

    parseString(xml, function (err, result) {
        fs.writeFile(dir + "/" + filnamn + ".json", JSON.stringify(result,null,2), function(err) {
            if(err) {
                return console.log(err);
            }
        console.dir('json file produced and saved.');
     })});
    
}); 
