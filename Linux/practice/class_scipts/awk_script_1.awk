BEGIN { count = 0 }

NF>1 { print substr($1,2); count += 1 }

END { print "There are " count " sequences in this file of " NR " lines." }


# the substr() function outputs
# part of a string
# substr(mystring, 2) starts
# with the 2nd char of mystring
