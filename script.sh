#!/bin/bash
# steamcmd Base Installation Script
#
# Server Files: /mnt/server

echo "
$(tput setaf 4)  ____________________________       ______________
$(tput setaf 4) /   _____/\_   ___ \______   \ /\  /   _____/|    |
$(tput setaf 4) \_____  \ /    \  \/|     ___/ \/  \_____  \ |    |
$(tput setaf 4) /        ||     \___|    |     /\  /        \|    |___
$(tput setaf 4)/_________/ \________/____|     \/ /_________/|________|
$(tput setaf 1) ___                 __          __   __
$(tput setaf 1)|   | ____   _______/  |______  |  | |  |   ___________
$(tput setaf 1)|   |/    \ /  ___/\   __\__  \ |  | |  | _/ __ \_  __ |
$(tput setaf 1)|   |   |  |\___ \  |  |  / __ \|  |_|  |_\  ___/|  | \/
$(tput setaf 1)|___|___|__/______| |__| (______|____|____/\___  |__|
$(tput setaf 0)
"

echo "
$(tput setaf 2)This installer was created by $(tput setaf 1)Parkeymon$(tput setaf 2) and maintained by $(tput setaf 6)EsserGaming$(tput setaf 2).$(tput setaf 0)
"

# Egg version checking, do not touch!
currentVersion="2.5.9"
latestVersion=$(curl --silent "https://api.github.com/repos/EsserGaming/EXILED-SCP-SL-egg/releases/latest" | jq -r .tag_name)

if [ "${currentVersion}" == "${latestVersion}" ]; then
  echo "$(tput setaf 2)Installer is up to date"
else

  echo "
  $(tput setaf 1)THE INSTALLER IS NOT UP TO DATE!

    Current Version: $(tput setaf 1)${currentVersion}
    Latest: $(tput setaf 2)${latestVersion}

  $(tput setaf 3)Please update to the latest version found here: https://github.com/EsserGaming/EXILED-SCP-SL-egg/releases/latest
 $(tput setaf 4)Installation will start in 3 seconds...

  "
  sleep 3
fi

# Download SteamCMD and Install
cd /tmp || {
  echo "$(tput setaf 1) FAILED TO MOUNT TO /TMP"
  exit
}
mkdir -p /mnt/server/steamcmd
curl -sSL -o steamcmd.tar.gz https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
tar -xzvf steamcmd.tar.gz -C /mnt/server/steamcmd
cd /mnt/server/steamcmd || {
  echo "$(tput setaf 1) FAILED TO MOUNT TO /mnt/server/steamcmd"
  exit
}

# SteamCMD fails otherwise for some reason, even running as root.
# This is changed at the end of the install process anyways.
chown -R root:root /mnt
export HOME=/mnt/server

if [ "${BETA_TAG}" == "none" ]; then
  ./steamcmd.sh +force_install_dir /mnt/server +login anonymous +app_update "${SRCDS_APPID}" validate +quit
else
  ./steamcmd.sh +force_install_dir /mnt/server +login anonymous +app_update "${SRCDS_APPID}" -beta ${BETA_TAG} validate +quit
fi

# Install SL with SteamCMD
cd /mnt/server || {
  echo "$(tput setaf 1) FAILED TO MOUNT TO /mnt/server"
  exit
}

#Start egg configuration
mkdir -p .egg

echo "$(tput setaf 4)Configuring start.sh$(tput setaf 0)"
rm ./.egg/start.sh
touch "./.egg/start.sh"
chmod +x ./.egg/start.sh

if [ "${INSTALL_SCPDBOT}" == "true" ]; then
  echo "#!/bin/bash
    ./.egg/SCPDBot/SCPDiscordBot_Linux --config ./.egg/SCPDBot/config.yml &
    ./LocalAdmin \${SERVER_PORT}" >>./.egg/start.sh
  echo "$(tput setaf 4)Finished configuring start.sh for LocalAdmin and SCPDiscord.$(tput setaf 0)"

else
  echo "#!/bin/bash
    ./LocalAdmin \${SERVER_PORT}" >>./.egg/start.sh
  echo "$(tput setaf 4)Finished configuring start.sh for LocalAdmin.$(tput setaf 0)"

fi

#Install SCPDiscord Bot
if [ "${INSTALL_SCPDBOT}" == "true" ]; then
  mkdir -p /mnt/server/.egg/SCPDBot

  echo "Removing old SCPDiscord Bot"
  rm /mnt/server/.egg/SCPDBot/SCPDiscordBot_Linux

  echo "$(tput setaf 4)Installing latest SCP Discord Bot."
  wget -q https://github.com/KarlOfDuty/SCPDiscord/releases/latest/download/SCPDiscordBot_Linux -P /mnt/server/.egg/SCPDBot

  chmod +x /mnt/server/.egg/SCPDBot/SCPDiscordBot_Linux
else
  echo "Skipping SCPDiscord Bot install."
fi

 #Install SCPDiscord Plugin
 if [ "${INSTALL_SCPDPLUGIN}" == "true" ]; then
  echo "Installing SCPDiscord Plugin"
  echo "Removing old SCPDiscord Plugin"
  rm '/mnt/server/.config/SCP Secret Laboratory/PluginAPI/plugins/global/SCPDiscord.dll'

  echo "$(tput setaf 5)Grabbing plugin and dependencies."
  wget -q https://github.com/KarlOfDuty/SCPDiscord/releases/latest/download/dependencies.zip -P '/mnt/server/.config/SCP Secret Laboratory/PluginAPI/plugins/global'
  wget -q https://github.com/KarlOfDuty/SCPDiscord/releases/latest/download/SCPDiscord.dll -P '/mnt/server/.config/SCP Secret Laboratory/PluginAPI/plugins/global'


  echo "Extracting dependencies..."
  unzip -oq '/mnt/server/.config/SCP Secret Laboratory/PluginAPI/plugins/global/dependencies.zip' -d '/mnt/server/.config/SCP Secret Laboratory/PluginAPI/plugins/global/'
  rm '/mnt/server/.config/SCP Secret Laboratory/PluginAPI/plugins/global/dependencies.zip'
else
  echo "Skipping SCPDiscord Plugin install."
fi

if [ "${INSTALL_EXILED}" == "true" ]; then
  echo "$(tput setaf 4)Downloading $(tput setaf 1)EXILED$(tput setaf 0).."
  mkdir -p .config/
  echo "$(tput setaf 4)Downloading latest $(tput setaf 1)EXILED$(tput setaf 4) Installer"
  rm Exiled.Installer-Linux
  wget -q https://github.com/ExSLMod-Team/EXILED/releases/latest/download/Exiled.Installer-Linux
  chmod +x ./Exiled.Installer-Linux

  if [ "${EXILED_PRE}" == "true" ]; then
    echo "$(tput setaf 4)Installing $(tput setaf 1)EXILED (pre-release)..."
    ./Exiled.Installer-Linux --pre-releases

  elif [ "${EXILED_PRE}" == "false" ]; then
    echo "$(tput setaf 4)Installing $(tput setaf 1)EXILED$(tput setaf 0)..."
    ./Exiled.Installer-Linux

  else
    echo "$(tput setaf 4)Installing $(tput setaf 1)EXILED$(tput setaf 0) version: ${EXILED_PRE} .."
    ./Exiled.Installer-Linux --target-version "${EXILED_PRE}"

  fi
else
  echo "Skipping Exiled installation."
fi


# Cleanup :p
echo "$(tput setaf 2)Cleaning up..$(tput sgr 0)"
rm /mnt/server/core
rm /mnt/server/Exiled.Installer-Linux
rm -rf /mnt/server/?
rm -rf /mnt/server/.local
rm /mnt/server/config-gameplay.txt

echo "$(tput setaf 2)Installation Complete!$(tput sgr 0)"