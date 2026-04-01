#!/bin/sh

# $1 = <path to Naproche executable>
# $2 = <path to naproche/math directory>
# $3 = <output directory>

naproche_exe="${1}"
math_dir="$(realpath ${2})"
out_dir="$(realpath "${3}")"
ftl_dir="${out_dir}/ftl"
tex_dir="${out_dir}/tex"
stex_dir="${out_dir}/stex"

process () {
  cd ${math_dir}
  for file in $(find . -name ${1} -type f); do
    echo "Processing $(realpath "${file}")"
    # Generate document:
    "${naproche_exe}" --mode=translate --format=informal "${file}" > "${file}.doc"
    sed -i '/^\(parsing successful\|\[Parser\]\|\[Main\]\).*/d' "${file}.doc"
    mv "${file}.doc" "${2}/$(basename -- "${file}.doc")"
    # Generate lexicon:
    "${naproche_exe}" --mode=lexicon "${file}" > "${file}.lex"
    sed -i '/^\(parsing successful\|\[Parser\]\|\[Main\]\).*/d' "${file}.lex"
    mv "${file}.lex" "${2}/$(basename -- "${file}.lex")"
  done
}

mkdir -p "${ftl_dir}"
mkdir -p "${tex_dir}"
mkdir -p "${stex_dir}"
process '*.ftl' "${ftl_dir}"
process '*.ftl.tex' "${tex_dir}"
process '*.ftl.en.tex' "${stex_dir}"

