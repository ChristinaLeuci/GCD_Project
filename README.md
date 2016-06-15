This directory contains the completed project assignment for Coursera's Getting and Cleaning Data class.  The goal was to manipulate a large and cumbersome dataset into a "tidy" set of data.

UC Irvine maintains an online repository of publicly accessible datasets.  This link provides access to the dataset used for the assignment, along with information on the original data structure:  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

The data were produced by this study as cited:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013

Thirty subjects(21 'training' and 9 'test') were supplied with a specially outfitted smartphone to be worn at the waist.  The embedded accelerometer and gyroscope captured linear acceleration and velocity along the x-y-z axes.

The original data reported for 10299 observations were:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration
- Triaxial Angular velocity from the gyroscope
- A 561-feature vector with time and frequency domain variables
- Its activity label
- An identifier for the subject

Separate files were maintained for subject, activity labels, feature labels, 'training' readings and 'test' readings

The assignment requirements:
- Files are downloaded and properly joined together into one large dataset
- Extract a subset of the data for calculated mean and standard deviation values
- Column headers are editted for readability
- Produce a compact version of the data grouped by subject and activity
- Provide an average for each feature as defined by grouping
- Output the result to a file stoed on the hard drive

The actual program is contained in runanalysis.R; CodeBook.md contains a description of the data file produced by the code.





