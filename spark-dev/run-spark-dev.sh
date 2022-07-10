#!/bin/bash

# set CURRENT_USER if not set
export CURRENT_USER="${CURRENT_USER-$(id -u):$(id -g)}"
# echo $CURRENT_USER

cmd=$1

# make maven build dir, if doesn't exist
mkdir -p  $HOME/.m2   $HOME/.cache  $HOME/.ivy2

# map port if running jupyter
if [ -z "$cmd" ] ; then
        docker run -it --rm \
                --user $CURRENT_USER \
                --network  bobafett-net \
                -v $HOME/.m2:/home/jovyan/.m2  \
                -v $HOME/.ivy2:/home/jovyan/.ivy2  \
                -v $(pwd):/home/jovyan/workspace:z   \
                -v $(pwd)/data:/data   \
                -w /home/jovyan/workspace \
                -p 8888:8888 \
                elephantscale/spark-dev  $*
else
## running a custom cmd, no need for port mapping
## supply ports like below for spark-app UI
##       -p 4040:4040
        docker run -it --rm \
                --user $CURRENT_USER \
                --network  bobafett-net \
                -v $HOME/.m2:/home/jovyan/.m2  \
                -v $HOME/.ivy2:/home/jovyan/.ivy2  \
                -v $(pwd):/home/jovyan/workspace:z   \
                -v $(pwd)/data:/data   \
                -w /home/jovyan/workspace \
                elephantscale/spark-dev  $*
fi
