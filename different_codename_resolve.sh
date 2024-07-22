#!/bin/bash

# Developed for Kubuntu, 
# can be applied to Ubuntu and Debian based distros (not tested) because of apt

# Developed for appimagelauncher, but can be changed for other ppa programs

time_script=$(date +%s)

# !!!
# Add apt repository, change for other program
sudo add-apt-repository ppa:appimagelauncher-team/stable -y

# change in /etc/apt/sources.list.d/appimagelauncher-team-ubuntu-stable-noble.sources where noble is current Kubuntu codename
# because appimagelauncher didn't update from 22.10: https://ppa.launchpadcontent.net/appimagelauncher-team/stable/ubuntu/dists/
# auto current kubuntu and appimagelauncher release detector

# Current distro codename
DISTRO_CODENAME=$(lsb_release -c -s)
echo -e "Distro codename: $DISTRO_CODENAME"

# !!!
# Current last codename in repository, change ppasitename for other program
ppasitename="https://ppa.launchpadcontent.net/appimagelauncher-team/stable/ubuntu/dists/" # Net source name
PROGRAM_LAST_CODENAME=$(curl -s $ppasitename | grep -o '<a href="[^"]*">' | tail -n 1 | sed 's/<a href="//' | sed 's/\/">//')
echo -e "Program last codename: $PROGRAM_LAST_CODENAME"

# !!!
# File with source, change filename for other program
filename="/etc/apt/sources.list.d/appimagelauncher-team-ubuntu-stable-$DISTRO_CODENAME.sources" # Local source name
temp_file=$(mktemp)
i=1
# !!!
# Line by line copying with changes in version. 
# This block must be viewed for each program separately and has been modified accordingly.
while read -r line; do
    if [ $i -eq 3 ]; then
        echo "Suites: $PROGRAM_LAST_CODENAME"
    else
        if [ $i -ge 6 ]; then # because one space before every line for public key
            echo " $line"
        else
            echo "$line"
        fi
    fi
    i=$((i+1))
done < "$filename" > "$temp_file"

# Source file is changing
sudo rm $filename
sudo mv $temp_file $filename

# Log
echo -e "Codename $filename was changed on $PROGRAM_LAST_CODENAME.\n"

# !!!
# Update source list and install program, change program for other program
sudo apt-get update
sudo apt-get install appimagelauncher -y

echo -e "\nScript was executed in $(expr $(date +%s) - $time_script) seconds"
