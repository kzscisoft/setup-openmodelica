#!/usr/bin/bash
OPENMODELICA_DOWNLOADS=https://build.openmodelica.org/omc/builds/linux/releases/

if [ -z ${INPUT_VERSION} ]
then
    for deb in deb deb-src; do echo "$deb http://build.openmodelica.org/apt `lsb_release -cs` stable"; done | tee /etc/apt/sources.list.d/openmodelica.list
    apt update
    if [ $? -ne 0 ]
    then
        echo "Failed to install OMC"
        exit 1
    fi
else
    echo "deb ${OPENMODELICA_DOWNLOADS}/${INPUT_VERSION} bionic release" | tee /etc/apt/sources.list.d/openmodelica.list
    apt update
    apt install -y libomc libomcsimulation
    apt install -y omc
    apt install -y omc
    if [ $? -ne 0 ]
    then
        echo "Failed to install OMC"
        exit 1
    fi
fi

apt install -y $(apt-cache search "omlib-.*" | cut -d" " -f1 | xargs)   