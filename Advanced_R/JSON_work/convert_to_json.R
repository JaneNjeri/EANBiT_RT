# working with a JSON file

setwd("~/Git_repos/EANBiT_RT/Advanced_/JSON_work/")

install.packages('rjson')
library(rjson)

data <- rjson::fromJSON(file = "ERR987781.json")
class(data)
typeof(data)
length(data)  # there are 12 slots at the highest level of the data object
names(data)   # here we have 12 contigs

# we want to get the length of all the 12 slots in the data
lapply(X = data, FUN = length)

data[[2]][[1]]$ARO_name
data[[2]][[7]]$ARO_name

extract_ARO_name = function(l) { l$ARO_name }
extract_ARO_name_level1 = function(l) { lapply(X=l, FUN = extract_ARO_name) }
extract_ARO_name_level1(data[[2]])
names(data[[2]][[7]])

extract_RGI_criteria = function(l) { l$type_match }
extract_RGI_criteria_level1 = function(l) { lapply(X=l, FUN = extract_RGI_criteria) }
extract_RGI_criteria_level1(data[[2]])


# FINAL SOL

extract_field_level1 = function(mylist, myfield) { }

unlist(data, recursive = F) -> big_obj
names(big_obj)
