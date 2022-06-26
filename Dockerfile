FROM alpine:3.14 as builder
RUN apk add --update npm
WORKDIR '/usr/app'
COPY ./package.json .
RUN npm install
COPY ./public ./public
COPY ./src ./src
RUN npm run build

FROM nginx:1.23.0-alpine
EXPOSE 80
COPY --from=builder /usr/app/build /usr/share/nginx/html
