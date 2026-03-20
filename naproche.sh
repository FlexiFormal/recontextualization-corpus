#!/bin/sh

# $1 = <path to Naproche executable>
# $2 = <path to naproche/math directory>
# $3 = <output directory>

naproche_exe="${1}"
math_dir="${2}"
out_dir="$(realpath "${3}")"

mkdir -p "${out_dir}/ftl"
mkdir -p "${out_dir}/tex"
mkdir -p "${out_dir}/stex"

cd ${math_dir}

for file in $(find . -name '*.ftl' -type f); do
  echo "Processing $(realpath "${file}")"
  # Generate document:
  "${naproche_exe}" --mode=translate --format=informal "${file}" > "${file}.doc"
  sed -i '/^\(parsing successful\|\[Parser\]\|\[Main\]\).*/d' "${file}.doc"
  mv "${file}.doc" "${out_dir}/ftl/$(basename -- "${file}.doc")"
  # Generate lexicon:
  "${naproche_exe}" --mode=lexicon "${file}" > "${file}.lex"
  sed -i '/^\(parsing successful\|\[Parser\]\|\[Main\]\).*/d' "${file}.lex"
  mv "${file}.lex" "${out_dir}/ftl/$(basename -- "${file}.lex")"
done

for file in $(find . -name '*.ftl.tex' -type f); do
  echo "Processing $(realpath "${file}")"
  # Generate document:
  "${naproche_exe}" --mode=translate --format=informal "${file}" > "${file}.doc"
  sed -i '/^\(parsing successful\|\[Parser\]\|\[Main\]\).*/d' "${file}.doc"
  mv "${file}.doc" "${out_dir}/tex/$(basename -- "${file}.doc")"
  # Generate lexicon:
  "${naproche_exe}" --mode=lexicon "${file}" > "${file}.lex"
  sed -i '/^\(parsing successful\|\[Parser\]\|\[Main\]\).*/d' "${file}.lex"
  mv "${file}.lex" "${out_dir}/ftl/$(basename -- "${file}.lex")"
done

for file in $(find . -name '*.ftl.en.tex' -type f); do
  echo "Processing $(realpath "${file}")"
  # Generate document:
  "${naproche_exe}" --mode=translate --format=informal "${file}" > "${file}.doc"
  sed -i '/^\(parsing successful\|\[Parser\]\|\[Main\]\).*/d' "${file}.doc"
  mv "${file}.doc" "${out_dir}/stex/$(basename -- "${file}.doc")"
  # Generate lexicon:
  "${naproche_exe}" --mode=lexicon "${file}" > "${file}.lex"
  sed -i '/^\(parsing successful\|\[Parser\]\|\[Main\]\).*/d' "${file}.lex"
  mv "${file}.lex" "${out_dir}/ftl/$(basename -- "${file}.lex")"
done
