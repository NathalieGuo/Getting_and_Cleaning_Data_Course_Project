###Codebook for dataone and datatwo
***
These two data sets were generated on the basis of Human Activity Recognition Using Smartphones Data Set.(source:"http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones") 30 volunteers were recruited in the experiments to record body movement data measured by the inertial sensors of smartphone(Samsung Galaxy S II) when they performed one of the six acitivities.

***

####dataone 
The first data set has 10299 observations(7352 from train set, 2947 from test set) and 88 variables. Each observation is the recording of a series of time and frequency domain variables measured by the accelerometer and gyroscope inside the smartphone when a subject perform a activity. The first two variables are subjectID and activitylabel. The rest 86 variables are means or standard deviations of measurements as described by their names.

--'subjectID' represents the subject who recorded the data. It is a numeric variable ranging from 1 to 30. <br>
--'activitylabel' identifies the activity that the subject performed. It is a character variable with 6 values (walking, walking upstairs, walking downstairs, sitting, standing, laying). 

***

####datatwo
The second data set has 35 observations and 88 variables. The first two variables are subjectID and activitylabel. The rest 86 variables are the average means or average standard deviations of measurements of each combination of subject and activity. 
