This code implements kmeans clustering algorithm using Jaccard distance for clustering redundant/repeated tweets.
=================================================================================================
To compile the code: 

javac Analysis.java Cluster.java Tweets.java

********************************
To run the code:

java Analysis <no-of-clusters> <InititialSeedsfile> <Tweetsdatafile> <outputfile>

for example:
java Analysis 25 D:\UT_DALLAS\MACHINE_LEARNING\HW_5\InitialSeeds.txt D:\UT_DALLAS\MACHINE_LEARNING\HW_5\Tweets.json D:\UT_DALLAS\MACHINE_LEARNING\HW_5\outputpart2.txt
=================================================================================================

The centroids are updated such that the centroid is a tweet which has the minimum distance to all the other tweets in the cluster.

SSE for k = 25 is 15.228372855140694