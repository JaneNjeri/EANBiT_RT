install.packages("tidyverse")

#three types of data types: logical, numeric, character
#one cannot mix several types within a single vector
y <- c("Alpha", 1, TRUE)
#most permissive way
y
#order of permissivity : logical < numeric < character
c(2.3, FALSE) #this false will be converted to numeric


#NAMED VECTOS
series <- runif(10)
series
summ <- summary(series)
str(summ)
class(summ)


#we can create named objects
x <- structure(c("a","b","c"), names = c(1,2,3))
names(x)
x[1]



#FACTOS

#factors are used in r to store categorical data,
#which means data whose variables can have only a finite no. of values

blood_groups <- c("A","B","AB","AB","A","O","O","A")
typeof(blood_groups)
class(blood_groups)


blood_groups <- factor(c("A","B","AB","AB","AB","A","O","O","A"))
typeof(blood_groups)
class(blood_groups)


#IMPOTANT
#factors are actually encoded as integer vectors
str(blood_groups)

#changing the levels of a factor DOES NOT affect the internal representation
levels(blood_groups)
levels(blood_groups) <- c("B","AB","A","O")
blood_groups

#be very careful when handling factors which values are numbers:
#for instance, in a survey where a given column contains the number of cigarettes smoked per day
#by patients

cigarettes <- factor(c("10","20","15","5","1","1","1","2","3","6","4"))
levels(cigarettes)

# **** DO NOT DO :
as.integer(cigarettes) #returns
#*internal* 

#the proper way to do it
as.integer(as.character(cigarettes))

#BEWArE! factos cannot be concatenated. Each factor comes with its own world of labels
c(factor(c("a","b")), factor("b"))
#the right way
factor(c(as.character(factor(c("a","b"))), as.character(factor("b"))))


#DATA FAMES
#we create a data frame giving to data.frame() the columns as seperate (named) arguments

y = data.frame(1:11, LETTERS[10:20], cigarettes)
y
#in case we don't name arguments, automatic names are given by r
#row names are given by default, and ae 1:nrow(df)

#as.integer() truncates the double values it is given
y <- data.frame(random_numbers = as.integer(runif(11, 0, 10000)), letter = LETTERS[10:20], 
                no_cig_per_day = cigarettes)
y
str(y)
names(y)
attributes(y)
rownames(y)

#we can use either integers (indices) or names to subset from y
head(y)
y[4,3]  #fourth row, third column
y["5", "letter"]  #row with name "5", column with name "letter"

#when I subset. the remaining rows still have their *original* name:
subset_y <- y[c(1,5,6),]
subset_y
y[2,]
y["5",] #same as above

names(y)  #

#data frames are *lists* whose slots are the columns
typeof(y) #list
class(y) #data.fame
y[2]
class(y[2])



#LISTS
list(4,89,4) -> dummy_list
class(dummy_list[3])

#but the *contents* of the n_th slot are accessed with l[[n]]
dummy_list[[3]]

#we have three ways of extracting the vector contents of a named column in a data fame
y

y[1] #yields a dataframe containing one column (not what JB asked for)
y["random_numbers"] #exactly the same as above, using column name instead of index


y[,1] #yields the vecto content of the first column, more simply:
y[[1]] #vector content
y$random_numbers #same thing
y$`new column` <- 1:11
names(y)
y$`new_column` #backticks are a way of escaping


#FUNCTIONS

#built-in
sum(y$random_numbers)
sum # primitive function, with undelying C code for efficiency

3+4
`+`(3,4) #using an infinix opeato as a function

# even subsetting is a fucntion
x[2]
`[`(x,2) #exactly the same

# or subsetting from a list or data frame:
class(y) # a data fame
`[[`(y,1)  # exactly the same as witting y[[1]]
