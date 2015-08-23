# Readme for run_analysis.R

## The script assume the Samsung data set has already been downloaded to the working directory. If not, the user can un-comment the first 4 lines of the script to download the data set to working directory.

## load dplyr library, which will be used to generate the output tidy data set
## read in the test and train data sets by calling function readin_dat and merge them together to a single data set
* set the directory for the data set to be loaded
* readin test dataset (3 files reordered and combined by calling function readin_dat) 
* readin train dataset (3 files reordered and combined by calling function readin_dat)
* row combine test and train data set together to be a single data set

## readin the feature names and select only mean and std columns
* readin the feature names from features.txt
* set 1st column name to be sid (subject id), 2nd column name to be test (test activity), the rest to be the corresponding feature names
* select variables sid, test, mean and stardard deviation features that have "-mean()" and "-std()" in variable names
* subset dataframe containing selected variables

## put proper activity names for test observations
* readin activity names from activity_labels.txt
* substitute long names to proper short ones
* replace the number in the test observations with proper activity names 

## labels the data set with descriptive variable names
* remove "()" in variable names
* modified "BodyBody" to "Body"

## generate required tidy data set
* group data by sid and test and compute the mean for each of left varaibles

## output tidy data set
* output tidy data set using write.table with row.names = FALSE
* the output file name is tidy_data.txt
* print on screen to tell user the output file name and location

# script contains function readin_dat(directory)
## function readin_dat(directory)
* generate list of readin files in the directory
* re-order the filenames in the list
* readin data from each file
* column combine them together to be a single data set
 
