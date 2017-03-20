#!/bin/sh

THIS=$(dirname "$(readlink -f "$0")")

. ${THIS}/json.sh

json < /config.json | grep 'include_paths' | grep 'string' | cut -d ' ' -f 3 | while read path
do
    find "$path" -name '*.rs'
done | xargs ${THIS}/rustfmt --write-mode codeclimate
