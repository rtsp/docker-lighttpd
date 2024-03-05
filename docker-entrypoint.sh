#!/bin/sh
# https://redmine.lighttpd.net/issues/2731
mkfifo -m 600 /tmp/logpipe
cat <> /tmp/logpipe 1>&2 &
chown lighttpd /tmp/logpipe
/usr/sbin/lighttpd -D -f /etc/lighttpd/lighttpd.conf 2>&1