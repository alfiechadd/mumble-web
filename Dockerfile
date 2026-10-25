
FROM node:14-bullseye

WORKDIR /home/node

RUN apt-get update && apt-get install -y --no-install-recommends \
    git openssh-client python3 make g++ websockify tini ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN git config --global url."https://github.com/".insteadOf "ssh://git@github.com/" \
    && git config --global url."https://github.com/".insteadOf "git@github.com:"

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npm run build

EXPOSE 8080

ENTRYPOINT ["tini", "--"]
CMD ["sh", "-c", "exec websockify --web=/home/node/dist 0.0.0.0:8080 ${MUMBLE_SERVER}"]
