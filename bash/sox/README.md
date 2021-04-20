# Cheat Sheet - sox

<br>

## Show manual:
```shell
man sox

man soxi
```

## Show help:
```shell
sox

soxi
```

<br><br>

## Convert stereo to mono:
```shell
sox <input-file> --channels 1 <output-file>
sox <input-file> -c 1 <output-file>

for file in *.wav; do sox "${file}" "mono_${file}" channels 1; done
```

## Convert bit depth:
```shell
sox <input-file> --bits <bit-depth> <output-file>
sox <input-file> -b <bit-depth> <output-file>

for file in *.wav; do sox "${file}" --bits 16 "bit_${file}"; done
```

## Convert sample rate:
```shell
sox <input-file> --rate <sample-rate> <output-file>
sox <input-file> -r <sample-rate> <output-file>

for file in *.wav; do sox "${file}" "rate_${file}" rate 48000; done
```

## Normalize audio to -0.1 dBFS:
```shell
sox <input-file> <output-file> norm -0.1

for file in *.wav; do sox "${file}" "norm_${file}" norm -0.1; done
```

<br><br>

## Show informtion about a file:
```shell
sox --info <filename>
sox --i <filename>
```

## Get number of channels:
```shell
soxi -c <filename>

for file in *.wav; do soxi -c "${file}"; done
```

## Get bit depth:
```shell
soxi -b <filename>

for file in *.wav; do soxi -b "${file}"; done
```

## Get sample rate:
```shell
soxi -r <filename>

for file in *.wav; do soxi -r "${file}"; done
```

## Get duration:
```shell
soxi -d <filename>

for file in *.wav; do soxi -d "${file}"; done
```

## Get audio encoding:
```shell
soxi -e <filename>

for file in *.wav; do soxi -e "${file}"; done
```