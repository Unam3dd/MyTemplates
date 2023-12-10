FROM --platform=linux/amd64 alpine:3.19.0
WORKDIR /project/
RUN apk update && apk upgrade && apk add --no-cache make gcc zsh bc util-linux pciutils usbutils coreutils binutils findutils grep iproute2 musl-dev
STOPSIGNAL SIGTERM
ENTRYPOINT ["/bin/zsh"]
