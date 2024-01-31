FROM node

ARG TAG=-
RUN git clone https://github.com/triggerdotdev/jsonhero-web.git && \
    cd jsonhero-web && \
    git checkout ${TAG} && \
    rm -rf .git && \
    npm install && \
    echo "SESSION_SECRET=$(openssl rand -hex 32)" > .env && \
    npm run build
EXPOSE 8787
CMD npm start
