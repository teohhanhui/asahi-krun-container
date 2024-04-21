ARG FEDORA_VERSION=39
ARG ARCH=aarch64
FROM quay.io/fedora/fedora:${FEDORA_VERSION}-${ARCH}

# explicitly set user/group IDs, and create the steam user's home directory
RUN set -eux; \
	groupadd --gid=1000 steam; \
	useradd --uid=1000 --gid steam --shell /bin/bash --create-home steam; \
# also create the steam user's XDG_RUNTIME_DIR with appropriate permissions
	mkdir -p /run/user/1000; \
	chown -R steam:steam /run/user/1000

RUN set -eux; \
	mesaPackages=" \
		mesa-dri-drivers \
		mesa-libEGL \
		mesa-libEGL-devel \
		mesa-libgbm \
		mesa-libGL \
		mesa-va-drivers \
	"; \
	soundPackages=" \
		alsa-lib \
		pipewire-libs \
		pulseaudio \
		pulseaudio-libs \
	"; \
	dnf install -y --setopt=install_weak_deps=False 'dnf-command(copr)'; \
	dnf copr enable -y slp/asahi-mesa; \
	dnf copr enable -y teohhanhui/asahi-krun; \
	dnf install -y --setopt=install_weak_deps=False \
		$mesaPackages \
		$soundPackages \
		dhcp-client \
		glmark2 \
		sommelier \
		xorg-x11-server-Xwayland \
	; \
	dnf clean all

# grab gosu for easy step-down from root
COPY --from=docker.io/tianon/gosu /gosu /usr/local/bin/

COPY entrypoint.sh entrypoint-user.sh /usr/local/bin/

ENTRYPOINT ["entrypoint.sh"]
CMD ["entrypoint-user.sh", "bash"]
