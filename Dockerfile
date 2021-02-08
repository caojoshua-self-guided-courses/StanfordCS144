FROM ubuntu:18.04
LABEL maintainer="https://github.com/caojoshua/"

# Add sudo. Required to run setup script.
RUN apt-get update && apt-get -y install sudo

# Setup user. Required because some scripts expect to be run as non-root user.
ARG user=user
ARG passwd=pass
ARG user_home=/home/${user}
RUN useradd -ms /bin/bash ${user}
RUN echo ${user}:${passwd} | chpasswd
RUN adduser ${user} sudo

# Install tzdata and wireshark and prevent it from asking for input. Would be installed in setup script.
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Los_Angeles
RUN apt-get install -y tzdata wireshark-common

# Setup script
ARG setup_script=${user_home}/setup_dev_env.sh
ARG TZ=America/Los_Angeles
COPY setup_dev_env.sh ${setup_script}
RUN chmod +x ${setup_script} && ${setup_script}

USER ${user}
WORKDIR ${user_home}/cs144
