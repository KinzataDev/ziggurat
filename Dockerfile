FROM nginx:mainline-alpine AS base

FROM base AS buildstage

RUN apk add --update nodejs nodejs-npm

WORKDIR /tmp
COPY ./package.json .
COPY ./package-lock.json .
RUN npm install

COPY ./config/ ./config/
COPY ./build/ ./build/
COPY ./src ./src/
COPY ./static ./static/
COPY ./index.html .

RUN npm run-script build

FROM base AS final

WORKDIR /tmp
COPY --from=buildstage /tmp/dist ../www
COPY ./files/ziggurat.nginx /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]
