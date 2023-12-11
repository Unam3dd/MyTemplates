FROM ubuntu:22.04
RUN apt-get update && apt-get upgrade -y && apt-get install gcc make zsh bc libcriterion-dev git cmake -y && apt-get clean
RUN git clone --recursive https://github.com/Snaipe/Criterion
RUN cd Criterion && mkdir build && cd build && cmake .. && cmake --build . && make install
WORKDIR /project/
STOPSIGNAL SIGTERM
ENTRYPOINT ["make", "re", "test_clean", "build_test", "test_clean"]
