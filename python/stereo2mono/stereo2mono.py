#!/usr/bin/env python3

import os
from pydub import AudioSegment
import soundfile as sf

inputDir = "./input/"
tmpDir = "./.tmp/"
outputDir = "./output/"

os.system("mkdir -p " + inputDir)
os.system("mkdir -p " + tmpDir)
os.system("mkdir -p " + outputDir)

for file in os.listdir(inputDir):
    if file.endswith(".wav"):
        sound = AudioSegment.from_wav(inputDir + file)
        sound = sound.set_sample_width(3)
        sound = sound.set_frame_rate(44100)
        sound = sound.set_channels(1)
        sound.export(tmpDir + file, format="wav")

for file in os.listdir(tmpDir):
    if file.endswith(".wav"):
        data, samplerate = sf.read(tmpDir + file)
        sf.write(outputDir + file, data, samplerate, subtype="PCM_24")

os.system("rm -rf " + tmpDir)
