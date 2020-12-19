#!make
SHELL ?= /bin/bash

JAR_VERSION := $(shell mvn -q -Dexec.executable="echo" -Dexec.args='$${project.version}' --non-recursive exec:exec -DforceStdout)
JAR_FILE := rfc2mn-$(JAR_VERSION).jar

SRCDIR := src/test/resources

SRCFILE := $(SRCDIR)/antioch.v3.xml

DESTMNADOC := $(patsubst %.xml,%.adoc,$(patsubst src/test/resources/%,documents/%,$(SRCFILE)))

all: target/$(JAR_FILE)

target/$(JAR_FILE):
	mvn --settings settings.xml -DskipTests clean package shade:shade

test:
	mvn --settings settings.xml test surefire-report:report

deploy:
	mvn --settings settings.xml -Dmaven.test.skip=true clean deploy shade:shade

documents.adoc: target/$(JAR_FILE) documents
	java -jar $< ${SRCFILE} --output ${DESTMNADOC}

documents:
	mkdir -p $@

clean:
	mvn clean

publish: published
published: documents.adoc
	mkdir published && \
	cp -a documents $@/


.PHONY: all clean test deploy version target/$(JAR_FILE)
