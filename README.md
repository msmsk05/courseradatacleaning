# Coursera-Peer-graded-Assignment-Getting-and-Cleaning-Data-Course-Project
# There are 3 files in this repo.
1.CodeBook.md contains variables, the data, and any process for cleaning the data.

2.run_analysis.R contains codes.

3.TidyData contains output of the run_analysis.R file.


##  Variable
x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
x_data, y_data and subject_data merge the previous datasets to further analysis.

## run_analysis.R code steps
1.Merge the training and the test sets to create one data set.
2. Extracting only the measurements on the mean and standard deviation for each measurement.
3. Using descriptive activity names to name the activities in the data set.
4. Labelling the data set with descriptive variable names.
5. Writing tidy data set in txt file.
