FROM golang:alpine
MAINTAINER Joel Chen <joelchen@msn.com>
WORKDIR /tmp

ENV LIBVIPS_VERSION=8.5.7

RUN apk update && \
    apk upgrade && \
    apk add \
    zlib libxml2 libxslt glib libexif lcms2 fftw ca-certificates curl git \
    giflib libpng libwebp orc tiff poppler-glib librsvg wget && \

    apk add --no-cache --virtual .build-dependencies autoconf automake build-base \
    libtool nasm zlib-dev libxml2-dev libxslt-dev glib-dev \
    libexif-dev lcms2-dev fftw-dev giflib-dev libpng-dev libwebp-dev orc-dev tiff-dev \
    poppler-dev librsvg-dev wget && \

# Install mozjpeg
    cd /tmp && \
    git clone git://github.com/mozilla/mozjpeg.git && \
    cd /tmp/mozjpeg && \
    git checkout ${MOZJPEG_VERSION} && \
    autoreconf -fiv && ./configure --prefix=/usr && make install && \

# Install libvips
    wget -O- https://github.com/jcupitt/libvips/releases/download/v${LIBVIPS_VERSION}/vips-${LIBVIPS_VERSION}.tar.gz | tar xzC /tmp && \
    cd /tmp/vips-${LIBVIPS_VERSION} && \
    ./configure --prefix=/usr \
                --without-python \
                --without-gsf \
                --enable-debug=no \
                --disable-dependency-tracking \
                --disable-static \
                --enable-silent-rules && \
    make -s install-strip && \

# Cleanup
    rm -rf /tmp/vips-${LIBVIPS_VERSION} && \
    rm -rf /tmp/mozjpeg && \
    rm -rf /var/cache/apk/*
