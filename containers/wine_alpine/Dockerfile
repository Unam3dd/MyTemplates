FROM alpine:3.19.0
RUN apk update && apk upgrade && apk add --no-cache make wine gstreamer bc git
RUN wine64 --version && wine64 winecfg
STOPSIGNAL SIGTERM
ENTRYPOINT ["/bin/sh"]
