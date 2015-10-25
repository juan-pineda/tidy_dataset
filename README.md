# tidy_dataset

This repository contains 2 files, the analysis "run_analysis.R" script and the "codebook"

## run_analysis.R

This file do the following actions:
* reads the tables with all information about the activities
* merges the training and the train datasets into a single dataset
* filter out the columns, to include only those with the string "mean","std" in their names
* includes the descriptive name for each activity
* changes the names of the columns for more descriptive, readable ones
* summarize the final tables to report only the "mean" value for each set of (subject,activity)
*  stores the tidy dataset in the disk
