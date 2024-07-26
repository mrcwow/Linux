# Install PyCharm Community
# Removing old versions of PyCharm
sudo rm -Rf /opt/pycharm*
sudo rm -Rf /usr/bin/pycharm
sudo rm -Rf /usr/share/applications/jetbrains-pycharm*
sudo rm -Rf /home/$USER/.local/share/applications/jetbrains-pycharm*
# Getting PyCharm version from official site
PYCHARM_VERSION=$(curl -s https://www.jetbrains.com/ru-ru/pycharm/whatsnew/ | grep -o -E 'PyCharm [0-9.]+' | head -n 1 | cut -d' ' -f2)
wget "https://download.jetbrains.com/python/pycharm-community-$PYCHARM_VERSION.tar.gz" -O PyCharm.tar.gz
sudo tar -xzf PyCharm.tar.gz -C /opt
sudo ln -sf /opt/pycharm-community-$PYCHARM_VERSION/bin/pycharm.sh /usr/bin/pycharm
sudo rm -Rf PyCharm.tar.gz
# type pycharm in terminal and in welcome settings or tools you can create desktop entry
