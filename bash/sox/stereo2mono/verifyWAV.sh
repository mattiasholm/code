#!/usr/bin/env bash

inputDir="./input"
outputDir="./output"

mkdir -p ${inputDir}
mkdir -p ${outputDir}

if [[ $1 != "--verbose" ]]; then
    echo ""
fi

for file in ${inputDir}/*.wav; do
    basename="$(basename -- ${file})"
    bitDepth="$(soxi -b "${file}")"
    sampleRate="$(soxi -r "${file}")"
    channels="$(soxi -c "${file}")"

    if [[ $1 == "--verbose" ]]; then
        echo -e "\nInspecting ${basename}...\n"
        echo -e "Bit depth:\t${bitDepth}"
        echo -e "Sample rate:\t${sampleRate}"
        echo -e "Channels:\t${channels}\n"
    fi

    if [[ "${bitDepth}" == "24" && "${sampleRate}" == "44100" && "${channels}" == "1" ]]; then
        echo -e "\033[32m${basename} is good to go!\033[0m"
    else
        echo -e "\033[33m${basename} needs to be converted!\033[0m"
    fi
done
echo ""
