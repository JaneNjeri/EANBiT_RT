NR == 1 { print; next } # this line only to treat the first input line 
!/^>/ { printf "%s", $0 }
/^>/ && NR>1 { print "\n" $0 }
END { print "" } # just to print a newline character
