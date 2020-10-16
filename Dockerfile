FROM node:12-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm i
COPY ./ ./
RUN npm run build --prod

FROM nginx:1.19.2-alpine as prod-stage
COPY --from=build /app/dist/docker-app /usr/share/nginx/html
EXPOSE 4200
CMD ["nginx", "-g", "daemon off;"]
RUN echo "LISTENING ON PORT 8888"
