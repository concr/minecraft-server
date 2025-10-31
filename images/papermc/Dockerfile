FROM azul/zulu-openjdk-alpine:21

WORKDIR /papermc/data

RUN apk add --no-cache curl tini

# Java Edition
EXPOSE 25565/tcp

# Bedrock via Geyser
EXPOSE 19132/udp

COPY start.sh /papermc/start.sh

VOLUME ["/papermc/data"]

#ENTRYPOINT ["tini", "--"]
CMD ["sh", "/papermc/start.sh"]
