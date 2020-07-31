# Working with JSON files.
setwd("~/Git_repos/EANBiT_RT/Advanced_R/JSON_work/")

library(dplyr)

# first thing (to do only once): install rjson
install.packages('rjson')

data <- rjson::fromJSON(file = "ERR987781.json")
str(data)
class(data) # a simple list
typeof(data)

length(data) # there are 12 slots at the highest level of the data object
names(data) # here we have 12 contigs
length(data[[6]])

# we want to get the length for all of the 12 slots in data:
lapply(X = data, FUN = length) # applying the same operation to all slots
data[[2]][[1]]$ARO_name
data[[2]][[7]]$ARO_name

# We see that the data is "uneven": some of the 12 contigs (as R lists) have lots of slots,
# some other very few.

# In order to be able to create a table like the one Ivan shared with us on Slack, 
# we need to write with lists of lists, and traverse them recursively until we reach
# a list that contains a slot called "ARO_name", another called "type_match", etc
extract_ARO_name = function(l) { l$ARO_name } # extracting directly from the list containing that field "ARO_name"
extract_ARO_name_level1 = function(l) { lapply(X = l, FUN = extract_ARO_name) } # extracting iteratively from all the lists at a higher level
extract_ARO_name_level1(data[[2]]) # this is an example of how we can use the function we just defined above

names(data[[2]][[7]])
# then we attempted to use "rapply" to apply recursively the same function in a list.
# that is probably an approach that could work, but we don't have enough knowledge and
# know-how with that function for now, so we aborted that attempt.
# I encourage you to read carefully the manpage for this base function, and
# I'm sure success will ensue!
# rapply(object = data[[2]], f = extract_ARO_name, how = "replace", classes="list")

# Because of the way we defined our functions above, hardcoding the
# name of the field we want to extract, we have to write again almost the
# exact same function to extract another field...
extract_RGI_criteria = function(l) { l$type_match }
extract_RGI_criteria_level1 = function(l) { lapply(X = l, FUN = extract_RGI_criteria) }
extract_RGI_criteria_level1(data[[2]])


# then build a data frame column by column:
col1 = unlist(extract_RGI_criteria_level1(data[[4]]), use.names=FALSE)
length(col1)
typeof(col1)
head(col1)

col2 = unlist(extract_ARO_name_level1(data[[4]]), use.names=FALSE)

# then we make a tibble out of those two columns
tibble::tibble(`RGI Criteria` = col1, `ARO Term` = col2) -> my_table

## more flexible extractors (parameterizable) are a better solution:
# instead of writing different functions to extract different fields,
# we parameterize our functions so that they take the name of the field
# to be extracted as an argument.
extract_field = function(mylist, myfield) { `[[`(mylist, myfield) }
# testing the above:
extract_RGI_criteria(data[[2]][[2]])
extract_field(data[[2]][[2]], "type_match")

# so actually, the function definition above means that extract_field
# is nothing but `[[` (the function that extracts the content of a list slot)


### final solution (hopefully)

extract_field_level1 <- function(mylist, myfield) { lapply(X = mylist, FUN = `[[`, myfield) }

unlist(data, recursive = F, use.names = F) -> big_obj # getting a list with 863 slots

col1 = unlist(extract_field_level1(big_obj, 'type_match'), use.names = FALSE)
col2 = unlist(extract_field_level1(big_obj, 'ARO_name'), use.names = FALSE)
perc_id = unlist(extract_field_level1(big_obj, 'perc_identity'), use.names = FALSE)

tibble::tibble(`RGI Criteria` = col1, `ARO Term` = col2, `%age identity` = perc_id) -> my_table

# we tabulate the values in the first column to see how many "Loose",
# "Strict", etc:
head(my_table)
table(my_table$`RGI Criteria`)


my_table %>% filter(`RGI Criteria` != 'Loose') -> reduced_table

# we try another approach: populating our dataframe row by row, 
# without including those rows where the match_type is "Loose".

# we first create an empty tibble:
tibble::tibble(slot = numeric(0), `RGI Criteria` = character(0), `ARO Term` = character(0), `Detection criteria` = character(0), `Resistance Mechanism` = character(0), `%age identity` = numeric(0), ARO_names = list()) -> growing_table

# we now loop through all elements of the table to retain only those
# where the match_type is not "Loose".

for (i in 1:length(big_obj)) {
  # at this stage, big_obj[[i]] is an element we want to extract fields from
  element <- big_obj[[i]]
  if (element$type_match == "Loose") next
  ARO_stuff = element$ARO_category
  n = length(ARO_stuff) # so the last element is at position n in that list
  growing_table <- bind_rows(
    growing_table,
    tibble(slot = i,
           `RGI Criteria` = element$type_match,
           `ARO Term` = element$ARO_name,
           `Detection criteria` = element$model_type,
           `Resistance Mechanism` = ARO_stuff[[n]]$category_aro_name,
           `%age identity` = element$perc_identity,
           ARO_names = list(names(element$ARO_category))))
}

# after which, we have a nice tibble.

# DEBUG
# big_obj[[862]]$ARO_category$`35997`$category_aro_name
# big_obj[[863]]$ARO_category$`35997`$category_aro_name
# big_obj[[1]]$ARO_category$`36001`$category_aro_name
# big_obj[[10]]$ARO_category$`36001`$category_aro_name

###
## graphical representations from this tibble:
###

library(ggplot2)
library(scales)

nrow(growing_table) # 18

growing_table %>% ggplot(mapping = aes(x = `Resistance Mechanism`, fill = `Resistance Mechanism`)) + 
  geom_bar(width = 0.7) + 
  theme(axis.text.x = element_text(angle=45 ,hjust = 1), legend.position = "right") + 
  scale_x_discrete(labels = wrap_format(20))
# we are happy with this first barplot.

# Beware!! in aes() ONLY write associations btwn features of your plot
# i.e (x-axis, y-axis, line colour, fill colour etc) and expressions based on variables from your data


growing_table %>% ggplot(mapping = aes(x = `Resistance Mechanism`, fill = `RGI Criteria`)) + 
  geom_bar(width = 0.7) + 
  theme(axis.text.x = element_text(angle=45 ,hjust = 1), legend.position = "right") + 
  scale_x_discrete(labels = wrap_format(20))


# let us try another representation where the fill colour is continous

growing_table %>% ggplot(mapping = aes(x = `Resistance Mechanism`, fill = `%age identity`)) + 
  geom_bar(width = 0.7) + 
  theme(axis.text.x = element_text(angle=45 ,hjust = 1), legend.position = "right") + 
  scale_x_discrete(labels = wrap_format(20)) +
  scale_fill_gradient(low = "#00F000", high = "#F00000")


