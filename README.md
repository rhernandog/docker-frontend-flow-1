# Docker Front End Flow One

### Description
First sample of a real development/production flow using Docker, Github, Travis CI and AWS to deploy a simple web app to AWS using a Docker image.

### Important Notes
- Because we have a development and production environments we create a new file called `Dockerfile.dev` that creates the image for development only. In order to build the image with this file, we must pass a flag to the regular build command `-f` in order to specify the **Dockerfile** used to build the image: `docker build -f Dockerfile.dev .`
- Since the application is running from the Docker container, which is a file system snapshot, it already contains the folders and files from the `node_modules` folder, so there is no need to keep that folder in the local machine.
-  In order to allow the hot reload feature that webpack dev server has, Docker uses **[volumes](https://docs.docker.com/storage/volumes/)** in order to bind the data in the source code that will be updated continously in development to the running container, without constantly re-building the image. For that we use the `-v` flag in the `docker run` command: `docker run -p 3000:3000 -v /usr/app/node_modules -v ${pwd}:/usr/app <image_id>`. The first `-v` flag indicates that the `node_modules` folder is not bind to any folder in the local machine. The second `-v` flag indicates that the `/usr/app` folder in the running container should be mapped to the root folder of the project. `-v <local_machine_folder>:<running_container_folder>`. The `${pwd}` stands for **print working folder**, and returns the current folder where the command is executed. In Unix and Mac the command uses parenthesis instead of curly braces: `$(pwd)`.
- In order to run the tests, we need to override the default start command passed to the docker image, for that we write the command after the image ID: `docker run <image_id> npm run test`.
- We can create a docker compose file in order to avoid writing those long commands in the command line. When the docker compose file is created with the volumes binding between the local environment and the running container, and we run the app we can run the test suite by opening another terminal and executing with the `-it` flag in order to run a command in the running container using the **standard input stream** in order to run the test command in that container: `docker exec -it <container_id> npm run test`.

### Author
- Rodrigo Hernando G.
- [@websnap](https://twitter.com/websnapcl/)

------

##### NEXT LECTURE 20
