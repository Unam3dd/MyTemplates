FROM debian:stable-slim
WORKDIR /project/
RUN apt-get update && apt-get upgrade -y && apt-get install gcc make zsh bc -y && apt-get clean
STOPSIGNAL SIGTERM
ENTRYPOINT ["/bin/zsh"]
