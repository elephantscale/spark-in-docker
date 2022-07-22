#!/bin/bash

## By default, it will start bash 
## To start jupyter within container, type
##      jupyter lab

# set CURRENT_USER if not set
export CURRENT_USER="${CURRENT_USER-$(id -u):$(id -g)}"
# echo $CURRENT_USER

cmd=$1

# make maven build dir, if doesn't exist
mkdir -p  $HOME/.m2   $HOME/.cache  $HOME/.ivy2

# just in case 
docker network create bobafett-net 2> /dev/null

echo "Starting spark-dev with bash..."
echo "Ports mapped are:  8888 for jupyter and 4040-4045 for Spark UI"
echo "To start jupyter type  'jupyter lab' on console"
echo ""

docker run -it --rm \
        --user $CURRENT_USER \
        --network  bobafett-net \
        --hostname  spark-dev \
        -p 4040-4045:4040-4045 \
        -p 8888:8888 \
        -v $HOME/.m2:/home/jovyan/.m2  \
        -v $HOME/.ivy2:/home/jovyan/.ivy2  \
        -v $(pwd):/home/jovyan/workspace:z   \
        -v $(pwd)/data:/data   \
        -w /home/jovyan/workspace \
        elephantscale/spark-dev  /bin/bash
