#!/usr/bin/bash
ARGUMENTS=("+s ${INPUT_FILE_PATH}")

if [ -n "${INPUT_MODEL_NAME}" ]
then
    ARGUMENTS+=("+i=${INPUT_MODEL_NAME}")
fi

if [ -n "${INPUT_LIBRARIES}" ]
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