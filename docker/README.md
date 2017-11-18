This directory contains information for getting an instance of submit.cs working in a Docker container.

IT IS AN UNFINISHED WORK IN PROGRESS


# General notes

Two important files are:
* Dockerfile
* docker-compose.yml

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
