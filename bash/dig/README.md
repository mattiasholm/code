# Cheat Sheet - dig

<br>

## Contextual syntax help:
```shell
dig -h
```

## Show dig version:
```shell
dig -v
```

<br><br>

## Query `A` records:
```shell
dig A <domain>
dig <domain>
```

## Query `AAAA` records:
```shell
dig AAAA <domain>
```

## Query `CNAME` records:
```shell
dig CNAME <domain>
```

## Query `MX` records:
```shell
dig MX <domain>
```

## Query `TXT` records:
```shell
dig TXT <domain>
```

## Query `SRV` records:
```shell
dig SRV <domain>
```

## Query `NS` records:
```shell
dig NS <domain>
```

## Query `SOA` records:
```shell
dig SOA <domain>
```

## Query `PTR` records:
```shell
dig -x <ip-address>
```

## Query all DNS record types:
```shell
dig ANY <domain>
```

<br><br>

## Query a specific DNS server:
```shell
dig <domain> @<dns-server>
```

## Query a specific DNS server on a specific port:
```shell
dig <domain> @<dns-server> -p <port>
```

## Query multiple domains in a single command:
```shell
dig <domain1> <domain2>
```

## Query multiple domains from file:
```shell
dig -f <file-name>
```

## Trace DNS lookup path:
```shell
dig <domain> +trace
``` 

## List DNS root servers:
```shell
dig
```

## List DNS servers for top-level domain `.se`:
```shell
dig NS se.
```

## Find all authoritative DNS servers for a domain:
```shell
dig <domain> +nssearch
```

## Initiate a DNS zone transfer from a specific DNS server:
```shell
dig AXFR <domain> @<dns-server>
```

<br><br>

## Get results in short format:
```shell
dig <domain> +short
```

## Display only answer section in output:
```shell
dig <domain> +noall +answer
```

## Omit stats section from output:
```shell
dig <domain> +nostats
```