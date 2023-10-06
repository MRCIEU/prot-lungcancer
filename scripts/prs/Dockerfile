FROM ubuntu:18.04

ADD http://code.enkre.net/bgen/tarball/release/v1.1.7 v1.1.7.tgz
ADD https://s3.amazonaws.com/plink2-assets/plink2_linux_avx2_20231005.zip plink2_linux_avx2_20231005.zip

RUN apt-get update && apt-get install -y --no-install-recommends \
      g++ \
      make \
      python3 \
      gfortran \
      zlib1g-dev \
      unzip \
      && tar -xzf v1.1.7.tgz \
      && rm v1.1.7.tgz \
      && cd v1.1.7 \
      && python3 waf configure \
      && python3 waf \
      && python3 waf install

RUN   unzip plink2_linux_avx2_20231005.zip \
      && rm plink2_linux_avx2_20231005.zip \
      && mv plink2 /usr/bin/local
