#!/bin/env bash


REFS=$(xmllint --xpath "/*[local-name()='catalog']/*[local-name()='group']/*[local-name()='system']/@systemId" external/sgml_catalogue_files.xml.in | sed 's/systemId=//g' | sed 's/"//g')
pushd external
for xml_url in "$REFS"; do wget -N $xml_url; done
popd

TEST_DIR=test
XMLS="https://tools.ietf.org/id/draft-ribose-asciirfc-08.xml https://tools.ietf.org/id/draft-asciirfc-minimal-03.xml"
mkdir -p $TEST_DIR
pushd $TEST_DIR
for xml_url in $XMLS; do wget -N $xml_url; done
popd

for xml in $TEST_DIR/draft-*.xml; do ./rfc2mnadoc.sh $xml ${xml}.adoc; done