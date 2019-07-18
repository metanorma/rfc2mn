#!/bin/env bash

TEST_DIR=test
XMLS="https://tools.ietf.org/id/draft-ribose-asciirfc-08.xml https://tools.ietf.org/id/draft-asciirfc-minimal-03.xml"

mkdir -p $TEST_DIR
pushd $TEST_DIR
for xml_url in $XMLS; do wget $xml_url; done
popd

for xml in $TEST_DIR/*.xml; do ./rfc2mnadoc.sh $xml ${xml}.adoc; done