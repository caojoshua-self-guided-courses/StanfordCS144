FROM ubuntu:18.04
LABEL maintainer="https://github.com/caojoshua/"

COPY setup_dev_env.sh /setup_dev_env.sh
RUN chmod +x setup_dev_env.sh
WORKDIR /cs144
