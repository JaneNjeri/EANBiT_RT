# In most cases, the questions below are independent of each other. Many questions accept different ways to address them 
# (which means several "right answers").

# 1. Suppose your current working directory is /home/jb/Linux/Exercises/. What is the command that will enable to move to /home/jb/Fun_stuff/?
cd
cd - #***brings you to the previous directory you were in***


# 2. How do you count the number of lines contained in a text file?
wc -l
wc #***is a generic command to count lines, characters, words, etc*** 


# 3. You are in /home/jb/. Suppose this directory is empty. How do you create in only one command the whole path /home/jb/Work/Sequencing/ONT/?
mkdir -p Work/Sequencing/ONT/


# 4. How do you access the help on a given command, for instance the help on grep?
grep --help
man grep
apropos #**when you don't know which command exactly you want to get help on** 


# 5. Which command would you use in order to create an empty file in the current directory, let's say empty.txt? 
touch empty.txt
echo -n '' > empty.txt

# 5. Suppose your current working directory contains a file named seqs.txt. How do you rename this file into sequences.fasta? 
# Does this have any effect on the content of the file, and if yes, what does it do? No effect 
mv seqs.txt sequences.fasta


# 6. In Unix, how does the extension of a file (the part of the filename after the dot) matter? - tells you file type and sometimes content
#- It depends, can matter, so as to prevent corruption of files when listing with e.g *.txt / does not really matter anyways
#***the extension of a filename DOES NOT matter in Unix, it's a compulsory thing.*** 


# 7. In Unix, which command will *really* help you to determine the type of a file (i.e. its type of file content, 
# e.g. whether it is a jpeg-compressed image or a pdf file)?
file e.g file file.pdf


# 8. How can you create in a single command a file containing the contents "Hello, world!" and named universal_greeting.txt?
echo "Hello, world!" > universal_greeting.txt
#if you wish to append contents, you use >> sign
echo "Hello, world2!" >> universal_greeting.txt
#***the number of spaces between tokens on the commandline DOES NOT MATTER (as long as there is at least one)*** e.g
echo "Hello,    world!" #or
echo "Hello,  world"


# 9. What about creating the same file but with filename "universal greeting.txt" (the filename contains a space)?
echo "Hello world" > universal\ greeting.txt
echo "Hello world" > "universal greeting.txt"


# 10. How can you use the commandline (on whichever machine you are now, that is connected to the internet) 
# to download directly the file you can see on https://github.com/eanbit-rt/IntroductoryLinux-2019/blob/master/Data/nrf1_seq.fa ? 
# Be careful, you need to get the raw text file itself, not the full HTML page presenting it.
#Use the link <https://github.com/eanbit-rt/IntroductoryLinux-2019/blob/master/Data/nrf1_seq.fa> to navigate to the raw sequences

wget https://raw.githubusercontent.com/eanbit-rt/IntroductoryLinux-2019/master/Data/nrf1_seq.fa


# 11. How can you count the number of lines in this text file? How do you count the number of sequences?
wc -l nrf1_seq.fa
less nrf1_seq.fa | wc -l


#number of sequences
grep -c "^>" nrf1_seq.fa
grep -e "^>" nrf1_seq.fa | wc -l


# 12. Extract only the identifier lines from this file, and write them into a file called "identifiers.txt".
grep "^>" nrf1_seq.fa > identifiers.txt  


# 13. How to write a loop in Bash producing all the integers from 1 to 30, one per line?
for i in `seq 1 30`; do echo $i; done
for i in $(seq 1 30); do echo $i; done

#for a script
!bin/bash

for value in {1..30}
do
        echo $value
done


echo All done


# 14. Create a file called "trial1" and rename it into "trial1.data".
touch trial1; mv trial1 trial1.data


# 15. Create at once 20 files called "trial1" to "trial20" and *then* rename them all by appending the suffix ".data". 
# Of course, don't issue 20 commands, but just one.
for i in `seq 1 20`; do touch trial$i; done
touch trial{1..20}
#renaming
for filename in trial{1..20}; do mv $filename $filename.data; done
for filename in trial{1..20} ; do mv $filename ${filename}.data; done  #-most preferred (It is good practice to put variable names inside 
#curly braces)


# 16. In Bash, how do you redirect the output of a command so that it is not displayed on the screen but rather goes into a file?



# 17. Try this with the command "expr 1 / 0", whose purpose is to calculate the integer result of 1 divided by 0. What happens? Why?



# 18. How can you separately redirect the standard output and the standard error streams into two separate files?
expr 1 / 0 1> result 2> errors


# 19. How can you process the file you got from question 10 to replace all its uppercase "A" letters into lowercase "a" letters, 
# leaving the rest untouched? 
command "tr" for "translate"

tr 'A' 'a' < nrf1_seq.fa > newseqs.fa 



# 20. In one command, ask for the display of all identifier lines from the same file nrf1_seq.fa without wrapping the lines, 
# i.e. by having all lines displayed on your screen effectively start with the character '>'.
grep '^>' nrf1_seq.fa | less -S 
#or, if the identifiers.txt file is already created: 
less -S identifiers.txt 



# 21. Can you write a very short script (possibly one single commandline) to extract from the same file the species names?
grep ">" nrf1_seq.fa | sed 's/PREDICTED: //' | cut -d ' ' -f 2-3 > species_name.txt


# 22. Once this is done, how to count the species names with their order of multiplicity (i.e. how many sequences belong to Mus musculus, 
#how many to Homo sapiens, etc)? Collapse
#it sorts alphabetecally by default
grep '^>' nrf1_seq.fa | sed 's/PREDICTED: //' | cut -d ' ' -f 2-3 | sort | uniq -c > species_count.txt

#counts sort
sort -k1,1 species_count.txt
#numeric sort
sort -k1n,1 species_count.txt

#(22 bonus) 
sort -k1n,1r -k2,3 species_counts 
(that's after the result of question 22 is stored into the file species_counts 
the above sorting sorts first using the first field as a numerical field (option n) and in descending/reverse order 
(option r) 
... and then fields 2 and 3 are used to break ties, trhough alphabetical sorting in ascending order 