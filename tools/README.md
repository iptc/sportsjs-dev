# IPTC SportsJS Tools

This folder contains tools to be used to generate SportsJS sample files and to validate sportsJS-files.

## Folder content

### scripts for generating samples from xml
* php_xml_to_json - a php-script that turns SportsML into SportsJS

### validating_json
A Node-script to validate your sportsJs file against the schema. 
In order to make this work, make sure you have all node dependencies.
Run `npm install` in order to install missing dependencies.

node validate.js --file ../examples/generic-alert.json

* validating_json - a Node-script to validate your sportsJs file against the schema

This repository has been created by IPTC - Copyright © 2018 IPTC - https://iptc.org
