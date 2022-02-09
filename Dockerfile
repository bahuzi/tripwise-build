FROM node:16-alpine3.14

ENV NODE_ENV=development

COPY ["package.json", "package-lock.json*", "./"]

WORKDIR /code

RUN npm install

COPY . .

CMD ["npm", "run", "serve"]