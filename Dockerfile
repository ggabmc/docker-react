# Docker for Production

# This file will be look by AWS Elasticbeanstalk docker plataform

# when travis ci deploy the app to AWS Elastic Bean Stalk

FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

#Build compact version for production
RUN npm run build

FROM nginx

#For AWS Elasticbeanstalk exposing the app to port 80
EXPOSE 80 

COPY --from=builder /app/build /usr/share/nginx/html