#! /bin/bash

cd "$(dirname "$0")"

export PATH=/opt/homebrew-jekyll3/bin:$PATH
jekyll build --destination ../xcdl.github.io.git

echo
echo "Done"
