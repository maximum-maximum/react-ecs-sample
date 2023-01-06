FROM node:14-alpine as builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY ./ ./

EXPOSE 80

RUN npm run build

FROM nginx:1.15-alpine

COPY --from=builder /app/build /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]