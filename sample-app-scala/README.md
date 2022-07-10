# Sample Spark App - Scala

## Login to Jupyter Container

Go to the printed Jupyter URL in browser.

Open terminal

## Build

In terminal

```bash
$   cd ~/work/sample-app-scala

$   sbt clean package
```

## Run

```bash
# First run on local mode
$   spark-submit --master local[*]  --class x.HelloSpark target/scala-2.12/hello-spark_2.12-1.0.jar  /etc/hosts

# Submit to spark master
$   spark-submit --master spark://spark-master:7077  --class x.HelloSpark target/scala-2.12/hello-spark_2.12-1.0.jar  /etc/hosts

# more data
$   spark-submit --master spark://spark-master:7077  --class x.HelloSpark target/scala-2.12/hello-spark_2.12-1.0.jar  /data/clickstream/*
```