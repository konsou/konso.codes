#!/bin/bash

# pdflatex install:
# sudo apt-get install texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra
echo "Checking for required packages..."


PACKAGES_REQUIRED=("build-essential python3-dev python3-pip python3-setuptools python3-wheel python3-cffi libcairo2 libpango-1.0-0 libpangocairo-1.0-0 libgdk-pixbuf2.0-0 libffi-dev shared-mime-info")
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

if [ $(./check-packages-installed.py) -eq 1 ]; then  # Bash logic: 0 is success, 1 is failure
    echo "One or more required Python packages are MISSING."
    read -p "Install required Python packages? (Y/n): " USER_INPUT
    USER_INPUT_LOWERCASE=$(echo "${USER_INPUT}" | tr '[:upper:]' '[:lower:]')
    if [[ -z ${USER_INPUT} || ${USER_INPUT_LOWERCASE:0:1} == 'y' ]]; then
        sudo pip3 install -r requirements.txt  # needs to run with sudo to create the weasyprint executable
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
weasyprint html/index.html pdf/CV-Tomi-Javanainen.pdf