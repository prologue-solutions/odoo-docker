FROM odoo-fourteen-base:latest as builder

COPY ./sources/odoo-14/odoo /opt/odoo/main
COPY ./sources/odoo-14/addons /opt/odoo/addons

RUN useradd -m -U -r -s /bin/bash odoo \
    && chown -R odoo:odoo /opt/odoo/

FROM odoo-fourteen-base:latest
MAINTAINER Prologue SOLUTIONS <entreprise@prologue-solutions.tn>

# Set the default config file
ENV ODOO_RC /opt/odoo/conf/odoo.conf

COPY ./odoo.conf /opt/odoo/conf/

RUN useradd -m -U -r -s /bin/bash odoo \
    && mkdir -p /opt/odoo/data \
    && chown -R odoo:odoo /opt/odoo/data \
    && chown -R odoo:odoo /opt/odoo/conf

COPY --from=builder /opt/odoo /opt/odoo

COPY wait-for-psql.py /usr/local/bin/wait-for-psql.py
COPY ./entrypoint.sh /

VOLUME ["/opt/odoo/data"]



