FROM node:lts
WORKDIR /app
COPY package*.json ./
#RUN npm install --only=prod
RUN npm install
COPY . .
#RUN npm run compile
#CMD ["npm", "start"]