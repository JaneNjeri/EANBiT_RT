x <- c(1,4,5)
# three data types in R: double aka. numeric, logical and character
# one cannot mix several types within a single vector:
y <- c("alpha", 1, TRUE)
# automatic type conversion (casting) is performed towards the
# "most permissive" type
y # everything has been converted to character
# "order of permissivity": logical < numeric < character
c(2.3, FALSE) # this "FALSE" will be converted to numeric

# NAMED VECTORS
series <- runif(10) # generating 10 random values between 0 and 1
series
summary(series) -> summ # yields a named vector
str(summ)
class(summ)
attributes(summ)
# when using a named vector, objects can be accessed by name or by index
summ[1]
summ["Min"] # a non-existing index or name in an object leads to the value NA
summ["Min."]

# we can create named objects:
x <- structure(c("a","b","c"), names = c(1,2,3))
x # a named vector
names(x)
x[1]
x["1"] # in this specific case, the two are equal
identical(x[1], x["1"])

# FACTORS

# factors are used in R to store categorical data,
# which means data whose variables can have only a finite number of values
# example: blood groups in the classroom
blood_groups <- c("A","B","AB","AB","AB","A","O","O","A")
# above, a normal character vector
typeof(blood_groups) # character
class(blood_groups) # character

blood_groups <- factor(c("A","B","AB","AB","AB","A","O","O","A"))
typeof(blood_groups) # integer
class(blood_groups) # factor

# IMPORTANT!!!!
# factors are actually encoded as integer vectors.
str(blood_groups)

# changing the levels of a factor DOES NOT affect the internal
# representation
levels(blood_groups)
levels(blood_groups) <- c("B","AB","A","O")
blood_groups

# be very careful when handling factors which values are numbers:
# for instance, in a survey where a given column contains the number of cigarettes smoked per day by patients

cigarettes <- factor(c(10,20,15,5,1,1,1,2,3,6,4))
cigarettes
levels(cigarettes)

# *** DO NOT DO :
as.integer(cigarettes) # returns the integers corresponding to the
# *internal* encoding of the factor

# the proper way to get the actual numbers of cigarettes as integers is:
as.integer(as.character(cigarettes))

# beware! Factors cannot be combined. Each factor comes with its own
# world of labels
c(factor(c("a","b")), factor("b"))
# right way would be:
factor(c(as.character(factor(c("a","b"))), as.character(factor("b"))))



# DATA FRAMES
# we create a data frame giving to data.frame() the columns as separate (named) arguments

# example where we don't name the columns:
y <- data.frame(1:11, LETTERS[10:20], cigarettes)
# in case we don't name arguments, automatic names are give by R
# row names are given by default, and are 1:nrow(df)

# as.integer() truncates the double values it is given
y <- data.frame(random_numbers = as.integer(runif(11, 0, 10000)), letter = LETTERS[10:20], no_cig_per_day = cigarettes)
y
str(y)
names(y) # gives only the column names
attributes(y)
rownames(y)
# we can use either integers (indices) or names to subset from y:
head(y)
y[4,3] # fourth row, third column
y["5", "letter"] # row with name "5", column with name "letter"

# when I subset, the remaining rows still have their *original* name:
subset_y <- y[c(1,5,6),]
subset_y
y[2,]
y["5",] # same as above

# data frames are *lists* whose slots are the columns
typeof(y) # list
class(y) # data.frame
# that is why I can subset with one dimension only:
y[2] # still a data frame, containing only the second col of the original df
class(y[2])

# In R, one accesses the n_th slot of a list l with l[n]
# and an individual list slot is still a list
list(4,89,4) -> dummy_list
class(dummy_list[3])

# but the *contents* of the n_th slot are accessed with l[[n]]
dummy_list[[3]] # now this is a vector

# we have three ways of extracting the vector contents of a named column
# in a data frame:

y[1] # yields a data frame containing one column (not what I asked for)
y["random_numbers"] # exactly the same as above, using column name instead of index

y[,1] # yields the vector content of the first column, more simply:
y[[1]] # vector content
y$random_numbers # same thing
y$`new column` <- 1:11
names(y)
y$`new column` # backtics are the way to use names containing "special" characters, e.g. spaces

# FUNCTIONS

# built-in functions:
sum(y$random_numbers)
sum # a primitive function, with underlying C code for efficiency
3+4
`+`(3,4) # using an infix operator as a function

# even subsetting is a function:
x[2]
`[`(x,2) # exactly the same

# or subsetting from a list or data frame:
class(y) # a data frame
`[[`(y,1) # exactly the same as writing y[[1]]
