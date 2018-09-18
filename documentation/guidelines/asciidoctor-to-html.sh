#!/bin/sh
echo "Converting SportJS documentation starting at IPTC-SportsJS-Specification.adoc"
asciidoctor -b html5 -o index.html IPTC-SportsJS-Specification.adoc
echo "Done"
