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
  "${naproche_exe}" --mode=translate --format=informal "${file}" > "${file}.txt"
  sed -i '/^\(parsing successful\|\[Parser\]\|\[Main\]\).*/d' "${file}.txt"
  mv "${file}.txt" "${out_dir}/ftl/$(basename -- "${file}.txt")"
done

for file in $(find . -name '*.ftl.tex' -type f); do
  echo "Processing $(realpath "${file}")"
  "${naproche_exe}" --mode=translate --format=informal "${file}" > "${file}.txt"
  sed -i '/^\(parsing successful\|\[Parser\]\|\[Main\]\).*/d' "${file}.txt"
  mv "${file}.txt" "${out_dir}/tex/$(basename -- "${file}.txt")"
done

for file in $(find . -name '*.ftl.en.tex' -type f); do
  echo "Processing $(realpath "${file}")"
  "${naproche_exe}" --mode=translate --format=informal "${file}" > "${file}.txt"
  sed -i '/^\(parsing successful\|\[Parser\]\|\[Main\]\).*/d' "${file}.txt"
  mv "${file}.txt" "${out_dir}/stex/$(basename -- "${file}.txt")"
done
