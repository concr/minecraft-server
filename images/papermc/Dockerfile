FROM azul/zulu-openjdk-alpine:21

WORKDIR /papermc/data

ENV UID_GID=1303
ENV USER_GROUP=mc

RUN addgroup -g ${UID_GID} ${USER_GROUP} && \
    adduser -D -G ${USER_GROUP} -u ${UID_GID} ${USER_GROUP} && \
    apk add --no-cache curl jq tini netcat-openbsd

# Java Edition
EXPOSE 25565/tcp

# Bedrock via Geyser
EXPOSE 19132/udp

COPY start.sh /papermc/start.sh

VOLUME ["/papermc/data"]

USER ${USER_GROUP}

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s CMD nc -z localhost 25565 || exit 1

#ENTRYPOINT ["tini", "--"]
CMD ["sh", "/papermc/start.sh"]
