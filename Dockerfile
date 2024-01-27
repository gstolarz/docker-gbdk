ARG GBDK_VERSION=2.96a
ARG GBDK_ROOT=/opt/gbdk

FROM ubuntu:latest AS build

ARG GBDK_VERSION
ARG GBDK_ROOT

RUN apt-get update \
  && apt-get install -y bison flex g++ make patch wget xz-utils \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src

COPY gbdk.patch .

RUN wget ftp://ftp.gnu.org/pub/gnu/sed/sed-4.5.tar.xz \
  && wget https://sourceforge.net/projects/gbdk/files/gbdk/2.96/gbdk-$GBDK_VERSION.tar.gz \
  && wget https://sourceforge.net/projects/gbdk/files/maccer/0.25/maccer-0.25.tar.gz \
  && tar xf sed-4.5.tar.xz \
  && tar xf gbdk-$GBDK_VERSION.tar.gz \
  && tar xf maccer-0.25.tar.gz -C gbdk \
  && cd sed-4.5 \
  && mkdir build \
  && cd build \
  && ../configure \
  && make \
  && make install-strip \
  && cd ../.. \
  && find gbdk/gbdk-lib/examples -type f -exec chmod -x {} \; \
  && find gbdk/gbdk-lib/include -type f -exec chmod -x {} \; \
  && patch -p0 < gbdk.patch \
  && cd gbdk \
  && make install TARGETDIR=$GBDK_ROOT \
  && find $GBDK_ROOT -type f \( -name \*.asm -o -name \*.lst -o -name \*.sym \) -exec rm {} \;

FROM ubuntu:latest

ARG GBDK_ROOT

RUN apt-get update \
  && apt-get install -y make \
  && rm -rf /var/lib/apt/lists/*

COPY --from=build $GBDK_ROOT $GBDK_ROOT

ENV PATH $GBDK_ROOT/bin:$PATH
WORKDIR /workdir
