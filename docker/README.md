SOME OF THIS MAY BE OBSOLETE....   


This directory contains information for getting an instance of submit.cs working in a Docker container.

IT IS AN UNFINISHED WORK IN PROGRESS

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

# Step 2: Run the Container


Now: we use this to run the container:

```
docker run -it pconrad/submit.cs.try1
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



