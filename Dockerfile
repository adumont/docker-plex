FROM ubuntu:latest
MAINTAINER Alexandre Dumont <adumont@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i -e '/^deb-src/ s/^/#/' /etc/apt/sources.list && \
   apt-get -qy update && \
   apt-get -qy dist-upgrade && \
   apt-get install -y --force-yes wget && \
   URL=$( wget -q http://plex.tv/downloads -O - | grep _amd64.deb | sed -e "s#^.*<a href=\"##;s#_amd64.deb.*\$#_amd64.deb#;s#https:#http:#"  | grep plexmediaserver_ ) && \
   wget -q -O plex.deb $URL && \
   dpkg -i plex.deb && \
   rm plex.deb && \
   apt-get -y autoremove --purge wget && \
   apt-get -y autoremove --purge && \
   apt-get -y clean && \
   rm -rf /var/lib/apt/lists/* && \
   rm -rf /tmp/* && \
   sed -i -e 's#^plex:.*$#plex:x:1001:#' /etc/group && \
   sed -i -e 's#^plex:.*$#plex:x:1001:1001::/var/lib/plexmediaserver:/bin/bash#' /etc/passwd

ADD start.sh /

USER plex

EXPOSE 32400

ENTRYPOINT ["/start.sh"]
