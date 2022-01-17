FROM debian:buster-slim
MAINTAINER Prologue SOLUTIONS <entreprise@prologue-solutions.tn>

SHELL ["/bin/bash", "-xo", "pipefail", "-c"]

ENV LANG C.UTF-8

RUN apt-get update && apt-get install -y \
        ca-certificates \
        dirmngr \
        fonts-noto-cjk \
        gnupg \
        libssl-dev \
        node-less \
        npm \
        python3-num2words \
        python3-pdfminer \
        python3-pip \
        python3-phonenumbers \
        python3-pyldap \
        python3-qrcode \
        python3-renderpm \
        python3-setuptools \
        python3-slugify \
        python3-vobject \
        python3-watchdog \
        python3-xlrd \
        python3-xlwt \
        xz-utils

COPY ./wkhtmltox.deb ./wkhtmltox.deb

RUN echo 'ea8277df4297afc507c61122f3c349af142f31e5 wkhtmltox.deb' | sha1sum -c - \
    && apt-get install -y --no-install-recommends ./wkhtmltox.deb postgresql-client-common postgresql-client-11 \
    && npm install -g less less-plugin-clean-css rtlcss \
    && rm -rf ./wkhtmltox.deb && rm -rf /var/lib/apt/lists/*

