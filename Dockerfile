# syntax=docker/dockerfile:1
# ASSUME THE FOLLOWING:
# /data is mapped to the game server
# Server jar file is located in /data/server.jar, where /data is the server directory (i.e. /data/server.properties is the server properties file)
# JAVA_VERSION is Java 8 by default, but can be changed to Java 8, 17, etc., with JAVA_VERSION=8, JAVA_VERSION=17, etc.
# The server is run in `tmux` to enable access to console when attaching to container

FROM debian:bullseye
WORKDIR /data
EXPOSE 25565
EXPOSE 25575
COPY ./scripts/install-pkgs.sh /install.sh
RUN /install.sh
COPY ./scripts /scripts
COPY ./bashrc /root/.bashrc


ENTRYPOINT ["/scripts/start.sh"]
