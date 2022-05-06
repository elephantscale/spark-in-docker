#!/bin/bash

NUM_WORKERS=2
if [ -n "$1" ] ; then
    NUM_WORKERS=$1
fi

# cache dir, set permission to user 1000 and group 100 (matching jupyter notebook user)
# This will be used for sbt and maven builds.  So downloads will be cached 
# between container restarts
sudo mkdir -p .zcache;  sudo chown -R 1000:100 .zcache

docker-compose  up --scale spark-worker=${NUM_WORKERS}  -d 

jupyter_out=$(docker-compose  logs | grep '127\.0\.0\.1.*\/\?token=')

while [ -z "$jupyter_out" ] 
do
    sleep 5
    jupyter_out=$(docker-compose  logs | grep '127\.0\.0\.1.*\/\?token=')
done

echo ; echo "To access Jupyter notebook..."
echo "$jupyter_out"

echo "For Spark.app.ui ports running on spark master, add +10.  So Spark-master:4040 is localhost:4050"
echo "For Spark.app.ui ports running on  jupyter, add +20.  So jupyter:4040 is localhost:4060"
