package x

import org.apache.spark.sql.SparkSession
import org.apache.spark.SparkConf
import scala.io.StdIn.readLine
import org.apache.log4j.{Level, Logger}

object HelloSpark {
  def main(args: Array[String]): Unit = {

    Logger.getLogger("org.apache.spark").setLevel(Level.ERROR)

    if (args.length < 1) {
      println("need file(s) to load")
      System.exit(1)
    }

    val conf = new SparkConf().setAppName("HelloSpark")
    //conf.setMaster("spark://localhost:7077") // optional for debugging
    val spark = SparkSession.builder().config(conf).getOrCreate()

    // set the logs to error
    // spark.sparkContext.setLogLevel("ERROR")

    println("### This app UI is available on : " + spark.sparkContext.uiWebUrl.get)

    var file = ""
    for (file <- args) { // looping over files
      val f = spark.read.textFile(file)
      val t1 = System.nanoTime()
      val count = f.count
      val t2 = System.nanoTime()

      println("### %s: count:  %,d ,  time took:  %,f ms".format(file, count, (t2 - t1) / 1e6))
    }

    // HACK : so the 4040 UI stays alive :-)
    println("### Hit enter to terminate the program...:")
    val line = readLine()

    spark.stop() // close the session
  }
}

