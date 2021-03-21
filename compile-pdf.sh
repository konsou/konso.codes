#!/bin/bash

# pdflatex install:
# sudo apt-get install texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra
echo "Checking for required packages..."


# YOU ALSO NEED THE LATEST wkhtml2pdf from https://wkhtmltopdf.org/downloads.html
PACKAGES_REQUIRED=("xfonts-75dpi")  # "texlive-latex-base" "texlive-fonts-recommended" "texlive-fonts-extra" "texlive-latex-extra")
PACKAGES_MISSING=0

for PKG in ${PACKAGES_REQUIRED[@]}; do

    IS_PKG_INSTALLED=$(dpkg-query -W --showformat='${Status}\n' ${PKG} | grep "install ok installed")

    if [ "${IS_PKG_INSTALLED}" != "install ok installed" ]; then
        echo ${PKG} is MISSING.
        PACKAGES_MISSING=1
    fi
done

if [ ${PACKAGES_MISSING} -eq 1 ]; then
    read -p "Install required packages? (Y/n): " USER_INPUT
    USER_INPUT_LOWERCASE=$(echo "${USER_INPUT}" | tr '[:upper:]' '[:lower:]')
    if [[ -z ${USER_INPUT} || ${USER_INPUT_LOWERCASE:0:1} == 'y' ]]; then
        printf -v PACKAGES_STRING ' %s' "${PACKAGES_REQUIRED[@]}"  # Convert array to space delimited string
        sudo apt update
        sudo apt install ${PACKAGES_STRING} -y
    else
        echo Exiting
        exit 1
    fi
fi

./compile.sh

if [[ ! -d ./pdf ]]; then
    echo "Creating pdf directory..."
    mkdir ./pdf
fi

echo "Compiling PDF..."
echo "NOTE: If PDF compilation fails with the error \"Could not connect to any X display\""
echo "You need to install the latest wkhtmltopdf from https://wkhtmltopdf.org/downloads.html"
pandoc html/index.html \
    -f html \
    -t pdf \
    -s \
    -o pdf/CV-Tomi-Javanainen.pdf \
    --metadata-file metadata.json \
    --pdf-engine=wkhtmltopdf \
    -V geometry:a4paper \

    # -V linkcolor:blue \
    # -V mainfont="Georgia Serif" \
    # -V monofont="Menlo Monaco 'Lucida Console' Consolas monospace" \
    # -V fontsize=14pt \
