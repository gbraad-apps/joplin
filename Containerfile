ARG BASE_IMAGE="ghcr.io/gbraad-devenv/fedora/rdesktop"
ARG BASE_VERSION=41

FROM ${BASE_IMAGE}:${BASE_VERSION}

USER root

RUN dnf install -y \
	<replace> \
    && dnf clean all \
    && rm -rf /var/cache/yum \
    && git config -f /etc/rdesktop/rdesktop.ini \
	rdesktop.title "" \
    && git config -f /etc/rdesktop/rdesktop.ini \
	rdesktop.exec ""

# ensure to become root for systemd
#ENTRYPOINT ["/sbin/init"]
