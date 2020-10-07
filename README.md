## Quick reference
Maintained by: [Jean-Francois Arseneau](https://github.com/TheJF/agate)

Where to get help: [the Docker Community Forums](https://forums.docker.com/), [the Docker Community Slack](https://dockr.ly/slack), or [Stack Overflow](https://stackoverflow.com/search?tab=newest&q=docker)

## What is Agate?

Agate is a server for the Gemini network protocol, built with the Rust programming language. Agate has very few features, and can only serve static files. It uses async I/O, and should be quite efficient even when running on low-end hardware and serving many concurrent requests.

This Docker container wraps up https://github.com/mbrubeck/agate to deploy it in containers if you're into that, but probably makes it require more hardware.

## How to use this image

Two volumes _must_ be mounted for Agate to work, otherwise you will get errors. The first is a `content` volume that will contain your GMI files, and the other is a `keys` which must have `cert.pem` and `key.rsa` in it. See below to generate a self-signed certificate.

Once you have these two, replace the `/path/to/your` with your own path when running:

``` shell
docker run --name agate \
  -p 1965:1965 \
  --mount type=bind,source=/path/to/your/content,target=/var/agate/content \
  --mount type=bind,source=/path/to/your/keys,target=/var/agate/keys \
  thejf/agate
```

### Generate a self-signed certificate

With OpenSSL, to generate a self-signed certificate:

``` shell
openssl req -x509 -newkey rsa:4096 -keyout key.rsa -out cert.pem \
    -days 3650 -nodes -subj "/CN=example.com"
```
