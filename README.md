# Docker-centos

HDCore extended docker image for centos7 with Ruby 2.4.6 and Python 2.7.5 development with Oracle Client 19 support

# FAQ

## Building the image

### Default

```bash
docker image build . -f .\centos7\Dockerfile -t hdcore/docker-centos:centos7 --rm --progress plain
```

### Add proxy during build time only

```bash
docker image build . -f .\centos7\Dockerfile -t hdcore/docker-centos:centos7 --build-arg http_proxy=http://proxy.url:8080 --rm --progress plain
```

### Add extra CA certificates during build
- Add the *.crt to the /certificates/ folder.

## Running the image

### Default
```
FROM hdcore/docker-centos:centos7
```

### Command line
```bash
docker-compose run --rm local-centos7-run
```

### Add proxy on startup
- Add environment variable http_proxy.

### Add extra CA certificates on startup
- Add the *.crt to the /certificates/ folder.
- Add CACERT_FILE_XXXX environment variable who points to local filename

## Scripts

### Default
- /bin/bash

### Sleep infinity
- run-infinity.sh