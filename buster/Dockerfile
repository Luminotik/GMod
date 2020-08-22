###########################################################
# Dockerfile that builds a GMod Gameserver
###########################################################
FROM cm2network/steamcmd:root

LABEL maintainer="nick.nestor@me.com"

ENV STEAMAPPID 4020
ENV STEAMAPP gmod
ENV STEAMDIR "/home/steam"
ENV STEAMAPPDIR "${STEAMDIR}/${STEAMAPP}-dedicated"
ENV DLURL https://raw.githubusercontent.com/Luminotik/GMod

# Run Steamcmd and install GMod
# Create autoupdate config
# Remove packages and tidy up
RUN set -x \
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget=1.20.1-1.1 \
		ca-certificates=20190110 \
		libsdl2-2.0-0:i386=2.0.9+dfsg1-1 \
		lib32z1=1:1.2.11.dfsg-1 \
		libncurses5:i386=6.1+20181013-2+deb10u2 \
		libbz2-1.0:i386=1.0.6-9.2~deb10u1 \
		lib32gcc1=1:8.3.0-6 \
		lib32stdc++6=8.3.0-6 \
		libtinfo5:i386=6.1+20181013-2+deb10u2 \
		libcurl3-gnutls:i386=7.64.0-4+deb10u1 \
	&& su steam -c \
		"mkdir -p \"${STEAMAPPDIR}/${STEAMAPP}\" \
		&& wget "${DLURL}/master/etc/entry.sh" -O \"${STEAMDIR}/entry.sh\" \
        	&& chmod 755 \"${STEAMDIR}/entry.sh\" \
		&& { \
			echo '@ShutdownOnFailedCommand 1'; \
			echo '@NoPromptForPassword 1'; \
			echo 'login anonymous'; \
			echo 'force_install_dir \"${STEAMAPPDIR}\"'; \
			echo 'app_update \"${STEAMAPPID}\"'; \
			echo 'quit'; \
		} > \"${STEAMAPPDIR}/${STEAMAPP}_update.txt\" \
		&& wget -qO- "${DLURL}/master/etc/cfg.tar.gz" | tar xvzf - -C \"${STEAMAPPDIR}/${STEAMAPP}\"" \
	&& rm -rf /var/lib/apt/lists/*

ENV SRCDS_FPSMAX=300 \
	SRCDS_TICKRATE=66 \
	SRCDS_PORT=27015 \
	SRCDS_TV_PORT=27020 \
        SRCDS_NET_PUBLIC_ADDRESS="0" \
        SRCDS_IP="0" \
	SRCDS_MAXPLAYERS=16 \
	SRCDS_TOKEN=0 \
	SRCDS_RCONPW="changeme" \
	SRCDS_PW="changeme" \
	SRCDS_STARTMAP="gm_construct" \
	SRCDS_REGION=3 \
        SRCDS_HOSTNAME="New \"${STEAMAPP}\" Server" \
        SRCDS_WORKSHOP_START_MAP=0 \
        SRCDS_HOST_WORKSHOP_COLLECTION=0 \
        SRCDS_WORKSHOP_AUTHKEY=""

USER steam

WORKDIR ${STEAMDIR}

CMD ["bash", "entry.sh"]

# Expose ports
EXPOSE 27015/tcp 27015/udp 27020/udp