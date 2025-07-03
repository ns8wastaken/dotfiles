#!/usr/bin/bash

# sudo rm -rf /opt/DiscordCanary && \
#     wget -O - "https://discordapp.com/api/download/canary?platform=linux&format=tar.gz" | \
#     sudo tar -C /opt/ -xzf


wget -O /tmp/discord_canary.tar.gz "https://discordapp.com/api/download/canary?platform=linux&format=tar.gz"
sudo rm -rf /opt/DiscordCanary
sudo tar -xzf /tmp/discord_canary.tar.gz -C /opt/
