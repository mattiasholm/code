#!/usr/bin/env bash

inputDir="./input"
outputDir="./output"

mkdir -p ${inputDir}
mkdir -p ${outputDir}

for file in ${inputDir}/*.wav; do
    echo "Converting $(basename -- ${file})..."
    sox "${file}" "${outputDir}/$(basename -- ${file})" channels 1
done
