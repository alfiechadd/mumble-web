
FROM node:14-buster

WORKDIR /home/node

RUN apt-get update && apt-get install -y --no-install-recommends \
    git python3 make g++ websockify tini \
    && rm -rf /var/lib/apt/lists/*

COPY --chown=node:node package.json package-lock.json ./

USER node

RUN npm install --legacy-peer-deps \
    && npm run build

USER root

EXPOSE 8080

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["sh", "-c", "websockify --web=/home/node/dist 8080 \"$MUMBLE_SERVER\""]
