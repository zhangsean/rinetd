FROM debian:7-slim
LABEL MAINTAINER="zhangsean <zxf2342@qq.com>"

RUN apt update \
 && apt install -y rinetd \
 && apt clean all \
 && rm -rf /var/lib/apt/lists/*

RUN { \
	echo '#!/bin/bash'; \
	echo 'set -e'; \
	echo 'echo "0.0.0.0        8000    $1      $2" >> /rinetd.conf'; \
	echo 'echo "logfile /var/log/rinetd.log" >>/rinetd.conf'; \
	echo '/usr/sbin/rinetd -f -c /rinetd.conf'; \
    } > /rinetd-entrypoint.sh

RUN chmod +x /rinetd-entrypoint.sh

ENTRYPOINT ["/rinetd-entrypoint.sh"]
