BEGIN  { count=0 }

/^LOCUS/ { print $2; count+=1 }

END { print count   " accession numbers" }
