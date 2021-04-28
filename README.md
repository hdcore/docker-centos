# Docker-centos

HDCore extended docker image for ruby/oracle development

For use in DOckerfile or docker-compose.yml

```
FROM hdcore/docker-centos:centos7-sfpd
```

# Custom scripts

## Add custom CA certificates

```bash
. addcacerts.sh
```

## Configure proxy

```bash
. addgitproxy.sh
```