#!/bin/bash

source=$1
dest=$2

if [[ $# -eq 0 ]]; then
	echo "no args supplied"
elif [[ -n "$dest" ]]; then
	echo "overwriting dest $dest"
	sed 's/\r//' "$source" > "$dest"
else
	echo "overwriting source $source"
	sed -i 's/\r//' "$source"
fi
