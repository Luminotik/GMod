#1/bin/bash
bash "${STEAMCMDDIR}/steamcmd.sh" +login anonymous \
	+force_install_dir "${STEAMAPPDIR1}" \
	+app_update "${STEAMAPPID1}" \
	+force_install_dir "${STEAMAPPDIR2}" \
	+app_update "${STEAMAPPID2}" \
	+quit

# Change hostname on first launch (you can comment this out if it has done it's purpose)
sed -i -e 's/{{SERVER_HOSTNAME}}/'"${SRCDS_HOSTNAME}"'/g' "${STEAMAPPDIR1}/${STEAMAPP1}/cfg/server.cfg"

bash "${STEAMAPPDIR1}/srcds_run" -game "${STEAMAPP1}" -console -autoupdate \
	-steam_dir "${STEAMCMDDIR}" \
	-steamcmd_script "${STEAMAPPDIR1}/${STEAMAPP1}_update.txt" \
	-usercon \
	+fps_max "${SRCDS_FPSMAX}" \
	-tickrate "${SRCDS_TICKRATE}" \
	-port "${SRCDS_PORT}" \
	+tv_port "${SRCDS_TV_PORT}" \
	+clientport "${SRCDS_CLIENT_PORT}" \
	+maxplayers "${SRCDS_MAXPLAYERS}" \
	+map "${SRCDS_STARTMAP}" \
	+gamemode "${SRCDS_GAMEMODE}" \
	+sv_setsteamaccount "${SRCDS_TOKEN}" \
	+rcon_password "${SRCDS_RCONPW}" \
	+sv_password "${SRCDS_PW}" \
	+sv_region "${SRCDS_REGION}" \
	-ip "${SRCDS_IP}" \
	+host_workshop_collection "${SRCDS_HOST_WORKSHOP_COLLECTION}" \
	-authkey "${SRCDS_WORKSHOP_AUTHKEY}"
