FROM debian:stable-slim
WORKDIR /app
COPY . /app/
RUN apt-get update && apt-get install git gcc gcc-multilib make meson cmake pkg-config -y && apt-get clean
ENTRYPOINT ["/bin/sh"]
