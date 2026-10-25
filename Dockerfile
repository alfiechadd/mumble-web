
FROM node:22-alpine

RUN npm install --global mumble-web@0.5.1 \
    && npm install --global http-server

EXPOSE 8080

CMD ["http-server", "/usr/local/lib/node_modules/mumble-web/dist", "-p", "8080", "-a", "0.0.0.0", "-c-1"]
