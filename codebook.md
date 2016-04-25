# yebvas

## R script to create a tidy data set from the Human Activity Recognition Using Smartphones Dataset

The run_analysis.R script downloads the Human Activity Recognition Using Smartphones Dataset, compiles the data on means and standard devivations into a single dataframe, and renames the variables.

### Procedure

1. Create directory for data. Download and unzip raw data
2. Read in raw data
3. combine raw data into one data frame
4. Read in variable names and create subset vectors
5. Create vector of tidy variable names
6. Subset raw data
7. Rename variables with tidy names
8. Create vector of descriptive activity data
9. Change numeric activity data to descriprive activity data
10. Create summary table

### Output

The output is a summary table that gives the mean of each variable grouped by subject and activity