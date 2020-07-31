BEGIN  { seqbuffer = " " }

/^>/  { seqbuffer = seqbuffer; seqbuffer = " "; print; next}

END { print seqbuffer}
