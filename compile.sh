#!/bin/bash
if [[ ! -d ./html ]]; then
    echo "Creating html directory..."
    mkdir ./html
fi

if [[ ! -d ./html/images ]]; then
    echo "Creating html images directory..."
    mkdir ./html/images
fi

echo "Compiling HTML..."
pandoc index.md -f markdown -t html -s --metadata-file metadata.json -o html/index.html

echo "Copying images..."
cp images/* html/images/