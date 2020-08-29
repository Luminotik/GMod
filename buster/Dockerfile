###########################################################
# Dockerfile that builds a GMod Gameserver
###########################################################
FROM cm2network/steamcmd:root

LABEL maintainer="nick.nestor@me.com"

ENV STEAMDIR "/home/steam"
ENV STEAMAPPID1 4020
ENV STEAMAPP1 garrysmod
ENV STEAMAPPDIR1 "${STEAMDIR}/${STEAMAPP1}-dedicated"
ENV STEAMAPPID2 232330
ENV STEAMAPP2 css
ENV STEAMAPPDIR2 "${STEAMDIR}/${STEAMAPP2}-dedicated"
ENV DLURL https://raw.githubusercontent.com/Luminotik/GMod

# Run Steamcmd and install GMod and CSS
# Create autoupdate config
# Remove packages and tidy up
RUN set -x \
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget=1.20.1-1.1 \
		ca-certificates=20190110 \
		lib32gcc1=1:8.3.0-6 \
		lib32stdc++6=8.3.0-6 \
		libtinfo5:i386=6.1+20181013-2+deb10u2 \
	&& su steam -c \
		"mkdir -p \"${STEAMAPPDIR1}/${STEAMAPP1}\" \
		&& mkdir -p \"${STEAMAPPDIR2}/${STEAMAPP2}\" \
		&& wget "${DLURL}/master/etc/entry.sh" -O \"${STEAMDIR}/entry.sh\" \
        	&& chmod 755 \"${STEAMDIR}/entry.sh\" \
		&& { \
			echo '@ShutdownOnFailedCommand 1'; \
			echo '@NoPromptForPassword 1'; \
			echo 'login anonymous'; \
			echo 'force_install_dir \"${STEAMAPPDIR1}\"'; \
			echo 'app_update \"${STEAMAPPID1}\"'; \
			echo 'force_install_dir \"${STEAMAPPDIR2}\"'; \
			echo 'app_update \"${STEAMAPPID2}\"'; \
			echo 'quit'; \
		} > \"${STEAMAPPDIR1}/${STEAMAPP1}_update.txt\" \
		&& wget -qO- "${DLURL}/master/etc/cfg.tar.gz" | tar xvzf - -C \"${STEAMAPPDIR1}/${STEAMAPP1}\"" \
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
        SRCDS_HOSTNAME="New \"${STEAMAPP1}\" Server" \
        SRCDS_WORKSHOP_START_MAP=0 \
        SRCDS_HOST_WORKSHOP_COLLECTION=0 \
        SRCDS_WORKSHOP_AUTHKEY=""

USER steam

WORKDIR ${STEAMDIR}

CMD ["bash", "entry.sh"]

# Expose ports
EXPOSE 27015/tcp 27015/udp 27020/udp
