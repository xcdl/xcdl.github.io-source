#! /bin/bash

cd "$(dirname "$0")"

export PATH=/opt/homebrew-jekyll3/bin:$PATH
jekyll serve --baseurl "" --destination _site_local --trace --port 4002

echo
echo "Done"
