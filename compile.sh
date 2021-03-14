#!/bin/bash
echo "Compiling HTML..."
pandoc index.md -f markdown -t html -s -o html/index.html