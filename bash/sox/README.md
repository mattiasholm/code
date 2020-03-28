# Cheat Sheet - sox

<br>

## Open manual:
```shell
man sox
```

<br><br>

## Convert stereo to mono:
```shell
sox <input-file> <output-file> channels 1
sox <input-file> --channels 1 <output-file>
sox <input-file> -c 1 <output-file>
```

## Show informtion about a file:
```shell
sox --info <file-name>
sox --i <file-name>
```

## Get bit depth:
```shell
soxi -b <file-name>
```

## Get sample rate:
```shell
soxi -r <file-name>

```

## Get number of channels:
```shell
soxi -c <file-name>
```