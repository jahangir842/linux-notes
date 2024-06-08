from pyspark import SparkContext

if __name__ == "__main__":
    sc = SparkContext("local", "Word Count")
    text_file = sc.textFile("path/to/textfile.txt")
    counts = text_file.flatMap(lambda line: line.split(" ")) \
                      .map(lambda word: (word, 1)) \
                      .reduceByKey(lambda a, b: a + b)
    counts.saveAsTextFile("output")
