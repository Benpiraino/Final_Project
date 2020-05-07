This is a repository for analyzing csv files of data for ClpX N-terminal point mutations and their effects on 
three seperate assays and overlapping effects between the assays.
The files used in this repository are downloaded in the form of csv files after collecting the data. 
The three assays are a fluourescent binding assay, ATP hydrolysis, and substrate degradation rates. Each file consits of 
a column with the mutation names, a column with the average result for that mutation in the assay and a column of the standard deviation for each each assay.
You will need to install the ggplot package as well as the tidyverse package in order to run these scripts. 
Each individual assay will be plotted to analyze the results. Then the data sets will be joined and plotted to see if
there are any trends with certain mutations throughout the different assays.

