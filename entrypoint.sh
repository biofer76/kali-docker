#!/bin/bash
echo "+------------------------------------------+"
echo "|     Kali Docker | MIT License 2020       |"
echo "|  https://github.com/devxops/kali-docker  |"
echo "+------------------------------------------+"

# Nmap
export NMAP_FOLDER=/opt/nmap
if [ ! -d "$NMAP_FOLDER" ]; then mkdir -p $NMAP_FOLDER; fi

# Dnsrecon
export DNSRECON_FOLDER=/opt/dnsrecon
if [ ! -d "$DNSRECON_FOLDER" ]; then mkdir -p $DNSRECON_FOLDER; fi

# theHarvester
export THEHARVESTER_FOLDER=/opt/theharvester
if [ ! -d "$THEHARVESTER_FOLDER" ]; then
  mkdir -p $THEHARVESTER_FOLDER;
  cp /etc/theHarvester/api-keys.yaml $THEHARVESTER_FOLDER/api-keys.yaml
  rm /etc/theHarvester/api-keys.yaml
  ln -s $THEHARVESTER_FOLDER/api-keys.yaml /etc/theHarvester/api-keys.yaml
fi

set -xe
# Execute subcommand, wrapping
exec "$@"