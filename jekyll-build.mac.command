#! /bin/bash

cd "$(dirname "$0")"

export PATH="$HOME/.local/homebrew/jekyll/bin":$PATH

site="../xcdl.github.io.git"

# find pages _posts -type f -name '*.md' -print -exec git log --format=%ci -- {} \;

# Be sure the 'vendor/' folder is excluded,
# otherwise a strage error occurs.
bundle exec jekyll build --destination "${site}"

# export NOKOGIRI_USE_SYSTEM_LIBRARIES=true

# --log-level debug \

# Validate images and links (internal & external).
# bundle exec htmlproofer \
# --url-ignore=""  \
# "${site}"

echo
echo "Done"
