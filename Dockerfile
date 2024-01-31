FROM alpine/git AS build

ARG TAG=-
RUN git clone https://github.com/triggerdotdev/jsonhero-web.git && \
    cd jsonhero-web && \
    git checkout ${TAG} && \
    rm -rf .git

FROM node:alpine

COPY --from=build /git/jsonhero-web /jsonhero-web
RUN cd jsonhero-web && \
    npm install && \
    echo "SESSION_SECRET=$(hexdump -v -n 32 -e '8/4 "%08x"' /dev/urandom)" >.env && \
    npm run build
EXPOSE 8787
CMD npm start
