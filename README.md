# lighttpd Docker Image

- [`lighttpd`](https://www.lighttpd.net/) is a secure, fast, compliant, and very flexible web-server that has been optimized for high-performance environments
- [`docker-lighttpd`](https://hub.docker.com/r/rtsp/lighttpd) is a lighttpd docker image designed to use as **base image** for building frontend/static web app docker image (e.g. [React](https://reactjs.org/))

## Base Image

- Use `docker-lighttpd` as a base image (`FROM`) and copy your web artifacts to `/var/www/html`
- Optimized for serving high traffic frontend/static web app

## Useful Info

### Paths

- `/var/www/html` - Document root
- `/etc/lighttpd/lighttpd.conf` - Entry point of to include configs from `conf.d/*.conf`
- `/etc/lighttpd/conf.d/`
  - `00-mime-types.conf` - MIME types definition derived from NGINX `/etc/nginx/mime.types`
  - `01-server.conf` `05-webroot.conf` `11-access.conf` - Configs derived from the default `lighttpd.conf`
  - `12-expire.conf` `13-status.conf` `14-rewrite.conf` - Example configs for several use cases

Feel free to replace or modify these config files if required!

### Default Config (lighttpd.conf)

- Run as `lighttpd` user
- Listen on port `80`
- No SSL/HTTPS (designed to run behind load balancer or reverse proxy server)
- No log file writing
- No Cache-Control header

## Examples

### Dockerize React App (Multi-Stage Build)

```
FROM node:14 AS builder

COPY package.json \
     package-lock.json \
     /usr/web/

WORKDIR /usr/web/
RUN npm ci

COPY public/ /usr/web/public/
COPY src/ /usr/web/src/
RUN npm run build

FROM rtsp/lighttpd
COPY --from=builder /usr/web/build/ /var/www/html/
```

### Directly use as Web Server (Volume mount)

```
docker run -d \
  --name your-webapp \
  -v /webapp/dir:/var/www/html:ro \
  -p 8080:80 \
  rtsp/lighttpd
```

- Mount /webapp/dir as your web app document root
- Publish website to port 8080 of Docker host machine.
- Enter http://localhost:8080

## Links

- [Docker Hub: rtsp/lighttpd](https://hub.docker.com/r/rtsp/lighttpd/)
- [GitHub: rtsp/docker-lighttpd](https://github.com/rtsp/docker-lighttpd)
