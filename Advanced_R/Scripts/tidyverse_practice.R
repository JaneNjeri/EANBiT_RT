#TIDYVESE

#tidyverse is a collection of packages. Loaded automatically upon a library(tidyverse) are:
#ggplot2, tidyr, purr, dplyr, tibble, read, string, forcats
#dply and tidyr
#magrittr and readxl are included in the tidyverse collection but are not loaded during loading

library(tidyverse)
# ggplot2 : for nice graphics 
# tidyr : provides fucntions to tidy your data
# (tidy data : 1 observation per row, one variable per column)



#import data from an Excel file using readxl
readxl::read_xlsx("~/Git_repos/EANBiT_RT/Advanced_/tutorial_data.xlsx") -> data1
glimpse(data1)
View(data1)

# %>% means piping
data1 %>% select(BMI)  # the data is still a tibble
data1 %>% select(BMI) %>% mean(na.rm=T) # not supposed to do this

mean(data1[["BMI"]])

# the right way to do it with dply
data1 %>% summarise(meanBMI = mean(BMI))

# we can use helper functions to determine which columns to select
names(data1)
data1 %>% select(c(1,4,6))
data1[c(1,4,6)] # the same as above without tidyverse

data1 %>% select(starts_with("D"))
data1 %>% select(contains("E", ignore.case = F))

# to select rows (aka: cases or observations) use filter():
data1 %>% filter(AGE >= 62)

# combining filters
data1 %>% filter(AGE >= 62 & SYSBP <1 00) # logical AND
data1 %>% filter(AGE >= 62 | SYSBP < 100) # logical OR
data1 %>% filter(AGE == 62)  # equality test operator is ==
#NEVEr use '=' operator
data1 %>% select(AGE = 62)


# by the way, on complex objects, use identical():
a <- c(1,2,3)
b <- 1:3
a==b # element-wise comparison
identical(a,b) # vey strict
identical(as.integer(a), b) # TRUE


# group_by enables to have group of observations
data1 %>% group_by(educ)
data1 %>% group_by(educ) %>% summarise(meanBMI = mean(BMI))

# group of more than one column
data1 %>% group_by(educ) %>% group_by(SEX)
# careful! new grouping erases the previous grouping

