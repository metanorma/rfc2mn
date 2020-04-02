#!/bin/bash
readonly __progname="$(basename $0)"
readonly __RFC2MDDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" # https://stackoverflow.com/a/246128/902217

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

  case "$(uname -s)" in
   CYGWIN*|MINGW32*|MSYS*|MINGW*)
      CATALOG_BASE="$(cmd //c "echo %cd:\\=/%")/external/"
      ;;

   *)
      CATALOG_BASE="file://${__RFC2MDDIR}/external/"
      ;;
  esac

  sed "s|\${BASEPATH}|${CATALOG_BASE}|g" ${__RFC2MDDIR}/external/sgml_catalogue_files.xml.in > ${__RFC2MDDIR}/external/sgml_catalogue_files.xml

  env XML_CATALOG_FILES="sgml_catalogue_files.xml ${CATALOG_BASE}/sgml_catalogue_files.xml" \
    env XML_DEBUG_CATALOG=1 \
    xsltproc rfc2mnadoc.xslt ${SRCXML} > ${ADOC} || exit 1

  [[ -f filename && ! -s filename ]] && exit 2
}

main "$@"

exit 0
