FROM ubuntu:22.04
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get update && \
	apt-get install -y locales && \
	sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
	locale-gen && \
	\
	apt-get upgrade -y && \
	apt-get install -y \
	build-essential \
	chrpath \
	cpio \
	diffstat \
	file \
	g++ \
	gawk \
	gcc \
	git \
	lz4 \
	make \
	python3 \
	python3-pip \
	sbsigntool \
	wget \
	zstd && \
	\
	apt-get purge -y --auto-remove && \
	rm -rf /var/lib/apt/lists/*

RUN useradd -m -u 1000 yocto
USER yocto
WORKDIR /home/yocto
RUN git clone -b bob/fwupd https://github.com/gmbr3/poky
WORKDIR poky
RUN git clone -b kirkstone https://git.openembedded.org/meta-openembedded
RUN mkdir build
COPY init .
CMD /home/yocto/poky/init
