#!/bin/bash
var1=

function find {
    for file in $1/*; do
        if [ -d "$file" ]; then
            find $file
            echo "$file is a directory"
        elif [ -f "$file" ]; then
            #var1+=$file
            echo "$file is a file"
        fi
    done
}

find .

