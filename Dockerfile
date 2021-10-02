#Production deployment
#This file will be look by AWS Elasticbeanstalk docker plataform
#when travis ci deploy the app to AWS Elastic Bean Stalk
FROM node:alpine

# Will add all the files to this folder /usr/app
WORKDIR '/usr/app'

# With this line we wont run the RUN npm install
# it will avoid unecessary rebuilds
# We copy the dependencies from machine build context to container
COPY package*.json ./
  
# Install some depenendencies
RUN npm install

# Copy from your machine build context to inside container
COPY ./ ./

# Build compact version for production
RUN npm run build

# For AWS Elasticbeanstalk exposing the app to port 80

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html