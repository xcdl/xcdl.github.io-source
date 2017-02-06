#! /bin/bash

cd "$(dirname "$0")"

export PATH="$HOME/opt/homebrew-jekyll/bin":$PATH

site="../xcdl.github.io.git"

# Be sure the 'vendor/' folder is excluded, 
# otherwise a strage error occurs.
bundle exec jekyll build --destination ../xcdl.github.io.git

export NOKOGIRI_USE_SYSTEM_LIBRARIES=true

# --log-level debug \

# Validate images and links (internal & external).
 bundle exec htmlproofer \
--url-ignore=""  \
"${site}"

echo
echo "Done"
