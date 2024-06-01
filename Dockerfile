FROM ubuntu:22.04

HEALTHCHECK NONE

RUN apt-get update && \
    apt-get install git gcc gcc-multilib make python3-pip cmake pkg-config ninja-build sudo --no-install-recommends -y && \
    apt-get clean && pip install meson

RUN useradd --create-home nonroot

WORKDIR /home/nonroot/app

COPY --chown=nonroot:nonroot . /home/nonroot/app

RUN make release clean

USER nonroot

ENTRYPOINT ["/bin/sh"]
