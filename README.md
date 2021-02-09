Data description
Data comes from sensor signals measured with waist-mounted smartphone from 30 people. X, Y, and Z are measurements of different directions, while Jerk is measurements of Jerk signals and Mag are measurements of magnitude of the three dimensional signals calculated using the Euclidean norm.

Code explanation
The code written combines the training dataset and test datasets, extracting variables to create another dataset containing only the averages of the mean, and standard deviation for each activity, as well as aggregating the data by person and activity.
It also cleans the dataset, by re-labelling the activity from 1-6 to the corresponding name of the activity found in features.txt, removing special characters and renaming the method of data capture so that it is more readable.
