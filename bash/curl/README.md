# Cheat Sheet - curl

<br>

## Curl request that returns your public IP:
```shell
curl --silent ifconfig.co
curl -s ifconfig.co
```

## Curl request with custom Host header:
```shell
curl --header "Host: example.com" https://example.azurewebsites.net/
curl -H "Host: example.com" https://example.azurewebsites.net/
```

## Curl request that overrides DNS with a hard-coded IP address and ignores any certificate errors:
```shell
curl --resolve example.com:443:51.141.12.112 https://example.com --insecure
curl --resolve example.com:443:51.141.12.112 https://example.com -k
```

## Curl request that overrides DNS with a hard-coded hostname and ignores any certificate errors:
```shell
curl --connect-to example.com:443:example.azurewebsites.net:443 https://example.com/ --insecure
curl --connect-to example.com:443:example.azurewebsites.net:443 https://example.com/ -k
```

## Curl request that downloads a file to working directory:
```shell
curl https://raw.githubusercontent.com/mattiasholm/mattiasholm/master/git/CloneRepos.sh --output CloneRepos.sh
```



<!---
Eventuellt ange placeholder argument <APA> istället för nuvarande exempel? Mer enhetligt med övriga READMEs!
OBS: Skapa tabell a la REGEX med alla standardväxlar!
-->

https://raw.githubusercontent.com/mattiasholm/mattiasholm/master/git/CloneRepos.sh
