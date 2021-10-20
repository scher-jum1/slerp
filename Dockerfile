FROM node:12.20-alpine

# update and install dependency
RUN apk update && apk upgrade
RUN apk add git

# create destination directory
RUN mkdir -p /var/www/html/frontend
WORKDIR /var/www/html/frontend

# copy package.json file to frontend directory.
COPY package*.json /var/www/html/frontend/
RUN npm install

# copy the rest of the frontend files to the frontend directory.
COPY ./ /var/www/html/frontend/

# build necessary, even if no static files are needed,
# since it builds the server as well
RUN npm run build

# expose 3000 on container
EXPOSE 3000

# set app serving to permissive / assigned
ENV NUXT_HOST=0.0.0.0
# set app port
ENV NUXT_PORT=3000

# Start command
CMD [ "npm", "run", "start" ]
