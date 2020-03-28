#!/usr/bin/env python3

import os
import wave

inputDir = "./input/"

os.system("mkdir -p " + inputDir)

for file in os.listdir(inputDir):
    if file.endswith(".wav"):
        print('\nInspecting WAV file "' + os.path.basename(inputDir + file) + '":')

        wave_read = wave.open(inputDir + file, "rb")
        print("\nBit depth:\t{0}".format(wave_read.getsampwidth() * 8))
        print("Sample rate:\t{0}".format(wave_read.getframerate()))
        print("Channels:\t{0}\n".format(wave_read.getnchannels()))
        if (
            wave_read.getsampwidth() == 3
            and wave_read.getframerate() == 44100
            and wave_read.getnchannels() == 1
        ):
            print("\033[32mWAV file is good to go for mixing!\n\033[0m")
        else:
            print("\033[33mWAV file needs to be converted!\n\033[0m")

        wave_read.close()
