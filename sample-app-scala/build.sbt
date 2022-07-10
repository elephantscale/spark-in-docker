name := "hello-spark"

version := "1.0"

scalaVersion := "2.12.15"

libraryDependencies += "org.apache.spark" %% "spark-sql" % "3.3.0"

// for accessing files from S3 or HDFS
libraryDependencies += "org.apache.hadoop" % "hadoop-client" % "3.3.1" exclude("com.google.guava", "guava")

// ignore files in .ipynb_checkpoints
excludeFilter in (Compile, unmanagedSources) ~= { _ ||
   new FileFilter {
      def accept(f: File) = f.getPath.containsSlice("/.ipynb_checkpoints/")
   } }
