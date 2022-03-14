#!/usr/bin/env bash

set -e +x

inputDir='./input'
outputDir='./output'

mkdir -p "$inputDir"
mkdir -p "$outputDir"

if [[ -z "$(ls "$inputDir")" ]]; then
    echo -e '\nInput directory does not contain any WAV files, exiting script\n'
    exit 1
fi

for file in $inputDir/*.wav; do

    basename="$(basename -- "$file")"
    bitDepth="$(soxi -b "$file")"
    sampleRate="$(soxi -r "$file")"
    channels="$(soxi -c "$file")"

    if [[ "$bitDepth" == '24' && "$sampleRate" == '44100' && "$channels" == '1' ]]; then
        echo -e "\033[33m\nSkipping conversion of $basename, copying the file to output directory as is...\033[0m"
        cp "$file" "$outputDir/$basename"
    else
        echo -e "\033[32m\nConverting $basename and creating new file in output directory...\033[0m"
        sox "$file" "$outputDir/$basename" channels 1
    fi
done
echo ''
