FROM python:3.7.12-slim-buster
MAINTAINER Prologue SOLUTIONS <entreprise@prologue-solutions.tn>

SHELL ["/bin/bash", "-xo", "pipefail", "-c"]

ENV LANG C.UTF-8

RUN apt-get update

RUN apt-get install -y --no-install-recommends npm

COPY ./wkhtmltox.deb ./wkhtmltox.deb

RUN echo 'ea8277df4297afc507c61122f3c349af142f31e5 wkhtmltox.deb' | sha1sum -c - \
    && apt-get install -y --no-install-recommends ./wkhtmltox.deb postgresql-client-common postgresql-client-11 \
    && npm install -g less less-plugin-clean-css rtlcss \
    && rm -rf /var/lib/apt/lists/*

