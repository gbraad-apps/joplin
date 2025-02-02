ARG BASE_IMAGE="ghcr.io/gbraad-devenv/fedora/rdesktop"
ARG BASE_VERSION=41

FROM ${BASE_IMAGE}:${BASE_VERSION}

ARG VERSION=3.2.12

USER root

RUN cd /tmp \
    && curl -fsSL https://objects.joplinusercontent.com/v${VERSION}/Joplin-${VERSION}.AppImage \
        -o /tmp/Joplin.AppImage \
    && chmod +x /tmp/Joplin.AppImage \
    && ./Joplin.AppImage --appimage-extract \
    && mv squashfs-root /opt/joplin \
    && rm -f Joplin.AppImage \
    && find /opt/joplin -type d -exec chmod 755 {} \; \
    && git config -f /etc/rdesktop/rdesktop.ini \
        rdesktop.title "Personal Joplin ${VERSION}" \
    && git config -f /etc/rdesktop/rdesktop.ini \
        rdesktop.exec "/opt/joplin/joplin"

# ensure to become root for systemd
#ENTRYPOINT ["/sbin/init"]
