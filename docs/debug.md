# Debugging

## Things to Check

* RAM utilization -- garlicoind is very hungry and typically needs in excess of 1GB.  A swap file might be necessary.
* Disk utilization -- The bitcoin blockchain will continue growing and growing and growing.  Then it will grow some more.  At the time of writing, 40GB+ is necessary.

## Viewing garlicoind Logs

    docker logs garlicoind-node


## Running Bash in Docker Container

*Note:* This container will be run in the same way as the garlicoind node, but will not connect to already running containers or processes.

    docker run -v garlicoind-data:/bitcoin --rm -it ryan-shaw/garlicoind bash -l

You can also attach bash into running container to debug running garlicoind

    docker exec -it garlicoind-node bash -l


