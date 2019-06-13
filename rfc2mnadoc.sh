#!/bin/bash
readonly __progname="$(basename $0)"
readonly __RFC2MDDIR="$(dirname $0)"

errx() {
	echo -e "$__progname: error: $@" >&2
  help
	exit 1
}

help() {
  echo "usage: $__progname {rfc-xml-v2} [optional: output-adoc]" >&2
  exit 0
}

main() {

  SRCXML=$1

	([ "${SRCXML}" == "-h" ] || [ "${SRCXML}" == "--help" ]) && \
		help

	[ "${SRCXML}" == "" ] && \
		errx "{rfc-xml-v2} not provided"

  fname=$(basename ${SRCXML})
  ADOC=$2

  [ "${ADOC}" == "" ] && \
    ADOC=${fname/%.xml}.adoc

  # echo "$ADOC"
  cat ${__RFC2MDDIR}/external/sgml_catalogue_files.xml.in | \
    envsubst > ${__RFC2MDDIR}/external/sgml_catalogue_files.xml

  XML_CATALOG_FILES="sgml_catalogue_files.xml file://${RFC2MDDIR}/external/sgml_catalogue_files.xml"
  XML_DEBUG_CATALOG=1

  # echo "xsltproc rfc2mnadoc.xslt ${SRCXML} > ${ADOC}" >&2
  xsltproc rfc2mnadoc.xslt ${SRCXML} > ${ADOC}
}

main "$@"

exit 0
