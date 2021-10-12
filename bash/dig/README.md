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
dig a <domain>
dig <domain>
```

## Query `AAAA` records:
```shell
dig aaaa <domain>
```

## Query `CNAME` records:
```shell
dig cname <domain>
```

## Query `MX` records:
```shell
dig mx <domain>
```

## Query `TXT` records:
```shell
dig txt <domain>
```

## Query `SRV` records:
```shell
dig srv <domain>
```

## Query `NS` records:
```shell
dig ns <domain>
```

## Query `SOA` records:
```shell
dig soa <domain>
```

## Query `PTR` records:
```shell
dig -x <ip-address>
```

## Query all DNS record types:
```shell
dig any <domain>
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
dig -f <filename>
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
dig ns se.
```

## Find all authoritative DNS servers for a domain:
```shell
dig <domain> +nssearch
```

## Initiate a DNS zone transfer from a specific DNS server:
```shell
dig axfr <domain> @<dns-server>
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