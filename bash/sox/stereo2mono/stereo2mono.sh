#!/usr/bin/env bash

inputDir="./input"
outputDir="./output"

mkdir -p ${inputDir}
mkdir -p ${outputDir}

for file in ${inputDir}/*.wav; do
    basename="$(basename -- "${file}")"
    echo "Converting "${basename}"..."
    sox "${file}" "${outputDir}/${basename}" channels 1
done
