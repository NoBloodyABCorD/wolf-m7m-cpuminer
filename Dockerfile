#
# Dockerfile for cpuminer
# usage: docker run creack/cpuminer --url xxxx --user xxxx --pass xxxx
# ex: docker run creack/cpuminer --url stratum+tcp://ltc.pool.com:80 --user creack.worker1 --pass abcdef
#
#

FROM		ubuntu:12.10
MAINTAINER	Guillaume J. Charmes <guillaume@charmes.net>

RUN		apt-get update -qq

RUN		apt-get install -qqy automake
RUN		apt-get install -qqy libcurl4-openssl-dev
RUN		apt-get install -qqy git
RUN		apt-get install -qqy make

RUN		git clone https://github.com/NoBloodyABCorD/wolf-m7m-cpuminer

RUN		cd wolf-m7m-cpuminer && ./autogen.sh
RUN		cd wolf-m7m-cpuminer && CFLAG="-O2 mfpu=neon-vfpv4" ./configure
RUN		cd wolf-m7m-cpuminer && make -j4

WORKDIR		/wolf-m7m-cpuminer
ENTRYPOINT	["./minerd"]
