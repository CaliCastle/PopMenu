#!/bin/bash
set -e

MODULE_VERSION=$1
OUTPUT=$2
AUTHOR="Cali Castle"
AUTHOR_URL="https://calicastle.com"
MODULE_NAME="PopMenu"
COPYRIGHT="Copyright © 2018 $AUTHOR. Available under the MIT License."
GITHUB_URL="https://github.com/CaliCastle/PopMenu"
GH_PAGES_URL="https://calicastle.github.io/PopMenu"

jazzy \
    -a "$AUTHOR" \
    -u "$AUTHOR_URL" \
    -m "$MODULE_NAME" \
    --module-version "$MODULE_VERSION" \
    --copyright "$COPYRIGHT" \
    -g "$GITHUB_URL" \
    --github-file-prefix "$GITHUB_URL/tree/master" \
    -r "$GH_PAGES_URL" \
    -o "$OUTPUT"\
    --min-acl public \
    --use-safe-filenames \
