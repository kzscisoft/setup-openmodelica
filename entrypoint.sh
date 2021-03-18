#!/usr/bin/bash
if [ -z ${INPUT_VERSION} ]
then
    echo "No OpenModelica version specified."
    exit 1
fi

OPENMODELICA_DOWNLOADS=https://build.openmodelica.org/omc/builds/linux/releases/

if [ -z ${INPUT_VERSION} ]
then
    for deb in deb deb-src; do echo "$deb http://build.openmodelica.org/apt `lsb_release -cs` stable"; done | sudo tee /etc/apt/sources.list.d/openmodelica.list
    apt update
    apt install -y omc
else
    echo "deb ${OPENMODELICA_DOWNLOADS}/${INPUT_VERSION} bionic release" | sudo tee /etc/apt/sources.list.d/openmodelica.list
    apt update
    apt install -y omc
fi

for PKG in `apt-cache search "omlib-.*" | cut -d" " -f1`; do apt install -y "$PKG"; done