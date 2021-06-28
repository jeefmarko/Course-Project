library(dplyr)
library(tidyverse)

#Merge
X_train_df= tbl_df(read.table('./train/X_train.txt'))
y_train_df= tbl_df(read.table('./train/y_train.txt'))
X_test_df= tbl_df(read.table('./test/X_test.txt'))
y_test_df= tbl_df(read.table('./test/y_test.txt'))
DF = bind_rows(X_train_df,X_test_df)

## Change names
# read names from 'features.txt'
ft_names = read.table('features.txt')
ft_names = ft_names$V2
# Assign these names to DF
names(DF)<-tolower(ft_names)

# Extract features with mean/std
meanv = grep('mean',names(DF));
stdv=grep('std',names(DF))
DF = DF[,c(meanv,stdv)]
DF = DF %>% mutate(id = 1:nrow(DF)) %>% 
    select(id,names(DF)[1:86])

# make long df
DF = DF %>% pivot_longer(-id,names_to = 'variable','measurement')

# split column names
# names_tbl = str_split_fixed(DF$variable %>% unique(),'-',3)
# names_tbl = tbl_df(data.frame(names_tbl)) #conver to table
DF_split = DF %>% separate(variable,c('name','type','dimension'),sep='-', remove = T,)
# remove '()'  from type variable 'mean()' -> 'mean' etc

rem2 = function(x) substr(x,1,nchar(x)-2) #remove last two chars of x
rep_freq = function(x) gsub('freq','',x)  #remove 'freq'
DF_split$type = lapply(DF_split$type,rem2) 
DF_split$type = lapply(DF_split$type,rep_freq) 
DF_split$type = replace_na(unlist(DF_split$type),'mean')
write.table(DF_split,'submission.txt',row.name=FALSE)

