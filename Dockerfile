FROM odoo:19.0

LABEL org.opencontainers.image.title="school-lms" \
      org.opencontainers.image.description="OpenEduCat 19.0 addons on top of the official Odoo 19.0 image" \
      org.opencontainers.image.source="https://gitlab.com/Tenuka22/school-lms"

# Branch 19.0 tracks upstream OpenEduCat. Pin to a commit SHA
# (https://github.com/openeducat/openeducat_erp/commits/19.0) for a reproducible image.
ARG OPENEDUCAT_TARBALL=https://codeload.github.com/openeducat/openeducat_erp/tar.gz/refs/heads/19.0

ENV PYTHONUNBUFFERED=1

USER odoo

# /mnt/extra-addons is on the addons_path in the base image odoo.conf.
# curl and tar are already present in odoo:19.0, so no extra packages.
RUN curl -fsSL "${OPENEDUCAT_TARBALL}" -o /tmp/openeducat.tar.gz \
    && mkdir -p /mnt/extra-addons \
    && tar -xzf /tmp/openeducat.tar.gz -C /mnt/extra-addons --strip-components=1 \
    && rm -f /tmp/openeducat.tar.gz \
    && test -f /mnt/extra-addons/openeducat_core/__manifest__.py