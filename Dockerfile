FROM alpine:3.15.0
LABEL maintainer=jerrychen052004@gmail.com

ENV HOME=/root \
	DEBIAN_FRONTEND=noninteractive \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8 \
	LC_ALL=C.UTF-8 \
	REMOTE_HOST=localhost \
	REMOTE_PORT=5900

RUN apk --update --upgrade add git bash supervisor nodejs npm \
	&& git clone https://github.com/jerrychen052004/novnc-with-websockify /root/noVNC \
	&& rm -rf /root/noVNC/.git \
	&& cd /root/noVNC \
	&& npm install npm@latest \
	&& npm install \
	&& apk del git npm nodejs

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8081

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
