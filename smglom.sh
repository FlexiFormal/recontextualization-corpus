#!/bin/sh

rustex_exe="${1}"
mathhub_dir="${2}"

view_list="smglom/views.txt"
view_dir="smglom/views"
structop_list="smglom/structure-returning-operations.txt"
structop_dir="smglom/structure-returning-operations"
structext_list="smglom/structure-extensions.txt"
structext_dir="smglom/structure-extensions"
statement_list="smglom/statements.txt"
statement_dir="smglom/statements"
pushout_list="smglom/pushouts.txt"
pushout_dir="smglom/pushouts"

process() {
  while read file; do
    echo "Processing $(realpath "${mathhub_dir}/${file}")"
    "${rustex_exe}" -i "${mathhub_dir}/${file}" -o "${2}/$(basename ${file} .tex).html" > /dev/null
    sed -i 's/ \?data-rustex-sourceref="[^"]*"//g' "${2}/$(basename ${file} .tex).html"
  done < "${1}"
}

process_pushouts() {
  while read line; do
    line_array=($line)
    in_file="${line_array[0]}"
    out_file="${line_array[1]}"
    out_dirs="$(dirname ${out_file})"
    echo "Processing $(realpath "${mathhub_dir}/${in_file}")"
    mkdir -p "${pushout_dir}/${out_dirs}"
    "${rustex_exe}" -i "${mathhub_dir}/${in_file}" -o "${pushout_dir}/${out_file}" > /dev/null
    sed -i 's/ \?data-rustex-sourceref="[^"]*"//g' "${pushout_dir}/${out_file}"
  done < "${pushout_list}"
}

mkdir -p "${view_dir}"
mkdir -p "${structop_dir}"
mkdir -p "${structext_dir}"
mkdir -p "${statement_dir}"
mkdir -p "${pushouts_dir}"
echo "# Views"
process "${view_list}" "${view_dir}"
echo ""
echo "# Structure-Returning Operations"
process "${structop_list}" "${structop_dir}"
echo ""
echo "# Structure Extensions"
process "${structext_list}" "${structext_dir}"
echo ""
echo "# Statements"
process "${statement_list}" "${statement_dir}"
echo ""
echo "# Pushouts"
process_pushouts

