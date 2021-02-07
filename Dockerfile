ARG ALPINE_VERSION=3.13
FROM alpine:${ALPINE_VERSION}

LABEL maintainer="RTSP <docker@rtsp.us>"

ARG LIGHTTPD_VERSION=1.4.57-r0
RUN set -x \
    && apk add --no-cache \
    lighttpd${LIGHTTPD_VERSION:+=}${LIGHTTPD_VERSION} \
    lighttpd-mod_auth${LIGHTTPD_VERSION:+=}${LIGHTTPD_VERSION} \
    && rm -rvf /var/cache/apk/* \
    && rm -rvf /etc/lighttpd/* /etc/logrotate.d/lighttpd /var/log/lighttpd /var/www/localhost \
    && mkdir -vp /var/www/html

COPY files/lighttpd/* /etc/lighttpd/

EXPOSE 80/tcp

ENTRYPOINT ["/usr/sbin/lighttpd"]
CMD ["-D", "-f", "/etc/lighttpd/lighttpd.conf"]
