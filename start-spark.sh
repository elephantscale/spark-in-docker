#!/bin/bash

NUM_WORKERS=2
if [ -n "$1" ] ; then
    NUM_WORKERS=$1
fi


# set CURRENT_USER if not set
# export CURRENT_USER="${CURRENT_USER-$(id -u):$(id -g)}"


docker-compose   up --scale spark-worker=${NUM_WORKERS}  -d 

docker-compose   ps

echo -e "\n------------------------------------------------------------------------------------------------------"
echo -e "All services started!"
echo "For Spark.master.ui on port 8080"
echo "For Spark.app.ui ports can be accessed starting 4040 to 4045"
#echo "For Spark.app.ui ports running on  jupyter, add +20.  So jupyter:4040 is localhost:4060"
echo -e "\n------------------------------------------------------------------------------------------------------"

exit 0
