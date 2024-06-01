FROM ubuntu:latest
WORKDIR /app
RUN apt-get update && apt-get install git gcc gcc-multilib make meson cmake pkg-config -y && apt-get clean
COPY . /app/
ENTRYPOINT ["/bin/sh"]
