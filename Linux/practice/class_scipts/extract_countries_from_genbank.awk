# checking that the country tags are in $1

/[[:blank:]]\/country=/ {
		country_name_length = length($1) - 11;
		print substr($1,11,country_name_length);
			}
			
			
