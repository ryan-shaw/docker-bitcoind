garlicoind for Docker
===================

[![Docker Stars](https://img.shields.io/docker/stars/ryanshaw/garlicoind.svg)](https://hub.docker.com/r/ryanshaw/garlicoind/)
[![Docker Pulls](https://img.shields.io/docker/pulls/ryanshaw/garlicoind.svg)](https://hub.docker.com/r/ryanshaw/garlicoind/)
[![Build Status](https://travis-ci.org/ryanshaw/docker-garlicoind.svg?branch=master)](https://travis-ci.org/ryanshaw/docker-garlicoind/)
[![ImageLayers](https://images.microbadger.com/badges/image/ryanshaw/garlicoind.svg)](https://microbadger.com/#/images/ryanshaw/garlicoind)

Docker image that runs the Garlicoin garlicoind node in a container for easy deployment.


Requirements
------------

* Physical machine, cloud instance, or VPS that supports Docker (i.e. [Vultr](http://bit.ly/1HngXg0), [Digital Ocean](http://bit.ly/18AykdD), KVM or XEN based VMs) running Ubuntu 14.04 or later (*not OpenVZ containers!*)
* At least 1 GB to store the block chain files (and always growing!)
* At least 1 GB RAM + 2 GB swap file

Recommended and tested on unadvertised (only shown within control panel) [Vultr SATA Storage 1024 MB RAM/250 GB disk instance @ $10/mo](http://bit.ly/vultrgarlicoind).  Vultr also *accepts Bitcoin payments*!


Quick Start
-----------

1. Create a `garlicoind-data` volume to persist the garlicoind blockchain data, should exit immediately.  The `garlicoind-data` container will store the blockchain when the node container is recreated (software upgrade, reboot, etc):

        docker volume create --name=garlicoind-data
        docker run -v garlicoind-data:/garlicoin --name=garlicoind-node -d \
            -p 42069:42069 \
            -p 127.0.0.1:42068:42068 \
            ryanshaw/garlicoind

2. Verify that the container is running and garlicoind node is downloading the blockchain

        $ docker ps
        CONTAINER ID        IMAGE                         COMMAND             CREATED             STATUS              PORTS                                              NAMES
        d0e1076b2dca        ryanshaw/garlicoind:latest     "grlc_oneshot"       2 seconds ago       Up 1 seconds        127.0.0.1:42068->42068/tcp, 0.0.0.0:42069->42069/tcp   garlicoind-node

3. You can then access the daemon's output thanks to the [docker logs command]( https://docs.docker.com/reference/commandline/cli/#logs)

        docker logs -f garlicoind-node

4. Install optional init scripts for upstart and systemd are in the `init` directory.


Documentation
-------------

* Additional documentation in the [docs folder](docs).
