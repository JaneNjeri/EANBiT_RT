try solve this problem with a script (after going through man date :

Write a Bash script asking "What's your name?", then waiting for you (the user) to enter you name and press Enter , 
following what the program displays some text according to the following pattern: 
"Good morning/day/evening, your_name! It's now current_time on this lovely day of current_day." and it exits. 

The stuff in boldface is obviously to be replaced appropriately.
For instance, the message written by your program would be: Good day Emmanuel! It's now 12:57EAT on this lovely day of July 20.
or 'Good morning" in the morning hours, or "Good evening" in the evening hours, depending on the current time. 
Of course there will be at least an if or a case construct in your script.


!/bin/bash

