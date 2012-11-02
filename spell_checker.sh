#spell checker that works on the basis of a dictionary file in the current directory named "dictionary". If the word is not present in the dictionary then sugestions will be given

#!/bin/bash

dictionary="dictionary"
word=$1

if [ ! -f $dictionary ]
	then
	echo ""ERROR: no dictionary file found....
	exit
fi

a=`cat dictionary`
#a=($a)

length=${#word}
len=$length
char=""

if test $len -eq 1
	then
	output=`cat dictionary | grep --word -i $word`
	if test ${#output} -eq 0
		then
		output=`cat dictionary | grep --word -i "[a-zA-Z]"`
		echo $output
	else
		echo "It is a dictionary word"
	fi	
	exit
fi

while test $[$len - 1] -ne 0
	do
	temp=`echo $word | cut -c 1-$len`
	if (( $len < $length ))
		then
		char=$char"[a-zA-Z]"
	fi

	temp=$temp"$char"
	output=`cat dictionary | grep --word -i $temp`

	if test ${#output} -ne 0 
		then
		if (( $len == $length ))
			then
			echo "It is a dictionary word"
		else
			echo $output
		fi
		break
	fi

	len=$[$len - 1]
done

exit
