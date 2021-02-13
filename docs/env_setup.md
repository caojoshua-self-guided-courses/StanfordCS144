# Environment Setup Notes

I ran the labs for this course in a docker container, as opposed to the recommended course-provided VirtualBox image. This was probably my biggest mistake, since I spent nearly half of the total time just trying to get the container working. First lesson learned is that docker networking can at times be weird, especially if working with iptables and TUN/TAP devices. Second lesson learned is to lean towards course-provided environments over ad-hoc enviroments.

The tun.sh script has some issues. The testsuite will run `tun.sh check 144 145`, which under the hood will also call `tun.sh start 144 145` if tun144 and tun145 devices have not been created yet. However, if the devices are created, but the iptable masquerading has not been successfully applied, it does not rerun the start. The script ideally should rerun the start if both tun devices and iptables are not configured yet.

Because of the tun.sh issue, I was at some point in a scenario in which I had tun devices setup, but not iptables masquerading. This prevented me from passing the webget testcase using the self-implemented TCPConnection.

Many of the larger TCPConnection IP mode testcases fail, so I removed them in [this commit](https://github.com/caojoshua/StanfordCS144-sponge/commit/e13f0d9e7e13c7cbda02a34941ff38598861d6df). Whats interesting is that, when I was in the scenario described in the previous paragraph, these testcases were passing without iptables masquerading setup. Once I 'fixed' everything, some of these testcases started failing.

I tried a number of things to make all the networking work, including `docker run` with flags `--privileged` and `--network=host`. None of these worked, and when trying to use the host network, the webget and every single IP testcases ran into errors. I ultimately spent too much time trying to figure this out, and decided to just remove the testcases since they weren't adding any value to testing my implementation.

Another point is that running iptables in tun.sh sometimes fails due to permission errors. I am not sure what exactly I've done to fix it, but running `tun.sh start 144 145` seems to fix it. I guess configuring iptables in the host somehow fixes things in the docker container, but can't say for sure.
