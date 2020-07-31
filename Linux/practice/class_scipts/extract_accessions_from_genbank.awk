/^LOCUS/ { print $2 ; count++ }
# in awk, uninitialized variables have value 0 if used in
# arithmetic operations, and value "" (the empty string)
# if used in string operations
END { print count " accessions in this file." }
