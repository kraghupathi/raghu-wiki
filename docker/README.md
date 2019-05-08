# What is Docker?
Docker is a tool that allows developers, sys-admins etc. to easily deploy their applications in a containers to run on the host operating system i.e. Linux. The key benefit of Docker is that it allows users to package an application with all of its dependencies into a standardized unit for software development. Unlike virtual machines, containers do not have the high overhead and hence enable more efficient usage of the underlying system and resources.

# What are containers?

A container is a standard unit of software that packages up code and all its dependencies so the application runs quickly and reliably from one computing environment to another.

# Why use containers?

Containers can be run in lightweight virtual machines to increase isolation and therefore security, and because hardware virtualization makes it easier to manage the hardware infrastructure (networks, servers and storage) that are needed to support containers.

## Installation of Docker

Update your existing list of packages
```
$ sudo apt-get update
```
Install a few prerequisite packages which let apt use packages over HTTPS:
```
$ sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
```
Add the GPG key for the official Docker repository to your system:
```
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```

Add the Docker repository to APT sources:
```
$ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
```
Update the package database with the Docker packages from the newly added repo:
```
$ sudo apt-get update
```
Install Docker:
```
$ sudo apt-get install -y docker-ce
```
Docker should now be installed, the daemon started, and the process enabled to start on boot. Check that it's running:
```
$ sudo systemctl status docker
```

## Setting up your computer

Once you are done installing Docker, test your Docker installation by running the following:
```
$ $ docker run hello-world
Hello from Docker.
This message shows that your installation appears to be working correctly.
...
```
### Playing with Ubuntu

In this section, we are going to run a Ubuntu container on our system.

To get started, let's run the following in our terminal:
```
$ docker pull ubuntu
```
The pull command fetches the ubuntu image from the Docker registry and saves it to our system. You can use the docker images command to see a list of all images on your system.
```
$ docker images
```
#### Docker Run

Run a Docker container based on this image.
```
$ docker run ubuntu
```
When you call run, the Docker client finds the image (ubuntu in this case), loads up the container and then runs a command in that container. When we run docker run ubuntu, we didn't provide a command, so the container booted up, ran an empty command and then exited.
```
$ docker run ubuntu echo "hello from ubuntu"
hello from ubuntu
```
 To see the docker ps command. The docker ps command shows you all containers that are currently running.
```
$ docker ps
```
To see the docker ps -a command. The docker ps -a command shows you all the running and stopped containers
```
$ docker ps -a
```


# Terminology

**- Images:** A Docker image is a file, comprised of multiple layers, used to execute code in a Docker container. An image is essentially built from the instructions for a complete and executable version of an application, which relies on the host OS kernel. When the Docker user runs an image, it becomes one or multiple instances of that container.

***- Containers:*** Container is a standardized unit which can be created on the fly to deploy a particular application or environment. It could be an Ubuntu container, CentOs container, etc. Also, it could be an application oriented container like MySQL container or a Tomcat-Ubuntu container etc.

***- Docker Daemon:*** The background service running on the host that manages building, running and distributing Docker containers. The daemon is the process that runs in the operating system to which clients talk to.

***- Docker Client:*** The command line tool that allows the user to interact with the daemon. More generally, there can be other forms of clients too - such as Kitematic which provide a GUI to the users.

***- Docker Hub:*** A registry of Docker images. You can think of the registry as a directory of all available Docker images. If required, one can host their own Docker registries and can use them for pulling images.

# Dockerfile

A Dockerfile is a simple text-file that contains a list of commands that the Docker client calls while creating an image. It's a simple way to automate the image creation process. The best part is that the commands you write in a Dockerfile are almost identical to their equivalent Linux commands.

Let us first start with the the overall flow, which goes something like this:

1. You create a Dockerfile with the required instructions.
2. Then you will use the docker build command to create a Docker image based on the Dockerfile that you created in step 1.

If we wanted to build new docker image we can leverage the existing Operating System Docker image as a starting point for the new build. This is called the base image. From this base image the Docker engine runs the commands in the Dockerfile creating new layers, stacking them on top of the layers created for the Operating system image.

***Layer 0:*** FROM Scratch
***Layer 1:*** ADD Operating System Binaries
***Layer 2:*** RUN Commands to set up OS
***Layer 3:*** Command instructions, when the Docker container starts up.

Example:
```
FROM python:3

RUN apt-get update && \
    pip install pystrich

WORKDIR /root

ADD test.py /root

CMD [ "python", "./test.py" ]
```

***FROM:*** Tells Docker which image you base your image on (in the example, Python 3).
***RUN:*** Tells Docker which additional commands to execute.
***CMD:***  Tells Docker to execute the command when the image loads.

## Build an image from this Dockerfile. Run:
Build an image for python3
```
$ docker build -t python3-test .
```
Run your Image
```
$ docker run python3-test
```

# Docker push

We will be pushing our built image to the registry so that we can use it anywhere. The Docker CLI uses Docker’s public registry by default.

1. Log into the Docker public registry on your local machine.(If you don’t have account make it here hub.docker.com)

        $ docker login
          
2. Tag the image: It is more like naming the version of the image. It’s optional but it is recommended as it helps in maintaining the version

       $ docker tag <IMID> <yourhubusername>/<imagename>:<version>

3. Publish the image: Upload your tagged image to the repository: Once complete, the results of this upload are publicly available. If you log into Docker Hub, you will see the new image there, with its pull command.

       $ docker push <yourhubusername>/<imagename>

# Docker commands

List of running and stopped containers
```
$ docker ps -a
```
Stop container
```
$ docker stop <CTID>
```
Stop all containers
```
$ docker stop $(docker ps -a -q)
```
Delete container
```
$ docker rm <CTID>
```
Delete all containers
```
$ docker rm $(docker ps -a -q)
```
Delete images
```
$ docker rmi <IMID>
```
Delete all images
```
$ docker rmi $(docker images -q)
```


