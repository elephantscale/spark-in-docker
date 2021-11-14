FROM jupyter/pyspark-notebook:spark-3.2.0

user root

RUN apt-get update -yq && \
        apt-get -yq upgrade && \
        apt-get install -yq  --no-install-recommends \
                less \
                vim  && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*


RUN cd /usr/local;  wget -q https://elephantscale-public.s3.amazonaws.com/downloads/scala-2.12.15.tgz  && \
        tar xf scala-2.12.15.tgz && \
        mv scala-2.12.15  scala && \
        rm scala-2.12.15.tgz

RUN cd /usr/local;   wget -q https://elephantscale-public.s3.amazonaws.com/downloads/sbt-1.5.5.tgz && \
        tar xf   sbt-1.5.5.tgz  && \
        rm sbt-1.5.5.tgz

RUN cd /usr/local;   wget -q https://elephantscale-public.s3.amazonaws.com/downloads/apache-maven-3.8.3-bin.tar.gz  && \
        tar xf apache-maven-3.8.3-bin.tar.gz && \
        mv apache-maven-3.8.3 maven && \
        rm apache-maven-3.8.3-bin.tar.gz 

ENV PATH /usr/local/scala/bin:/usr/local/sbt/bin:/usr/local/maven/bin:$PATH

USER $NB_USER