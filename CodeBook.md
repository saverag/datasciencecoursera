## Run analysis overview
This script run in a simply fashion: 
* first we read variable names from features.txt to variable "names" (some stupid pun here, nevermind)
* we filter std and means to the logical vector "col_to_extraxt"
* and get "cleared_names" to which we add activity and subject
* get activity labels to variable "labels" (will use later)
* for train and test sets we read it, filter via. "col_to_extraxt", and binf with it's subject and activity
* we gets "test_set" and "train_set" which we bind together in "merged_set"
* assign "cleared_names" as column names to "merged_set" and replace numbers in activity column via. names using "labels" variable
* after that we delete useless variables like separeted trein adn test sets

We have cleared set. New tidy data I've cook very simple and fast. Assume thats we need averages for all extracted variables I did the following:
* split set via. activity and subject to the "newSet"
* we get list, to which I apllied sapply to get means of the variables and get matrix "tidySet" where columns are all combinations of activity and subject and rows are variables.

That's all.