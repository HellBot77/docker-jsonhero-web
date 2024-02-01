FROM alpine/git AS base

ARG TAG=latest
RUN git clone https://github.com/triggerdotdev/jsonhero-web.git && \
    cd jsonhero-web && \
    ([[ "$TAG" = "latest" ]] || git checkout ${TAG}) && \
    rm -rf .git

FROM node:alpine

WORKDIR /jsonhero-web
COPY --from=base /git/jsonhero-web .
RUN npm install && \
    echo "SESSION_SECRET=$(hexdump -v -n 32 -e '8/4 "%08x"' /dev/urandom)" > .env && \
    npm run build
EXPOSE 8787
CMD npm start
