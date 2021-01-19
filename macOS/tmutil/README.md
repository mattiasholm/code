## Cheat Sheet - Time Machine utility

<br>

## Show manual:
```shell
man tmutil
```

## Show help:
```shell
tmutil --help
tmutil -h
```

## Check tmutil version:
```shell
tmutil version
tmutil --version
tmutil -v
```

<br><br>

## Enable Time Machine:
```shell
sudo tmutil enable
```

## Disable Time Machine:
```shell
sudo tmutil disable
```

<br><br>

## List local snapshots:
```shell
tmutil listlocalsnapshots /
```

## List dates for local snapshots:
```shell
tmutil listlocalsnapshotdates
```

## Create local snapshot:
```shell
tmutil localsnapshot
tmutil snapshot
```

## Delete all local snapshots:
```shell
tmutil deletelocalsnapshots /
```

## Compare latest snapshot to current state: 
```shell
tmutil compare
```

<br><br>

## Show backup destination:
```shell
tmutil destinationinfo
```

## List backups:
```shell
tmutil listbackups
```

## Show location of latest backup:
```shell
tmutil latestbackup
```

## Start a backup job:
```shell
tmutil startbackup
```

## Start a backup job:
```shell
tmutil stopbackup
```

## Check status of a backup job:
```shell
tmutil status
```

## Restore a file from backup:
```shell
tmutil restore <backup-path> <destination-path>
```