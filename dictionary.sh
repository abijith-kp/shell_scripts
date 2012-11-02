#This shell program creates a new file called dictionary from the given input-another text file. It collects all the words containing only alphabets and removes all the repatitions and sorts the words and redirects to the dictionary file

#In simple words , it creates a dictionary of words from the given input text file

#!/bin/bash

text=$1
dictionary="dictionary"

if [ ! -f $1 ]
	then
	echo "ERROR: No such file"
	exit
fi

if [ ! -f $dictionary ]
	then
	touch $dictionary
	exit
fi

echo "given input found...."
b=`cat $text`
echo "file read...."
b=($b)

echo "spliting all words fron the file...."
echo "removing all the repatitions...."

for i in ${b[@]}
	do 
	a=`cat $dictionary`
	a=($a)
	if echo "${a[@]}" | grep --word $i >> /dev/null
		then 
		continue
		else
		echo "$i" >> $dictionary 
	fi 
	done

echo "splitting finished...."

b=`cat $dictionary`
b=($b)

echo "removing all words having charactors other than alphabets(both capital and small....)"
for i in ${b[@]}
	do 
	if expr "$i" : "[A-Za-z]*$" >> /dev/null
	then 
	echo $i >>temp 
	fi 
	done

echo "sorting the dictionary..."
sort temp --output=$dictionary

rm temp

echo "temparory file is removed...."
echo "new file dictionary is created...."

exit
