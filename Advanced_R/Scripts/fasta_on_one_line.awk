BEGIN { seqbuffer = "" }
/^>/ { if (NR>1) { print seqbuffer }; seqbuffer = ""; print; next }
NF == 1 { seqbuffer = seqbuffer $1 } # string concatenation
END { print seqbuffer }
