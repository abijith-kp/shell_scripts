#!/bin/bash 

home="http://www.ted.com/"
h="\-h"
search="search?cat=ss_talks&q="
s="\-s"
exit="exit"
text=""


function help()
	{
	   echo ---------- TED Video Downloader ----------
	   echo Valid options
	   echo	"		usage:  ted-dl [OPTIONS]"
	   echo "		example	ted-dl -s xyx"

	   echo "		-h			help"
	   echo "		-s			search(for talks)"
	}

function get_text()
	{
	  t=$text
	  text=""
	  i=0
	  for x in $t
	  	do
		if [ $i -eq 0 ]
			then
			text=$x
			i=1
			continue
		fi
		text=$text"+"$x
	  done
	}

#########################################################     program starts here     ##############################################################

if [ $# -eq 0 ] || [ $# -eq 1 ] && echo "$1" | grep "$h" > /dev/null 
	then
	help
fi



#-------------------------------------------------------     case of arguement "-s" ----------------------------------------------------------------
if echo "$1" | grep  "$s" > /dev/null
	then 
	text=${*:2}
	get_text   #to get the input in the required format

	echo $text
	i=1
	rm search* links n* temp
	t=""
	#for t in $text
	#	do
	#	if [ $i -eq 0 ]
	#		then
	#		temp=$t
	#		i=1
	#	else
	#		temp=$temp"+"$t
	#	fi
	#done

	#text=$temp
	echo "downloading is in progress"
	echo "please wait....."
	while((1)) 
		do 
		url="$home$search$text&page=$i"				
		wget -q $url
		if cat search* | grep -i "no results found" > /dev/null 
			then
			break
		fi
		echo "$(cat "$search$text&page=$i" | grep "<h5 class=")" >> new_file
		rm "$search$text&page=$i"
		i=` expr $i + 1 `
		done

	echo "$(cat new_file | grep -o "http.*.html")" > links
	#cat links
	echo "$(awk 'BEGIN { FS="/talks/" } { print $2 }' links)" > temp
	echo "$(awk 'BEGIN { FS=".html" } { print $1 }' temp)" > temp 
	echo "$(awk 'BEGIN{FS="_";OFS=" "} { $1=$1;print $0 }' temp)" > names

	echo "[==============================================================================================================]100%"
	echo "results are....."
	
	echo "---------------------------------------------------------------------------------------"
	i=1;
	name=($names)
	cat names | while read text
		do
		#wget --spider $(cat links | head -n$i | tail -n1) -o x
		#x1=($(cat x | head -n3 | tail -n1))
		echo $i $text #${x1[2]}
		#rm x
		i=` expr $i + 1 `
		done

	echo "---------------------------------------------------------------------------------------"
	
	while ((1))
	do
		read -p ">>enter the option: " option 

		if echo "$option" | grep "$exit" > /dev/null
			then
			break
		fi

		if [ -z $option ]
        	then
			continue
        fi

		if echo "$(cat names)" | head -n$option | tail -n1 > /dev/null
			then
			link=$(cat links | head -n$option | tail -n1)
			rm *talks*
			wget -q $link
			
			b=$(cat *.html | grep -o "http.*.mp4")
			echo "downloading video.... please wait...."
			wget -q $b
			echo "video downloaded...."
			#if [ -d "Downloads" ]
		else
			echo "wrong option..."
		fi
	done
fi
#---------------------------------------------------------------------------------------------------------------------------------------------------
exit
