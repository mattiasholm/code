# Cheat Sheet

<br>

## SSH via a jumphost:
```bash
ssh -J [host1] [host2]
```

## Update hosts file:
```bash
vim /etc/hosts
```

## Create alias:
```bash
alias a='cmd'
```

<br><br>

## Curl request that returns your public IP:
```bash
curl -s ifconfig.co
```

## Curl request with custom Host header:
```bash
curl --header "Host: example.com" https://example.azurewebsites.net/
```

## Curl request that overrides DNS with a hard-coded IP address and ignores any certificate errors:
```bash
curl --resolve example.com:443:51.141.12.112 https://example.com --insecure
```

## Curl request that overrides DNS with a hard-coded hostname and ignores any certificate errors:
```bash
curl --connect-to example.com:443:example.azurewebsites.net:443 https://example.com/ --insecure
```

<br><br>

## Count number of lines:
```bash
wc -l
```

## Count number of characters:
```bash
wc -m
```

## Count number of words:
```bash
wc -w
```

<br><br>

## Alias to `ls -la`:
```bash
ll
```

## Grep inverted match:
```bash
grep -v substring
```

## Create empty file in working directory:
```bash
touch
```

<br><br>

## FLER??? Eventuellt flytta Curl till en egen cheat sheet?