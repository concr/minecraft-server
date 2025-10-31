#!/usr/bin/env sh

###
### server
###

DATA="/papermc/data"

# get current versions here: https://papermc.io/downloads/paper

if [[ ! -f "${DATA}/papermc.jar" ]]; then
    curl -s \
    -f https://fill-data.papermc.io/v1/objects/f6d8d80d25a687cc52a02a1d04cb25f167bb3a8a828271a263be2f44ada912cc/paper-1.21.10-91.jar \
    -o "${DATA}/papermc.jar"
fi

###
### eula
###

if [[ ! -f "eula.txt" ]]; then
    echo "eula=true" > "${DATA}/eula.txt"
fi

###
### plugins
###

PLUGINS="${DATA}/plugins"
mkdir -p "${PLUGINS}"

# get current versions here: https://geysermc.org/download?project=geyser

if [[ ! -f "${PLUGINS}/floGeyser-Spigot.jar" ]]; then
    curl -s \
    -f https://download.geysermc.org/v2/projects/geyser/versions/2.9.0/builds/975/downloads/spigot \
    -o "${PLUGINS}/Geyser-Spigot.jar"
fi

# get current versions here: https://geysermc.org/download?project=floodgate

if [[ ! -f "${DATA}/plugins/floodgate.jar" ]]; then
    curl -s \
    -f https://download.geysermc.org/v2/projects/floodgate/versions/2.2.5/builds/121/downloads/spigot \
    -o "${PLUGINS}/floodgate.jar"
fi

###
### start server
###

java -Xms4G -Xmx4G -jar "${DATA}/papermc.jar" --nogui
