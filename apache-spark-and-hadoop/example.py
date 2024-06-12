from pyspark.sql import SparkSession

# Create a SparkSession, change localhost with ip of master node.
spark = SparkSession.builder \
    .appName("ExampleApp") \
    .config("spark.master", "spark://localhost:7077") \
    .getOrCreate()

# Define your task or job
data = [('Alice', 1), ('Bob', 2), ('Cathy', 3)]
df = spark.createDataFrame(data, ['Name', 'Age'])
df.show()

# Stop the SparkSession
spark.stop()
