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
        echo -e "\033[33mSkipping conversion of ${basename}, copying the file to 'output' as is...\033[0m"
        cp "${file}" "${outputDir}/${basename}"
    else
        echo -e "\033[32mConverting ${basename} and creating new file in 'output'...\033[0m"
        sox "${file}" "${outputDir}/${basename}" channels 1
    fi
done
