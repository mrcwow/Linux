#!/bin/bash
set -Eeuo pipefail

sudo -v

time_script=$(date +%s)

# Install Discord
echo -e "Install Discord\n"

remove_old_discord() {
  # Removing old versions of Discord (for now no cleaning for versions in .config)
  echo -e "\nRemoving old versions of Discord (for now no cleaning for versions in .config)...\n"
  sudo rm -Rf /opt/discord*
  sudo rm -Rf /usr/bin/discord
  sudo rm -Rf /usr/share/applications/*discord*
  sudo rm -Rf /home/$USER/.local/share/applications/*discord*
  sudo rm -Rf /usr/share/icons/hicolor/256x256/apps/*discord*
}

run_discord_and_close() {
  local discord_pid
  local process_exe=""
  local process_name=""
  local timeout=300

  echo -e "\nRunning Discord bootstrap for downloading and installing...\n"

  # background process for continuation of script
  /usr/bin/discord &
  discord_pid=$!

  # logic: waiting changing process on main - Discord
  while (( timeout > 0 ))
  do
    if ! kill -0 "$discord_pid" 2>/dev/null
    then
      wait "$discord_pid" || true
      echo -e "\nDiscord bootstrap failed or was closed\n" >&2
      return 1
    fi

    if [[ -e "/proc/$discord_pid/exe" ]]
    then
      process_exe="$(readlink -f "/proc/$discord_pid/exe" 2>/dev/null || true)"
      process_name="$(basename "$process_exe")"

      if [[ "$process_name" = "Discord" ]]
      then
        break
      fi
    fi

    sleep 1
    timeout=$((timeout - 1))
  done

  if [[ "$process_name" != "Discord" ]]
  then
    echo -e "\nTimeout while waiting for Discord bootstrap\n" >&2
    kill -TERM "$discord_pid" 2>/dev/null || true
    wait "$discord_pid" || true
    return 1
  fi

  echo -e "\nBootstrap complete in script space\n"
  # Seems there is no need in pause after Bootstrap complete before closing discord
  # sleep 1
  echo -e "\nClosing Discord..."
  kill -TERM "$discord_pid" 2>/dev/null || true
  wait "$discord_pid" || true

  echo -e "\nDiscord was closed\n"
}


echo -e "Downloading...\n"
wget "https://discord.com/api/download?platform=linux&format=tar.gz" -O Discord.tar.gz
wget https://raw.githubusercontent.com/mrcwow/Linux/main/assets/discord.desktop

# Removing old versions of Discord (for now no cleaning for versions in .config)
remove_old_discord

echo -e "\nInstalling...\n"
sudo tar -xzf Discord.tar.gz -C /opt

sudo mv /opt/Discord /opt/discord
# postinst.sh is not required but one step was integrated in script
sudo rm -f /opt/discord/postinst.sh
sudo rm /opt/discord/discord.desktop
sudo mv discord.desktop /opt/discord/discord.desktop
sudo cp /opt/discord/discord.desktop /usr/share/applications/discord.desktop
sudo cp /opt/discord/discord.png /usr/share/icons/hicolor/256x256/apps/discord.png

sudo chmod +x \
  /opt/discord/discord \
  /opt/discord/updater_bootstrap
sudo ln -sfn /opt/discord/discord /usr/bin/discord

sudo rm -Rf Discord.tar.gz

run_discord_and_close

# postinstall step based on official postinst.sh in archive
if command -v update-desktop-database >/dev/null 2>&1; then
    update-desktop-database -q /usr/share/applications >/dev/null 2>&1 || true
fi

echo -e "\nDiscord was installed!\n"
echo -e "\nScript was executed in $(expr $(date +%s) - $time_script) seconds\n"

if [ "${1:-}" = "boot" ]
then
  echo -e "Initial launch of Discord\n"
  echo -e "Desktop entry was created\n"
  discord
else
  echo -e "Type discord to launch discord. Desktop entry was created"
fi
