This code implements Decision Tree in java using training dataset and tests it against test dataset.
The decision tree is further pruned and validated against validation dataset.
Information gain heuristic is used for selecting the next attribute.

==============================================

To compile the code: 
javac DecisionTree.java Node.java ReadExcelFile.java

To run the code: 
java DecisionTree L K training_set_path validation_set_path testing_set_path yes/no

Example: 
java DecisionTree 4 5 D:\UT_DALLAS\MACHINE_LEARNING\HW_2\data_sets1\training_set.csv D:\UT_DALLAS\MACHINE_LEARNING\HW_2\data_sets1\validation_set.csv D:\UT_DALLAS\MACHINE_LEARNING\HW_2\data_sets1\test_set.csv yes

where:
L = parameter value of L used in post pruning
K = parameter value of K used in post pruning
training_set_path = path of the training set to be used
validation_set_path = path of the validation set
testing_set_path = path of the testing set
yes/no = the words "yes" or "no" to print the decision tree or not

The first pair of values of L and K is taken from the user whereas the rest 9 values are randomly generated using random function.

================================================

Data set 1:

Accuracy with test data: 75.85
Accuracy of pruned tree = 76.0 for L = 4 and K = 5
Accuracy with validation data: 76.0
Accuracy of pruned tree = 76.0 for L = 7 and K = 8
Accuracy of pruned tree = 75.9 for L = 2 and K = 3
Accuracy of pruned tree = 75.9 for L = 1 and K = 1
Accuracy of pruned tree = 75.9 for L = 1 and K = 9
Accuracy of pruned tree = 76.0 for L = 8 and K = 9
Accuracy of pruned tree = 75.9 for L = 1 and K = 5
Accuracy of pruned tree = 76.0 for L = 6 and K = 8
Accuracy of pruned tree = 75.9 for L = 1 and K = 4
Accuracy of pruned tree = 76.0 for L = 9 and K = 5

Dataset 2:
Accuracy with test data: 72.33333333333334
Accuracy of pruned tree = 77.16666666666666 for L = 4 and K = 5
Accuracy with validation data: 77.16666666666666
Accuracy of pruned tree = 77.16666666666666 for L = 9 and K = 1
Accuracy of pruned tree = 77.16666666666666 for L = 7 and K = 8
Accuracy of pruned tree = 77.16666666666666 for L = 4 and K = 9
Accuracy of pruned tree = 77.16666666666666 for L = 1 and K = 2
Accuracy of pruned tree = 77.16666666666666 for L = 6 and K = 4
Accuracy of pruned tree = 77.16666666666666 for L = 7 and K = 3
Accuracy of pruned tree = 77.16666666666666 for L = 1 and K = 3
Accuracy of pruned tree = 77.16666666666666 for L = 4 and K = 9
Accuracy of pruned tree = 77.16666666666666 for L = 6 and K = 2
