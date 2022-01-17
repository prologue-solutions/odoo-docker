FROM odoo-fourteen-base:latest as builder

RUN apt-get update && apt-get install git -y && mkdir /opt/ps/ \
    && git clone https://github.com/odoo/odoo --single-branch --depth 1 --branch 14.0 /opt/ps/odoo \
    && git clone git@github.com:prologue-solutions/odoo-fourteen.git --single-branch --depth 1 --branch main /opt/ps/odoo-fourteen \
    && pip3 install --upgrade pip \
    && pip install -r /opt/ps/odoo/requirements.txt \
    && pip install -r /opt/ps/odoo-fourteen/requirements.txt \
    && useradd -m -U -r -s /bin/bash odoo \
    && chown -R odoo:odoo /opt/ps/

FROM odoo-fourteen-base:latest
MAINTAINER Prologue SOLUTIONS <entreprise@prologue-solutions.tn>

# Set the default config file
ENV ODOO_RC /opt/ps/conf/odoo.conf

COPY ./main/odoo.conf /opt/ps/conf/
COPY ./main/wait-for-psql.py /usr/local/bin/
COPY ./main/entrypoint.sh /

RUN useradd -m -U -r -s /bin/bash odoo \
    && mkdir -p /opt/ps/data \
    && chown -R odoo:odoo /opt/ps \
    && pip3 install --ignore-installed pip

COPY --from=builder /opt/ps/odoo-bin /opt/ps/
COPY --from=builder /opt/ps/odoo /opt/ps/odoo
COPY --from=builder /opt/ps/addons /opt/ps/addons
COPY --from=builder /opt/ps/odoo-fourteen/addons /opt/ps/odoo-fourteen

COPY --from=builder /opt/ps /opt/ps
COPY --from=builder /usr/lib/python3/dist-packages /usr/lib/python3/dist-packages
COPY --from=builder /usr/local/lib/python3.7/dist-packages /usr/local/lib/python3.7/dist-packages

VOLUME ["/opt/ps/data"]



