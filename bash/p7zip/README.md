# Cheat Sheet - p7zip

<br>

## Display help:
```shell
7z --help
```

<br><br>

## Add file/directory to an archive or create a new one:
```shell
7z a <archive-name> <filename | directory>
```

## Add file/directory to a password-protected archive or create a new one:
```shell
7z a <archive-name> <filename | directory> -p
```

<br><br>

## Update existing files in the archive or add new ones:
```shell
7z u <archive-name> <filename | directory>
```

<br><br>

## List the content of an archive:
```shell
7z l <archive-name>
```

<br><br>

## Extract all files/directories from an archive to the current directory:
```shell
7z x <archive-name>
```

## Extract all files/directories from an archive to a new directory:
```shell
7z x <archive-name> -o<directory>
```

<br><br>

## Delete a file/directory from an archive:
```shell
7z d <archive-name> <filename | directory>
```

<br><br>

## Check integrity of the archive:
```shell
7z t <archive-name>
```