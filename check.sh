#!/usr/bin/env bash
# Builds the document, renders it as a single page, and compares the links of the two tables of
# contents. Exits with status 1 if the in-page table of contents has empty links.
set -euo pipefail
cd "$(dirname "$0")"
lake build
rm -rf _out
lake exe repro --output _out --with-html-single --without-html-multi
page=_out/html-single/index.html
echo "Sidebar ToC links:"
grep -o '<td><a href="[^"]*"' "$page" | sed 's/^<td>/  /'
echo "In-page ToC links:"
inpage=$(grep -o '<ol class="section-toc">.*</ol>' "$page" | grep -o '<a href[^>]*>')
echo "$inpage" | sed 's/^/  /'
if echo "$inpage" | grep -qv 'href="#'; then
  echo "the in-page ToC links do not point at the sections"
  exit 1
fi
echo "OK"
