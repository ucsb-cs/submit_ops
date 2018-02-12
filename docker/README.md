This directory contains information for getting an instance of submit.cs working in a Docker container.


# Recent Updates 

## Development Setup (Skip this part if you just need to run a local copy)

### Installing Submodules
```
git submodule init
git submodule update -r 
```
you will now have a copy of the source code for submit.cs cloned at docker/submit 

when you run docker-compose up the submit_cs container will mount this directory at /submit\_cs 
you can view this by running
```
docker exec -it submit_cs bash
cd /submit_cs
```

### Launching Docker
```
docker volume prune # prune out old database, don't run this if you want to keep the data 
docker-compose build # build the lastest changes to the docker configuration 
docker-compose rm # remove old containers
docker-compose up # start up the submit_cs instance
docker exec -it submit_cs # takes you into the container
```

### Switching submit_cs to use your local changes
```
docker exec -it bash # this will shell you into the container running submit_cs 
/home/submit/bin/update_submit /submit_cs 
```
this restarts the submit\_cs web server, and reinstalls it from the source code located at /submit_cs (which is a volume we mount into docker corresponding to docker/submit on your host machine)

### Viewing any logs / errors
Once you have shelled into the submit_cs container logs can be found in 
```
cd /home/submit/logs
```
errors from the main process can be found in 
```
tail /home/submit/logs/uwsgi.log
```

## Just getting things up and running (useful commands)

Two important files are:
* Dockerfile
* docker-compose.yml


| Type this | to do this |
|------------|-----------|
| `docker-compose up | To bring up the whole composition of containers |
| `docker-compose down | To bring up the whole composition of containers |
| `docker-compose build | Rebuild the images (according to what is in the Dockerfile ) |
| `docker exec -it submit_cs bash` | root shell on submit_cs |
| `docker exec -it pg bash` | root shell on postgres machine |
| `docker exec -it mq bash` | root shell on postgres machine |
| `docker ps` | list all running containers |
| `docker ps -a` | list all containers that have exited and are running |


# What's in `docker-compose.yml`

Under services, each key represents a different container.

Each of those will be like its own virtual host.

The `container_name` entries will be put in the local DNS so that the
network nodes can refer to each other.

Docker's networking model for docker compose is that you can create
different virtual networks. By default it just creates one network.

`image` let's you know which image the containers is based on:
* for postgres and rabbitmq, we used stock images
* for submit_cs we used a different image
* TODO: Create submit_worker image (in meantime use "localhost")

`volumes`:

e.g.

```
- db-data:/var/lib/postgresql/data
```

At bottom we have:

```
volumes:
  db-data:
```

We can also do this to mount local files inside the container

```
 volumes:
      - ./build_scripts:/build_scripts
      - ./files:/tmp
```

This is an abstraction of having disk space somewhere in your file system.


# Step 1:  Create a docker container with CentOS

We used the file docker/Dockerfile from this repo

In the docker directory, we typed:

```
docker build -t pconrad/submit.cs.try1 .
```

The last three lines of output were:

```
...
Removing intermediate container fef12b84544a
Successfully built 0617d29324f1
Successfully tagged pconrad/submit.cs.try1:latest
```

That checked that the `COPY` and `RUN` steps in the `Dockerfile` worked, but
it did not check whether any of the `CMD` steps worked.  Those don't get
executed when you do `docker build`.  Those get executed when you run the container.

We can see that the build worked through the command `docker images`:

```
Phills-MacBook-Pro:docker pconrad$ docker images
REPOSITORY               TAG                 IMAGE ID            CREATED             SIZE
pconrad/submit.cs.try1   latest              0617d29324f1        2 minutes ago       877MB
...
Phills-MacBook-Pro:docker pconrad$
```

# Step 2: To run one container, you can do this.

BUT... typically we are going to run the whole docker compose,
so skip over this unless you only want to run one for some reason.


Now: we use this to run the container:

```
docker run -it pconrad/submit.cs.try1
```

OR:

```
docker run -it jeasterman/submit_cs
```

For example:

```
Phills-MacBook-Pro:docker pconrad$ docker run -it pconrad/submit.cs.try1
[root@5cd2b78e2641 /]# 
```

The command `docker ps` shows the running containers:

```
Phills-MacBook-Pro:docker pconrad$ docker ps
CONTAINER ID        IMAGE                    COMMAND             CREATED             STATUS              PORTS               NAMES
5cd2b78e2641        pconrad/submit.cs.try1   "/bin/bash"         2 minutes ago       Up 2 minutes                            jolly_borg
Phills-MacBook-Pro:docker pconrad$ 
```

The command `docker ps -a` also shows the ones that are stopped.

# Step 3: Run the whole system of containers via docker compose...

```
docker-compose up
```

Then, if it is working, to login and do stuff:

```
docker exec -it submit_cs bash
```

To take them all down:

```
docker-compose down
```
