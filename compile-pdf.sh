#!/bin/bash

if [[ ! -d ./pdf ]]; then
    echo "Creating pdf directory..."
    mkdir ./pdf
fi

echo "Compiling PDF..."
pandoc index.md \
    -f markdown \
    -t pdf \
    -s \
    -o pdf/CV-Tomi-Javanainen.pdf \
    --metadata-file metadata.json \
    -V linkcolor:blue \
    -V geometry:a4paper \
    -V mainfont="Georgia Serif" \
    -V monofont="Menlo Monaco 'Lucida Console' Consolas monospace" \
    -V fontsize=14pt \
