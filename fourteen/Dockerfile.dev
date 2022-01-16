FROM odoo-fourteen-base:latest
MAINTAINER Prologue SOLUTIONS <entreprise@prologue-solutions.tn>

## Expose Odoo services
EXPOSE 8069 8071 8072

# Set default user when running the container
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]