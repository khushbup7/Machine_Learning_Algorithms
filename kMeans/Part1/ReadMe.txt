This code implements kmeans algorithm using Euclidean distance on a dataset with two attributes.
=================================================================================================
To compile the code: 

javac kmeans.java Cluster.java Point.java

********************************
To run the code:

java kmeans <no-of-clusters> <input-data-file> <output-file>

for example:
java kmeans 5 D:\UT_DALLAS\MACHINE_LEARNING\HW_5\test_data.txt D:\UT_DALLAS\MACHINE_LEARNING\HW_5\outputpart1.txt
=================================================================================================

The first k points are taken as initial centroids for the clusters.

The algorithm converges if the centroids no longer change or the algorithm has been iterated for 25 iterations.
