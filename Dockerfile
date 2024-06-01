FROM ubuntu:22.04

HEALTHCHECK NONE

RUN apt-get update && \
    apt-get install git gcc gcc-multilib make python3-pip cmake pkg-config ninja-build --no-install-recommends sudo -y && \
    apt-get clean && pip install meson

RUN useradd --create-home nonroot

WORKDIR /home/nonroot/app

COPY --chown=nonroot:nonroot . /home/nonroot/app

RUN make release

USER nonroot

ENTRYPOINT ["/bin/sh"]
