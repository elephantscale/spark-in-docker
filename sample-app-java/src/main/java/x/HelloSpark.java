package x;

import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.SparkSession;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;

import java.util.Scanner;

/*
Usage:
// running on local host
$   spark-submit --master local[*]   --class x.HelloSpark target/hello-spark-1.0.jar   /etc/hosts

// submitting to spark master
$   spark-submit --master spark://localhost:7077   --class x.HelloSpark target/hello-spark-1.0.jar   /etc/hosts
 */
 public class HelloSpark {
    
    public static void main(String[] args) {
        Logger.getLogger("org.apache.spark").setLevel(Level.ERROR); // hush logs

        if(args.length < 1) {
            System.out.println ("Need file(s) to load");
            System.exit(1);
        }
        SparkSession spark = SparkSession.builder().appName("Hello Spark").getOrCreate();
        System.out.println("Spark UI available at : " + spark.sparkContext().uiWebUrl().get());

        for(String file : args) {
            Dataset<String> fileDataSet = spark.read().textFile(file);
            
            Long t1 = System.nanoTime();
            Long count = fileDataSet.count();
            Long t2 = System.nanoTime();
            System.out.println (String.format("### %s : count: %,d, Time took: %,d ms",file, count, (t2-t1)/1000000 ));
        }
        // HACK : so the spark UI stays alive :-)
        System.out.println("### Hit enter to terminate the program...:");
        new Scanner(System.in).nextLine();
        spark.stop(); // close the session
    }
}