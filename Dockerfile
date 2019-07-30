FROM quay.io/fedora/fedora:31-x86_64

ENV SQUID_OPTS "-N -d 3"
ENV SQUID_CONF "/etc/squid/squid.conf"

# Squid and tools for troubleshooting
RUN dnf install --nodocs -y squid \
    bind-utils procps less tree && \
    dnf clean all && \
    rm -rf /var/cache/dnf 

LABEL   io.k8s.display-name="Squid" \
        io.k8s.description="Squid Proxy Server."

# Using shell mode for env vars substitution
ENTRYPOINT /usr/sbin/squid ${SQUID_OPTS} -f ${SQUID_CONF}