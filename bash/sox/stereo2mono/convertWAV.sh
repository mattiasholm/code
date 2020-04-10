#!/usr/bin/env bash

inputDir="./input"
outputDir="./output"

mkdir -p ${inputDir}
mkdir -p ${outputDir}

for file in ${inputDir}/*.wav; do
    basename="$(basename -- "${file}")"
    bitDepth="$(soxi -b "${file}")"
    sampleRate="$(soxi -r "${file}")"
    channels="$(soxi -c "${file}")"

    if [[ "${bitDepth}" == "24" && "${sampleRate}" == "44100" && "${channels}" == "1" ]]; then
        echo -e "Skipping ${basename}..."
    else
        echo -e "Converting ${basename}..."
        sox "${file}" "${outputDir}/${basename}" channels 1
    fi
done
