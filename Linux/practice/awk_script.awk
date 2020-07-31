BEGIN  { count=0 }

NF>1 { print substr ($1, 2); count+=1 }

END { print count   " sequences" }

