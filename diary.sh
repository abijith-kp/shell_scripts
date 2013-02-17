# A application that simulates a simple diary. Initially it creates a configuration file 
# in ~/.diary/ directory. Then uses this template to create entries for different days.
# The arangement is done as:
#				- ~/.diary
#				|-++ <year1>
#                               |   |-++ <month>
#                               |   |    |-++ <day>
#                               |   |    |-++ <day>
#                               |   |    |-++ <day>
#                               |   |    |-++ <day>
#                               |   |-++ <month>
#                               |   |    |-++ <day>
#                               |   |    |-++ <day>
#                               |   |    |-++ <day>
#                               |   |-++ <month>
#                               |   |    |-++ <day>
#                               |   |    |-++ <day>
#                               |   |    |-++ <day>
#                               |-++ <year3>
#                               |   |-++ <month>
#                               |   |    |-++ <day>
#                               |   |-++ <month>
#                               |   |    |-++ <day>
#                               |   |-++ <month>
#                               |   |    |-++ <day>
#                               |-++ config


#!/bin/bash

starting="Author: Abijith K P\n"

home="/home/abijith/.diary"
day=`date +%A`
date=`date +%d`
month=`date +%B`
year=`date +%C%y`

main=`date +%r`
starting="\nAuthor: Abijith K P\n\n$main\n"
file="$home/$year/$month/$date"

if [ ! -d $home ]
        then
        mkdir "$home"
        fi

ls $home -R

if [ ! -f $home/config ]
	then
	echo "running first time...."
	read -p "Author name: " auth_name
	read -p "Author email: " auth_email
	read -p "Author phone: " auth_phone
	echo "creatind config file.... /home/user/.diary/config"
	echo "Author: "$auth_name > $home/config
	echo "Email ID: "$auth_emain >> $home/config
	echo "Phone no.: "$auth_name >> $home/config
	echo -e "\n" >> $home/config
	fi

if [ ! -d $home/$year/ ]
        then
	mkdir "$home/$year/"
        fi

if [ ! -d $home/$year/$month/ ]
        then
	mkdir "$home/$year/$month/"
        fi

if [ ! -f $home/$year/$month/$date ]
        then
	cp $home/config "$home/$year/$month/$date"
	echo -e $main"\n\n" >> $file
else
	echo -e "\n\n$main\n" >> $file
	fi

vi "$file" +
exit
