FROM lsiobase/alpine.python:3.7

LABEL maintainer="scottieh"

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	g++ \
	gcc \
	make \
	python-dev && \
 echo "**** install pip packages ****" && \
 pip install --no-cache-dir -U \
	pycryptodomex && \
 echo "**** install app ****" && \
 git clone -b beta --depth 1 https://github.com/Tautulli/Tautulli /app/tautulli && \
 echo "**** cleanup ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root/.cache

# add local files
COPY root/ /

# ports and volumes
VOLUME /config /logs
EXPOSE 8181
