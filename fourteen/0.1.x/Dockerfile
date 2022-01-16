FROM python:3.7.12-slim-buster
MAINTAINER Prologue SOLUTIONS <entreprise@prologue-solutions.tn>

SHELL ["/bin/bash", "-xo", "pipefail", "-c"]

ENV LANG C.UTF-8

RUN apt-get update

RUN apt-get install -y --no-install-recommends curl npm

RUN curl -o wkhtmltox.deb -sSL https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.buster_amd64.deb \
    && echo 'ea8277df4297afc507c61122f3c349af142f31e5 wkhtmltox.deb' | sha1sum -c - \
    && apt-get install -y --no-install-recommends ./wkhtmltox.deb postgresql-client-common postgresql-client-11 \
    && npm install -g less less-plugin-clean-css rtlcss \
    && rm -rf /var/lib/apt/lists/*

COPY ./sources/odoo-14/odoo /opt/odoo/main
COPY ./sources/odoo-14/addons /opt/odoo/addons

# Copy entrypoint script and Odoo configuration file
COPY ./entrypoint.sh /
COPY ./odoo.conf /opt/odoo/conf/

# Set the default config file
ENV ODOO_RC /etc/odoo/odoo.conf

COPY wait-for-psql.py /usr/local/bin/wait-for-psql.py

RUN useradd -m -U -r -s /bin/bash odoo \
    && mkdir -p /opt/odoo/data \
    && chown -R odoo /opt/odoo

VOLUME ["/opt/odoo/data"]

# Expose Odoo services
EXPOSE 8069 8071 8072