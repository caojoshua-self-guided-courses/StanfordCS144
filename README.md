# StanfordCS144
Stanford CS 144 Introduction to Computer Networking

I never learned about computer networks, so I will be taking a self-guided course of [Stanford CS 144 Introduction to Computer Networking](https://cs144.github.io/). I will be skimming over lecture notes and completing all the labs. A large portion of the course material is on online quizzes and videos that I don't have access to, so I instead will be selectively reading from Kurose and Ross, *Computer Networking: A Top Down Approach*. I will not be looking at exams.

The labs are run from a Docker container. This repository holds the Dockerfile and setup scripts. The labs are contained in a git submodule pointing to [my personal fork of the CS144 lab repository](https://github.com/caojoshua/StanfordCS144-sponge/). `StanfordCS144-sponge` subdirectory is added to the container as a volume, so that changes from a local text editor are propagated into the container.

## Prerequisites
* GNU Make
* Docker

## Setup
```
make image
make container
make
```

From there, follow the course instructions for building and running the programs. If running into an issue with `iptables`, try manually running `/home/user/cs144/tun.sh restart 144 145`. If that doesn't work, try running the same script in the host. See docs/ for more information.

After exiting the container, you can bash back into it with `make`. Subsequent bash into the container does not require running the setup script. If the container is ever stopped (eg. after reboot), you can restore it with `make start-container`. Run `make clean-container` to clean and remove the container.

Run `make tags` to generate ctags and `make cscope` to generate a cscope database.
