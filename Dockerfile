FROM ubuntu:18.04
LABEL Maintainer="Xindi Guo"

RUN apt-get update && apt-get install -y curl g++ git unzip python3 python3-pip wget autoconf automake make gcc perl zlib1g-dev libbz2-dev liblzma-dev libcurl4-gnutls-dev libssl-dev libncurses5-dev clang-4.0 golang-1.9 libz-dev

RUN pip3 install baseqDrops==2.0

RUN mkdir /usr/app
WORKDIR /usr/app

RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y && \
    /root/.cargo/bin/rustup install 1.19.0 && \
    /root/.cargo/bin/rustup default 1.19.0

ENV PATH=/usr/lib/go-1.9/bin:/root/.cargo/bin:$PATH

RUN git clone https://github.com/beiseq/baseqDrops.git
RUN git clone https://github.com/10XGenomics/cellranger

RUN wget https://github.com/alexdobin/STAR/archive/2.7.0d.zip
RUN wget https://github.com/samtools/samtools/archive/1.9.zip 
RUN wget https://github.com/samtools/htslib/archive/1.9.zip -O htslib.zip

RUN unzip 2.7.0d.zip -d star
RUN rm 2.7.0d.zip

RUN unzip 1.9.zip -d samtools
RUN rm 1.9.zip

RUN unzip htslib.zip -d htslib
RUN rm htslib.zip

# Building STAR
WORKDIR /usr/app/star/STAR-2.7.0d/source
RUN make STAR STARlong
RUN make install

# Their make install moves the binaries locally
# so we move them again to /usr/local/bin
WORKDIR /usr/app/star/STAR-2.7.0d/bin
RUN mv STAR STARlong /usr/local/bin

# Building samtools
WORKDIR /usr/app/samtools/samtools-1.9
RUN autoheader
RUN autoconf -Wno-syntax
RUN ./configure --with-htslib=/usr/app/htslib/htslib-1.9
RUN make
RUN make install

WORKDIR /usr/app/cellranger
RUN make

# ENV variables for cellranger
ENV PATH=/usr/app/cellranger/bin:/usr/app/cellranger/lib/bin:$PATH
ENV MROPATH=/usr/app/cellranger/mro:$MROPATH
ENV PYTHONPATH=/usr/app/cellranger/python:$PYTHONPATH

# ENV variables for baseqDropsk, since it requires UTF8
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

WORKDIR /usr/app

RUN baseqDrops run-pipe --help
