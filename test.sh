#!/bin/bash

uuid_file="$HOME/.my_script_uuid"
if [ ! -f "$uuid_file" ]; then
    date | sha256sum | awk '{print $1}' > "$uuid_file"
fi
uuid=$(cat "$uuid_file")
echo "Your unique ID is $uuid"

# Your existing script starts here
# ...
