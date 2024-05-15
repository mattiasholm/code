#!/usr/bin/env python3

import os
from pydub import AudioSegment
import soundfile

inputDir = "./input/"
outputDir = "./output/"
tmpDir = "./.tmp/"

os.system("mkdir -p " + inputDir)
os.system("mkdir -p " + outputDir)
os.system("mkdir -p " + tmpDir)

for file in os.listdir(inputDir):
    if file.endswith(".wav"):
        sound = AudioSegment.from_wav(inputDir + file)
        sound = sound.set_sample_width(3)
        sound = sound.set_frame_rate(44100)
        sound = sound.set_channels(1)
        sound.export(tmpDir + file, format="wav")

for file in os.listdir(tmpDir):
    if file.endswith(".wav"):
        data, samplerate = soundfile.read(tmpDir + file)
        soundfile.write(outputDir + file, data, samplerate, subtype="PCM_24")

os.system("rm -rf " + tmpDir)
