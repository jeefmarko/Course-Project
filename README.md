# Course-Project
JSU Data Cleaning with R

## How the script works
1. Loads libraries dplyr and tidyverse
2. Reads the X_train and X_test datasets from the source
3. Merges the two datasets into one named `DF` using bind_rows
4. Updates names to human-readable from the `features.txt` file all in lowercase
5. Varibles are grouped by means, stds, and angle
6. Non-angle variables are further split into dimension (x,y,z)
7. Some more cleaning tasks (changing NA to mean for angle variables, removing `freq` from some means
