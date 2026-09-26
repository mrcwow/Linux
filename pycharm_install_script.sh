#!/bin/bash
set -Eeuo pipefail

sudo -v

time_script=$(date +%s)

# Install PyCharm Community
echo -e "Install PyCharm\n"

remove_old_pycharm() {
  # Removing old versions of PyCharm
  echo -e "\nRemoving old versions of PyCharm...\n"
  sudo rm -Rf /opt/pycharm*
  sudo rm -Rf /usr/bin/pycharm
  sudo rm -Rf /usr/share/applications/jetbrains-pycharm*
  sudo rm -Rf /home/$USER/.local/share/applications/jetbrains-pycharm*
}

# Getting PyCharm version from official site
echo -e "Getting PyCharm version from official site...\n"
PYCHARM_VERSION=$(curl -s "https://data.services.jetbrains.com/products/releases?code=PCP&latest=true" | jq -r '.["PCP"][0].version')
if [ -n "$PYCHARM_VERSION" ] && [ "$PYCHARM_VERSION" != "null" ]; then
  echo -e "PyCharm version is $PYCHARM_VERSION\n"
  echo -e "Downloading...\n"
  wget "https://download.jetbrains.com/python/pycharm-$PYCHARM_VERSION.tar.gz" -O PyCharm.tar.gz
  # Removing old versions of PyCharm
  remove_old_pycharm
  echo -e "\nInstalling...\n"
  sudo tar -xzf PyCharm.tar.gz -C /opt
  sudo ln -sf /opt/pycharm-$PYCHARM_VERSION/bin/pycharm /usr/bin/pycharm
  sudo rm -Rf PyCharm.tar.gz
  echo -e "PyCharm was installed!\n"
  echo -e "\nScript was executed in $(expr $(date +%s) - $time_script) seconds\n"

  if [ "${1:-}" = "boot" ]
  then
    echo -e "Initial launch of PyCharm\n"
    echo -e "In welcome settings or Tools you can create desktop entry"
    pycharm
  else
    echo -e "Type pycharm in terminal and in welcome settings or Tools you can create desktop entry"
  fi
else
  echo -e "Can't get PyCharm version from official site...\n"
  exit 1
fi
