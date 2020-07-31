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
# We can use a case statement:

case "${hours}" in
	1[7-9] | 2[0-2] )   #or type this line here: "17 | 18 | 19 | 20")
	period=evening
	;;

	23 | 0[0-3] )
	period=night
	;;

	0[4-9] | 10 )
	period=morning
	;;

	* )
	period=day
	;;
esac

# And finally, printing the message:
echo "Good ${period}, ${name}! It is now ${hours}:${minutes}${tzcode} on this lovely day of ${month} ${day}."
