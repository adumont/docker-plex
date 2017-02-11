FROM ubuntu:latest
MAINTAINER Alexandre Dumont <adumont@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive

COPY root/ /

RUN sed -i -e '/^deb-src/ s/^/#/' /etc/apt/sources.list && \
   apt-get -qy update && \
   apt-get -qy dist-upgrade && \
   apt-get install -y --force-yes curl && \
   /installBinary.sh && \
   apt-get -y autoremove --purge curl && \
   apt-get -y autoremove --purge && \
   apt-get -y clean && \
   rm -rf /var/lib/apt/lists/* && \
   rm -rf /tmp/* /var/tmp/* && \
   sed -i -e 's#^plex:.*$#plex:x:1001:#' /etc/group && \
   sed -i -e 's#^plex:.*$#plex:x:1001:1001::/var/lib/plexmediaserver:/bin/bash#' /etc/passwd

ADD start.sh /

USER plex

EXPOSE 32400

ENTRYPOINT ["/start.sh"]
