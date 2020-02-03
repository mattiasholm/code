# Cheat Sheet

<br>

## SSH via a jumphost:
```shell
ssh -J [host1] [host2]
```

## Update hosts file:
```shell
vim /etc/hosts
```

## Create alias:
```shell
alias a='cmd'
```

<br><br>

## Curl request that returns your public IP:
```shell
curl -s ifconfig.co
```

## Curl request with custom Host header:
```shell
curl --header "Host: example.com" https://example.azurewebsites.net/
```

## Curl request that overrides DNS with a hard-coded IP address and ignores any certificate errors:
```shell
curl --resolve example.com:443:51.141.12.112 https://example.com --insecure
```

## Curl request that overrides DNS with a hard-coded hostname and ignores any certificate errors:
```shell
curl --connect-to example.com:443:example.azurewebsites.net:443 https://example.com/ --insecure
```

<br><br>

## Count number of lines:
```shell
wc -l
```

## Count number of characters:
```shell
wc -m
```

## Count number of words:
```shell
wc -w
```

<br><br>

## Alias to `ls -la`:
```shell
ll
```

## Grep inverted match:
```shell
grep -v substring
```

## Create empty file in working directory:
```shell
touch
```

## FLER??? Flytta Curl till en egen cheat sheet, mer logiskt?!
# Eventuellt även flytta https://ifconfig.co/ till egen README - finns fler än endast publik IP!