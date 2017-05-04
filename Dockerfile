FROM golang:alpine
MAINTAINER Joel Chen <joelchen@msn.com>
WORKDIR /tmp

ENV LIBVIPS_VERSION=8.5.4

RUN apk add --no-cache --virtual .build-deps gcc g++ make libc-dev curl automake libtool tar gettext && apk add --no-cache --virtual .libdev-deps glib-dev libpng-dev libwebp-dev libexif-dev libxml2-dev librsvg-dev lcms2-dev giflib-dev poppler-dev fftw-dev orc-dev tiff-dev imagemagick-dev libjpeg-turbo-dev && apk add --no-cache --virtual .runtime-deps git libpng libwebp libexif libxml2 librsvg libjpeg-turbo pkgconfig && curl -O https://github.com/jcupitt/libvips/releases/download/v${LIBVIPS_VERSION}/vips-${LIBVIPS_VERSION}.tar.gz && tar zvxf  && cd vips-${LIBVIPS_VERSION} && ./configure --without-python --without-gsf --disable-static --enable-debug=no --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info --docdir=/usr/share/doc && make && make install && rm -rf /tmp/vips-* && rm -rf /var/cache/apk/* && rm -rf /tmp/vips-*
