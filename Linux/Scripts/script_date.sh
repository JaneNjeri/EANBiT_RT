#!/bin/bash
#
# This script asks the user to enter their name, then
# writes a nice welcome message with the date.

echo -n "What is your name, my friend? "
read name # writes the input into that variable

# then we want to gather the current time in a specific format:
fulldate=$( date +%H%M%Z%B%d )
hours=${fulldate:0:2}
minutes=${fulldate:2:2}
day=${fulldate:(-2)}
text=${fulldate:4} ; text=${text%%[0-9]*}
# at this stage, 'text' contains the concatenation of the timezone code
# and the month name, which starts with an uppercase letter:
tzcode=${text%[A-Z]*}
tzcode_length=${#tzcode}
month=${text:tzcode_length}

# DEBUG:
# echo "${hours}:${minutes}${tzcode} on ${day} of ${month}"

# Now we determine whether it is evening (from 17:00 to 23:00), night (23:00 to 04:00), morning (04:00 to 10:00), or "day" (10:00 to 17:00)
# We could use an if/elif/else:

# Beware! the 'hours' variable is on two digits, it makes perfect sense here
# to perform tests based on alphabetical sort, all the more because sometimes
# numbers starting with a leading 0 can be interpreted in octal.

# Careful! >= and <= operators are not accepted for alphabetical string comparison!
if [[ "${hours}" < "23" && "${hours}" > "16" ]]
then
	period=evening
elif [[ "${hours}" == "23" || "${hours}" < "04" ]] # careful! a logical OR here!
then
	period=night
elif [[ "${hours}" > "03" && "${hours}" < "10" ]]
then
	period=morning
else
	period=day
fi

# And finally, printing the message:
echo "Good ${period}, ${name}! It is now ${hours}:${minutes}${tzcode} on this lovely day of ${month} ${day}."
