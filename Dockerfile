FROM node:current-alpine3.12 as build-deps
WORKDIR /usr/src/app
COPY .env package.json yarn.lock ./
RUN yarn
COPY src/ src/
COPY public/ public/
RUN yarn build

FROM nginx:1.12-alpine
COPY --from=build-deps /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
