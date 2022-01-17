FROM odoo-fourteen-base:latest as builder

RUN apt-get update && apt-get install git -y

COPY ./sources/odoo-14/odoo /opt/ps/odoo
COPY ./sources/odoo-14/addons /opt/ps/addons
COPY ./sources/odoo-14/requirements.txt /opt/ps/requirements/
COPY ./sources/odoo-14/odoo-bin /opt/ps/

RUN pip3 install --upgrade pip \
    && pip install -r /opt/ps/requirements/requirements.txt \
    && pip install psycopg2-binary

RUN useradd -m -U -r -s /bin/bash odoo \
    && chown -R odoo:odoo /opt/ps/

FROM odoo-fourteen-base:latest
MAINTAINER Prologue SOLUTIONS <entreprise@prologue-solutions.tn>

# Set the default config file
ENV ODOO_RC /opt/ps/conf/odoo.conf

COPY ./local/odoo.conf /opt/ps/conf/
COPY ./local/wait-for-psql.py /usr/local/bin/
COPY ./local/entrypoint.sh /

RUN useradd -m -U -r -s /bin/bash odoo \
    && mkdir -p /opt/ps/data \
    && chown -R odoo:odoo /opt/ps \
    && pip3 install --ignore-installed pip

COPY --from=builder /opt/ps /opt/ps
COPY --from=builder /usr/lib/python3/dist-packages /usr/lib/python3/dist-packages
COPY --from=builder /usr/local/lib/python3.7/dist-packages /usr/local/lib/python3.7/dist-packages

VOLUME ["/opt/ps/data"]



