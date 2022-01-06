#Esta es la primera fase de Construccion
FROM node:16-alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install

#Necesario para solucionar un error de permisos
RUN mkdir node_modules/.cache && chmod -R 777 node_modules/.cache

COPY . .

#Genero el build de la app , quedara en la carpeta /app/build
RUN npm run build

#Inicia la fase 2

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

