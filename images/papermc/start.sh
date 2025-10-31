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

if ! grep -qF 'eula=true' "${DATA}/eula.txt" 2> /dev/null; then
  printf '%s\n' 'eula=true' > "${DATA}/eula.txt" && \
  echo "### ${DATA}/eula.txt created."
else
  echo "### ${DATA}/eula.txt already there."
fi

###
### plugins
###

PLUGINS="${DATA}/plugins"
mkdir -p "${PLUGINS}"

# get current versions here: https://hangar.papermc.io/GeyserMC/Geyser
#                            https://geysermc.org/download?project=geyser
get_jar \
    https://download.geysermc.org/v2/projects/geyser/versions/2.9.0/builds/975/downloads/spigot \
    "${PLUGINS}/Geyser-Spigot.jar"

# get current versions here: https://hangar.papermc.io/GeyserMC/Floodgate
#                            https://geysermc.org/download?project=floodgate
get_jar \
    https://download.geysermc.org/v2/projects/floodgate/versions/2.2.5/builds/121/downloads/spigot \
    "${PLUGINS}/floodgate.jar"

# get current versions here: https://hangar.papermc.io/Black1_TV/Passky
get_jar \
    https://hangarcdn.papermc.io/plugins/Black1_TV/Passky/versions/3.3.0/PAPER/Passky-3.3.0.jar \
    "${PLUGINS}/Passky.jar"

###
### start server
###

java -Xms4G -Xmx4G -jar "${DATA}/papermc.jar" --nogui
