<?php

$files = glob("/home/vagrant/code/iptc/std/SportsJS/sportsjs-dev/tools/xslt_pre_xml/input/*.xml");

print_r($files);
foreach ($files as $file) {
echo $file;
   $xslDoc = new DOMDocument();
   $xslDoc->load("/home/vagrant/code/iptc/std/SportsJS/sportsjs-dev/tools/xslt_pre_xml/xslt/xml2json-v1.xsl");

   $xmlDoc = new DOMDocument();
   $xmlDoc->load($file);

   $proc = new XSLTProcessor();
   $proc->importStylesheet($xslDoc);
   $content = $proc->transformToXML($xmlDoc);
   $xmlFileName = str_replace("input", "output", $file);
   file_put_contents($xmlFileName, $content);

   $content = str_replace(array("\n", "\r", "\t"), '', $content);
   $content = trim(str_replace('"', "'", $content));

   $simpleXml = simplexml_load_string($content);
   $json = json_encode($simpleXml, JSON_PRETTY_PRINT);

   $jsonFile = str_replace(".xml", ".json", $file);
   $jsonFile = str_replace("input", "output", $jsonFile);
   file_put_contents($jsonFile, $json);

   $moveFile = str_replace("input", "done", $file);

   rename($file, $moveFile);
}
