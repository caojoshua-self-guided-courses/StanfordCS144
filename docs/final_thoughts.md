# Final Thoughts

There were about 20 days in between the first and last commit(2/13/20), but I spent way too much time on setting up the docker container. Without docker setup, i probably could have finished in three full weeks(16 days). The lab assignments were mostly straightforward, but at times the written requirements were unclear and I depended on following the testcases. There are some gaps in the lab structure, primarily testcase debug messaging and transparency(the whole testsuite code is confusing), but overall the course was very well organized compared to my UCI courses. The lab pdfs are well written, the codebase is well architectured and documented, and the testsuites are thorough. Building and running tests is straightforward.

The lab assignments served a decent introduction to Computer Networks. With ongoing supplemental reading, I can say I have a fair understanding of the topic. The TCP labs were most interesting and provided the most thorough learning experience and I would say I currently best understand that layer. The network interface and router labs were pretty basic coding and did not help me learn much about layers below the transport layer. The assignments did not cover the application layer, but that topic can be covered by supplemental reading.

For someone wanting to learn about computer networks, I would recommend going through the labs, but only as supplemental material. My current reading of *Computer Networking: A Top Down Approach* provides valuable, easy to digest content. I would avoid the slides from the course website, as they would only be useful with a lecturer talking over it. Although the labs themselves don't provide that much value, they are worth it for how quick it is.

## Individual Labs

### Lab 0 Webget and ByteStream
Really easy assignment that doesn't really touch into anything network specific.

### Lab 1 TCP Reassembler
The reassembler is the part of TCP that makes it interesting. Although this lab was straightforward, I came back to the reassembler in lab 4 for performance improvements. I changed the underlying data structure to remember substrings in [this commit](https://github.com/caojoshua/StanfordCS144-sponge/commit/2087109ef0ade1af7b766ec0ddc114092ccaf50c), which allowed the reassembler to push entire substrings instead of checking each individual byte. I also had another optimisation in substring logic in [this commit](https://github.com/caojoshua/StanfordCS144-sponge/commit/cfb43cdd89aacc064d0fa9afbe417bf9ba1f72c8).

### Lab 2 Wrapping Integers and TCP Receiver
The receiver was pretty easy to implement as its mostly a wrapper around the reassembler. The wrapping ints(32-bit integers should wrap around, emulating 64-bit integers) was also not too difficult, but although I passed all the testcases, I think there would be some edge cases were my implementation falls apart. The testcases does not stress too much on very large values that would need wrapping around.

### Lab 3 TCP Sender
This one took relatively long because requirements were unclear. Had to tackle testcases one by one.

### Lab 4 TCP Connection
This was the most time consuming lab. This lab involved stiching all the previously implemented TCP components together. The testcases are very thorough, involving two self-implemented TCP Connections interacting with each other, interacting with the Linux kernel TCP implementaion, and ultimately updating the webget implementation to use the new TCP Connection to interact with the web. I spent a significant amount of time figuring out docker networking issues (see [environment setup docs](https://github.com/caojoshua/StanfordCS144/blob/master/docs/env_setup.md), and a decent amount of time profiling and optimizing code (see lab1 notes).

The benchmark results were 1.8 Gbit/s without reordering and 1.1 Gbit/s with reordering, compared to 1.8 and 1.2 for the reference solution, although I'm not sure what hardware they were running on. The course did not award any additional points beyond 100 Mbit/s, so my implementation went beyond expectations. I had to decrease the testcase timeout in [this commit](https://github.com/caojoshua/StanfordCS144-sponge/commit/e0aece421d36dd16b9e52cc90090589e85913e0b), because for some reason two of the UDP testcases were taking about 13 seconds. I suspect this is a networking device issue and is unrelated to my implementation, since it performed well in the benchmarks.

### Lab 5 Network Interface and Lab 6 Router
Honestly both not that interesting work that can be finished in a night.

### Lab 7
This lab involves partner work and no additional coding, so I will ignore it.

## Final Diff
```
.gitignore                      |   2 ++
README.md                       |   4 +++
apps/webget.cc                  |  18 +++++++++--
etc/tests.cmake                 | 104 +++++++++++++++++++++++++++++++-------------------------------
libsponge/byte_stream.cc        |  68 ++++++++++++++++++++++++++++++-----------
libsponge/byte_stream.hh        |   7 +++++
libsponge/network_interface.cc  | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
libsponge/network_interface.hh  |  31 +++++++++++++++++++
libsponge/router.cc             |  34 ++++++++++++++++++---
libsponge/router.hh             |  11 +++++++
libsponge/stream_reassembler.cc | 160 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
libsponge/stream_reassembler.hh |  17 +++++++++++
libsponge/tcp_connection.cc     | 146 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
libsponge/tcp_connection.hh     |  11 +++++++
libsponge/tcp_receiver.cc       |  39 ++++++++++++++++++++++--
libsponge/tcp_receiver.hh       |   4 +++
libsponge/tcp_sender.cc         | 160 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
libsponge/tcp_sender.hh         |  29 ++++++++++++++++++
libsponge/wrapping_integers.cc  |  48 +++++++++++++++++++++++++----
	tun.sh                          |   5 ++-
20 files changed, 902 insertions(+), 113 deletions(-)
```
