#!/usr/bin/env sh

###
### functions
###

get_jar () {
    URL=$1
    FILE=$2

    if [[ ! -f "${FILE}" ]]; then
        curl -s -f "${URL}" -o "${FILE}" && \
        echo "### ${FILE} download done."
    else
        echo "### ${FILE} already downloaded."
    fi
}

###
### server
###

DATA="/papermc/data"
mkdir -p "${DATA}"

# get current versions here: https://papermc.io/downloads/paper
get_jar \
    https://fill-data.papermc.io/v1/objects/f6d8d80d25a687cc52a02a1d04cb25f167bb3a8a828271a263be2f44ada912cc/paper-1.21.10-91.jar \
    "${DATA}/papermc.jar"

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
get_jar \
    https://download.geysermc.org/v2/projects/geyser/versions/2.9.0/builds/975/downloads/spigot \
    "${PLUGINS}/Geyser-Spigot.jar"

# get current versions here: https://geysermc.org/download?project=floodgate
get_jar \
    https://download.geysermc.org/v2/projects/floodgate/versions/2.2.5/builds/121/downloads/spigot \
    "${PLUGINS}/floodgate.jar"

# get current versions here: https://hangar.papermc.io/firewolf8385/PlayerPasswords
get_jar \
    https://hangarcdn.papermc.io/plugins/firewolf8385/PlayerPasswords/versions/2.0/PAPER/PlayerPasswords%20v2.0.jar \
    "${PLUGINS}/PlayerPasswords.jar"

###
### start server
###

java -Xms4G -Xmx4G -jar "${DATA}/papermc.jar" --nogui
