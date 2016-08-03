#! /bin/bash

cd "$(dirname "$0")"

export PATH=/opt/homebrew-jekyll3/bin:$PATH
jekyll build

echo
echo "Done"
