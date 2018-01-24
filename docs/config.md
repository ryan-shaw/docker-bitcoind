garlicoind config tuning
======================

You can use environment variables to customize config ([see docker run environment options](https://docs.docker.com/engine/reference/run/#/env-environment-variables)):

        docker run -v garlicoind-data:/garlicoin --name=garlicoind-node -d \
            -p 42069:42069 \
            -p 127.0.0.1:42068:42068 \
            -e DISABLEWALLET=1 \
            -e PRINTTOCONSOLE=1 \
            -e RPCUSER=mysecretrpcuser \
            -e RPCPASSWORD=mysecretrpcpassword \
            ryan-shaw/garlicoind

Or you can use your very own config file like that:

        docker run -v garlicoind-data:/garlicoin --name=garlicoind-node -d \
            -p 42069:42069 \
            -p 127.0.0.1:42068:42068 \
            -v /etc/mygarlicoin.conf:/garlicoin/.garlicoin/garlicoin.conf \
            ryan-shaw/garlicoind
