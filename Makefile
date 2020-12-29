#!make
ifeq ($(OS),Windows_NT)
SHELL := cmd
else
SHELL := /bin/bash
endif

SRCDIR := sources
DESTDIR := documents

SRCURL := https://www.rfc-editor.org/rfc/
SRCMASK := rfc865*.xml

JAR_VERSION := $(shell mvn -q -Dexec.executable="echo" -Dexec.args='$${project.version}' --non-recursive exec:exec -DforceStdout)
JAR_FILE := rfc2mn-$(JAR_VERSION).jar


all: target/$(JAR_FILE)

target/$(JAR_FILE):
	mvn --settings settings.xml -DskipTests clean package shade:shade

test:
	mvn --settings settings.xml test surefire-report:report

deploy:
	mvn --settings settings.xml -Dmaven.test.skip=true clean deploy shade:shade

documents.adoc: target/$(JAR_FILE) sources documents
ifeq ($(OS),Windows_NT)
	for /r %%f in ($(SRCDIR)/*.xml) do java -jar target/$(JAR_FILE) $(SRCDIR)/%%~nxf --output $(DESTDIR)/%%~nf.adoc
else
	for f in $(SRCDIR)/*.xml; do fout=$${f##*/}; java -jar target/$(JAR_FILE) $$f --output $(DESTDIR)/$${fout%.*}.adoc  ; done
endif

sources:
	wget -r -l 1 -nd -A ${SRCMASK} -R rfc-*.xml -P ${SRCDIR} https://www.rfc-editor.org/rfc/

documents:
	mkdir -p $@

clean:
	mvn clean

publish: published
published: documents.adoc
	mkdir published && \
	cp -a documents $@/


.PHONY: all clean test deploy version target/$(JAR_FILE) sources
