FROM ubuntu:18.04
LABEL Maintainer="Xindi Guo <xindi.guo@sagebase.org>"

RUN apt-get update && apt-get install -y curl g++ git unzip python3 python3-pip wget autoconf automake make gcc perl zlib1g-dev libbz2-dev liblzma-dev libcurl4-gnutls-dev libssl-dev libncurses5-dev

RUN pip3 install baseqDrops==2.0

RUN mkdir /usr/app
WORKDIR /usr/app

RUN git clone https://github.com/beiseq/baseqDrops.git

RUN wget https://github.com/alexdobin/STAR/archive/2.6.1d.zip
RUN wget https://github.com/samtools/samtools/archive/1.9.zip 
RUN wget https://github.com/samtools/htslib/archive/1.9.zip -O htslib.zip

RUN unzip 2.6.1d.zip -d star
RUN rm 2.6.1d.zip

RUN unzip 1.9.zip -d samtools
RUN rm 1.9.zip

RUN unzip htslib.zip -d htslib
RUN rm htslib.zip

# Building STAR
WORKDIR /usr/app/star/STAR-2.6.1d/source
RUN make STAR STARlong
RUN make install

# Their make install moves the binaries locally
# so we move them again to /usr/local/bin
WORKDIR /usr/app/star/STAR-2.6.1d/bin
RUN mv STAR STARlong /usr/local/bin

# Building samtools
WORKDIR /usr/app/samtools/samtools-1.9
RUN autoheader
RUN autoconf -Wno-syntax
RUN ./configure --with-htslib=/usr/app/htslib/htslib-1.9
RUN make
RUN make install

# ENV variables for baseqDropsk, since it requires UTF8
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

WORKDIR /usr/app

ENTRYPOINT ["baseqDrops"]

