# IPTC Converting SportsML (xml) to SportsJS (json)

This folder contains tools to be used to generate SportsJS sample files from SportsML xml files.

## Folder content

## x2j.js
Javascript file that first uses xslt to prepare the xml file for conversion.
And then convert the prepared xml file to json.
Both files are saved to the output folder.

In order to make this work, make sure you have all node dependencies.
Run `npm install` in order to install dependencies.

To convert a file;
node x2j.js --xslt ../php_xml_to_json/xslt/xml2json-v1.xsl --file ../../examples/tennis_davis_cup_tournament.xmlgeneric-alert.json

This repository has been created by IPTC - Copyright © 2018 IPTC - https://iptc.org