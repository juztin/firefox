#
# Firefox Dev Channel
#

FROM ubuntu:14.04.2


MAINTAINER Justin Wilson <justin@minty.io>


RUN apt-get update && apt-get install -y \
	libfontconfig \
	libfreetype6 \
	libxrender1 \
	libasound2 \
	libdbus-glib-1-2 \
	libgtk2.0-0 \
	libxcomposite1 \
	libxdamage1 \
	libxext6 \
	libxfixes3 \
	libxt6


ADD https://download-installer.cdn.mozilla.net/pub/firefox/releases/38.0/linux-x86_64/en-US/firefox-38.0.tar.bz2 /tmp/firefox.tar.bz2

RUN mkdir /opt/firefox
RUN mkdir /data
RUN tar xjf /tmp/firefox.tar.bz2 -C /opt

ENTRYPOINT ["/opt/firefox/firefox"]
CMD ["-profile", "/data"]
