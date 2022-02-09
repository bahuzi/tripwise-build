# **Objective**: Build Vue3 Docker Env

After pull the repo, cd in and run build

```sh
. build.sh tripwise
```

In order to make sure the Vue3 docker Env is correctly built, there are 3 major steps: vue3 local works, create a clean dockerfile and create a clean docker-compose.yml

## Step 1: Build local Vue3 Env

Here we want to use Vue3, Vue cli, TypeScript, Tailwindcss, HeadlessUI and dayjs vuedraggable and heroicons

### Install Node and Vue packages

* Install latest nodejs ([download](https://nodejs.org/en/)) or brew upgrade node
  * Current v17.4.0 (with npm 8.3.1)
  * **Important**: At this point npm run serve doesn't work with v17. Therefore, changed it back using sudo n stable which got the node back to v17.
* npm install -g vue@next
  * Install globally
* npm install -g @vue/cli
  * Install globally, version CLI v4.5.15

### Build Vue project with vue/cli

* vue create tripwise
  * Make sure you are in the right directory (~/Code)
  * Preset: Manually select features
    * Babel (JavaScript compiler)
    * TypeScript
    * Lint / formatter
    * Vue version 3.x
    * Use class-style syntax
    * Use Babel alongside TypeScript
    * ESLint + Prettier
    * Lint on save
    * In dedicated config files
    * Save this as a preset for future projects

Okay! While the script is running. I will try to setup all the dependencies Vue3, TypeScript, Babel, Lint/formatter needed in the vue-app you just created. After it's done, you can cd it the created project dir and run npm run serve which will boot up the app on your local host.

* Add needed packages for the tripwise project.
  * cd into vue-app(tripwise)
  * vue add tailwind
    * Just choose mimal for now not sure what full entails
  * npm install @headlessui/vue @heroicons/vue dayjs vuedraggable@next

At this point, all needed setups are done to run the tripwise env locally.

* Test if the Env works
  * npm run serve
    * In my first test it doesn't work because vue/cli isn't compatible with node v17 as of today (2/8/22). Therefore, changed it back using sudo n stable which switched the node back to v17.
  * Getting "No Issues Found" and working localhost

Alright, now vue3 app is running on your local. But most importantly the packages.json file is generated as well. We need to use it to make a Dockerfile. 
After this it's better to build a shell script to incorporate everything into one place. (build.sh)

## Step 2: Create a clean Dockerfile

Try to use a clean image that offers the bear minimum to run the docker successfully

### Create a .dockerignore file

To use a file in the build context, the Dockerfile refers to the file specified in an instruction, for example, a COPY instruction. To increase the build's performance, exclude files and directories by adding a .dockerignore file to the context directory. To improve the context load time create a .dockerignore file and add node_modules directory in it.

```Dockerfile
FROM node:16-alpine3.14

ENV NODE_ENV=development

COPY ["package.json", "package-lock.json*", "./"]

WORKDIR /code

RUN npm install

COPY . .

CMD ["npm", "run", "serve"]
```

### Create Dockerfile and pull the right image as base

#### FROM node:16-alpine3.14

Change: node:current-alpine3.14 → node:16-alpine3.14

* The cleanest way to grab nodejs docker image has to be bundled with linux distribution. I thought by using tag node:latest would only include nodejs.
* **However**, by checking github repo ([link](https://github.com/nodejs/docker-node/blob/5cafbd5b0462317bd024bb281af49585013473cd/17/bullseye/Dockerfile)), it inherits from bullseye (Debian releases). Therefore I chose current-alpine3.14 the latest version for this build.
* Had to use 16-alphine3.14 at this point since the current version 17 has an unfixed error when run "npm run serve"

#### ENV NODE_ENV=development

* The NODE_ENV environment variable specifies the environment in which an application is running (usually, development or production).
* One of the simplest things you can do to improve performance is to set NODE_ENV to production.
* Will switch to production in later development process

#### COPY ["package.json", "package-lock.json*", "./"]

* Putting COPY above WORKDIR for now. Reason: [Lessons Learned](https://docs.google.com/document/d/1kMbyK7Z4vmvi_iOEhNT2tvLBDF626rbf22jXFX28K0s/edit)
* Usually the very first thing you do once you've downloaded a project written in Node.js is to install npm packages. This ensures that your application has all its dependencies installed into the node_modules directory where the Node runtime will be able to find them.

#### WORKDIR /code

* To make things easier when running the rest of our commands, let's create a working directory. This instructs Docker to use this path as the default location for all subsequent commands. This way we do not have to type out full file paths but can use relative paths based on the working directory. (Note: This is the directory created inside of the build image)

#### RUN npm install

* **Important:** if the packages used are in devDependencies in package.json file, running production won't pick up those packages, e.g. vite: command not found error
* Note that, rather than copying the entire working directory, we are only copying the package.json file. This allows us to take advantage of cached Docker layers. Once we have our files inside the image, we can use the RUN command to execute the command npm install. This works exactly the same as if we were running npm install locally on our machine, but this time these Node modules will be installed into the node_modules directory inside our image.

#### COPY

* At this point, we have an image that is based on node version 16-alphine3.14 and we have installed our dependencies. The next thing we need to do is to add our source code into the image. We'll use the COPY command just like we did with our package.json files above.

#### CMD ["npm", "run", "serve"]

* Now, all we have to do is to tell Docker what command we want to run when our image is run inside of a container. We do this with the CMD command.

## Step3: create a simple docker-compose.yml file

Creating docker compose is simple. Since vue/cli has the web server built in, we don't need to add a web server yet. There is only one service called app which is the only app container for vue3. Note: Since Dockerfile and docker-compose.yml can provide the same instruction with different statements. Make sure actions are not redeclared, e.g. Dockerfile WORKDIR = docker-compose working_dir.

```yml
version: "3.9"
services:
 web:
   build:
     context: .
   image: tripwise-image
   container_name: tripwise-container
   volumes:
     - ./:/code
   ports:
     - "8080:8080"
```

### Build image from Dockerfile

* . means it expected the Dockerfile in the current dir with docker-compose.yml

### Volumes: ./:/code

* The new volumes key mounts the project directory (current directory) on the host to /code inside the container, allowing us to modify the code on the fly, without having to rebuild the image. [Use bind mounts | Docker Documentation](https://docs.docker.com/storage/bind-mounts/)

### Ports: 8080[outside]:8080[inside]

* Expose port 8080 outside the container to port 8080 inside the container, vice versa

## References

* [Build your Node image | Docker Documentation](https://docs.docker.com/language/nodejs/build-images/)
* [Quickstart: Compose and Django | Docker Documentation](https://docs.docker.com/samples/django/)
* [VueJS](https://github.com/docker/awesome-compose/tree/master/vuejs)
* [Installation | Vue.js](https://v3.vuejs.org/guide/installation.html#npm)
* [Node - Official Image | Docker Hub](https://hub.docker.com/_/node)