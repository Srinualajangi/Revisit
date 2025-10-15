#!/bin/bash

old_name="$1"
new_name="$2"
file="$3"

if [ -f "$file" ]; then
    sed -i.bak "s|$old_name|$new_name|g" "$file"
else
    echo "Error: '$file' not found" >&2
    exit 1
fi
