FROM jupyter/pyspark-notebook:spark-3.3.0

user root

RUN apt-get update -yq && \
        apt-get -yq upgrade && \
        apt-get install -yq  --no-install-recommends \
                jq \
                less \
                vim   \
                zip \
                && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*


RUN cd /usr/local;  wget -q https://downloads.lightbend.com/scala/2.13.8/scala-2.13.8.tgz  && \
        tar xf scala-2.13.8.tgz && \
        mv scala-2.13.8  scala && \
        rm -f scala-2.13.8.tgz

RUN cd /usr/local;   wget -q https://github.com/sbt/sbt/releases/download/v1.6.2/sbt-1.6.2.zip && \
        unzip   sbt-1.6.2.zip  && \
        rm -f sbt-1.6.2.zip

RUN cd /usr/local;   wget -q https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.tar.gz && \
        tar xf apache-maven-3.8.6-bin.tar.gz && \
        mv apache-maven-3.8.6 maven && \
        rm -f apache-maven-3.8.6-bin.tar.gz 

# Get Spark 3.3.0 built with Scala 2.12
# and link it to /usr/local/spark
RUN  cd /usr/local; wget -q https://dlcdn.apache.org/spark/spark-3.3.0/spark-3.3.0-bin-hadoop3.tgz  && \
                tar xvf spark-3.3.0-bin-hadoop3.tgz && \
                rm -f spark && \
                ln -s spark-3.3.0-bin-hadoop3  spark && \
                rm -f spark-3.3.0-bin-hadoop3.tgz 

ENV PATH /usr/local/scala/bin:/usr/local/sbt/bin:/usr/local/maven/bin:$PATH

RUN mv -f /home/$NB_USER/work   /home/$NB_USER/workspace  && mkdir -p /home/$NB_USER/workspace

USER $NB_USER
