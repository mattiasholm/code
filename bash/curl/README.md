# Cheat Sheet - curl

<br>

## Curl request that returns your public IP:
```shell
curl ifconfig.io
```

## Curl request that returns information on your public IP:
```shell
curl ipinfo.io
```

## Curl request that returns information on a specific public IP:
```shell
curl ipinfo.io/<ip-address>
```

## Curl request that runs in quiet mode:
```shell
curl --silent example.com
curl -s example.com
```

## Curl request that shows HTTP status code and response headers:
```shell
curl --include example.com
curl -i example.com
```

## Curl request with custom Host header:
```shell
curl --header "Host: example.com" https://example.azurewebsites.net/
curl -H "Host: example.com" https://example.azurewebsites.net/
```

## Curl request with other method than default GET:
```shell
curl --request <method> https://example.com
curl -X <method> https://example.com
```

## Curl request that includes a payload:
```shell
curl --data <payload> https://example.com
curl -d <payload> https://example.com
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
curl https://raw.githubusercontent.com/mattiasholm/code/main/git/cloneRepos.sh --output cloneRepos.sh
```

<br><br>

## Test how different HTTP response status codes behave in `curl`:
```shell
curl httpstat.us/<status-code>
```

## Test how different types of SSL misconfigurations behave in `curl`:
```shell
curl https://expired.badssl.com/
```