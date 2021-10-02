#Production deployment
#This file will be look by AWS Elasticbeanstalk docker plataform
#when travis ci deploy the app to AWS Elastic Bean Stalk

FROM node:alpine

WORKDIR '/usr/app'

COPY package*.json ./

RUN npm install

COPY ./ ./

# Build compact version for production
RUN npm run build

# For AWS Elasticbeanstalk exposing the app to port 80

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html