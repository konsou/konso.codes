#!/bin/bash
if [[ ! -d ./html ]]; then
    echo "Creating html directory..."
    mkdir ./html
fi
echo "Compiling HTML..."
pandoc index.md -f markdown -t html -s -o html/index.html