#!/usr/bin/bash
for deb in deb deb-src; do echo "$deb http://build.openmodelica.org/apt `lsb_release -cs` stable"; done | tee /etc/apt/sources.list.d/openmodelica.list
apt update
if [ $? -ne 0 ]
then
    echo "Failed to install OMC"
    exit 1
fi
apt install -y $(apt-cache search "omlib-.*" | cut -d" " -f1 | xargs)

ARGUMENTS=("-s ${INPUT_FILE_PATH}")

if [ -n "${INPUT_MODEL_NAME}" ]
then
    ARGUMENTS+=("+i=${INPUT_MODEL_NAME}")
fi

if [ -n "${INPUT_LIBRARIES}"]
then
    ARGUMENTS+=("${INPUT_LIBRARIES}")
fi

omc "${ARGUMENTS[@]}"
MODEL_MAKE_FILE=$(ls *.makefile | head -n 1 | xargs)

if [ -z ${MODEL_MAKE_FILE} ]
then
    echo "Model script generation failed, no makefile found"
    exit 1
fi

make -f ${MODEL_MAKE_FILE}

MODEL_EXECUTABLE=$(echo ${MODEL_MAKE_FILE} | cut -d '.' -f 1)

if [ ! -f ${MODEL_EXECUTABLE} ]
then
    echo "Model compilation failed"
    exit 1
fi

./${MODEL_EXECUTABLE}