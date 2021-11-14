# Jupyter + PySpark + Scala

This docker extends [Jupyter Pyspark docker image](https://hub.docker.com/r/jupyter/pyspark-notebook) by adding Scala and SBT

## Building locally

```bash
$   docker build . -t jupyter-pyspark-scala
```

## Publishing to Dockerhub

```bash
$   docker build . -t elephantscale/jupyter-pyspark-scala
$   docker login
$   docker push elephantscale/jupyter-pyspark-scala
```
