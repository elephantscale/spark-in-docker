"""
Running it on localhost
$       spark-submit --master local[*]  hello_spark.py  /etc/hosts

Running it on spark master
$       spark-submit --master spark://spark-master:7077  hello_spark.py  /etc/hosts
"""

import sys
import time
import pyspark
from pyspark.sql import SparkSession
from pyspark import SparkConf

if len(sys.argv) < 2:
            sys.exit("need file(s) to load")

config = ( SparkConf()
             .setAppName("Hello Spark")
             #.setMaster("spark://spark-master:7077")
             )

# Spark session & context
spark = SparkSession.builder.config(conf=config).getOrCreate()
print('Spark UI running on port ' + spark.sparkContext.uiWebUrl)
spark.sparkContext.setLogLevel("ERROR")  # hush errors

for file in sys.argv[1:]:
    ## TODO-2 : read a file as dataset
    ## hint : spark.read.text(file)
    f = spark.read.text(file)

    t1 = time.perf_counter()
    count = f.count()
    t2 = time.perf_counter()

    print("### {}: count:  {:,} ,  time took:  {:,.2f} ms".format(file, count, (t2-t1)*1000))

    # end of for loop
#####

print("Press Enter to continue...")

scanner = spark.sparkContext._gateway.jvm.java.util.Scanner
sys_in = getattr(spark.sparkContext._gateway.jvm.java.lang.System, 'in')
result = scanner(sys_in).nextLine()

spark.stop()  # close the session