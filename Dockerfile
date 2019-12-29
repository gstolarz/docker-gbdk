FROM ubuntu AS build

RUN apt-get update \
  && apt-get install -y bison flex g++ make patch wget \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src

COPY gbdk.patch /usr/src

RUN wget https://sourceforge.net/projects/gbdk/files/gbdk/2.96/gbdk-2.96a.tar.gz \
  && wget https://sourceforge.net/projects/gbdk/files/maccer/0.25/maccer-0.25.tar.gz \
  && tar xfz gbdk-2.96a.tar.gz \
  && tar xfz maccer-0.25.tar.gz -C gbdk \
  && find gbdk/gbdk-lib/examples -type f -exec chmod -x {} \; \
  && find gbdk/gbdk-lib/include -type f -exec chmod -x {} \; \
  && patch -p0 < gbdk.patch \
  && cd gbdk \
  && make install \
  && find /opt/gbdk -type f -name *.asm -o -name *.lst -o -name *.sym -exec rm {} \;

FROM ubuntu

RUN apt-get update \
  && apt-get install -y make \
  && rm -rf /var/lib/apt/lists/*

COPY --from=build /opt/gbdk /opt/gbdk

ENV PATH /opt/gbdk/bin:$PATH

WORKDIR /workdir
