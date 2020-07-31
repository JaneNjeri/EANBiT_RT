BEGIN { FS="\"" } # specifying the double quotes as the input field separator
/[[:blank:]]\/country=/ { print $2 }
