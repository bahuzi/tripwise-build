#!/usr/bin/env bash
dockerfile="Dockerfile"
dockerCompose="docker-compose.yml"
dockerignore=".dockerignore"
# install Node
brew upgrade node
# make sure to get the stable version of the node
sudo npm cache clean -f
sudo npm install -g n install n
sudo n stable
# instal vue3 globally 
npm install -g vue@next
# instal vue/cli globally
npm install -g @vue/cli

# create a vue project
vue create $1

# copy Dockerfile and docker-compose.yml
cp $dockerfile $1/$dockerfile
cp $dockerCompose $1/$dockerCompose
cp $dockerignore $1/$dockerignore

# cd $1 and install npm packages
cd $1 && vue add tailwind && npm install @headlessui/vue @heroicons/vue dayjs vuedraggable@next @vueform/multiselect animate.css --save && yarn add v-calendar@next

# set up docker compose
docker-compose up -d

# run server
npm run serve