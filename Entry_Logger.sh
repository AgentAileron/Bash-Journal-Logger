#!/bin/bash
# Simple script to automate journal entry process
# Rithesh R Jayaram 2018
#---------------------------------------------------------------

# // Function to get time frame from date/time
GetTimeOfDay () {
	tvar_hours=`date -d "$1" +"%H"`	# Get just the hours from 24h time
	
	# Chained if statements, hooh boy... I'm sure there's a better way
	if 	 [ $tvar_hours -gt 22 ]
	then
		return="Late Night"
	elif [ $tvar_hours -gt 19 ]
	then
		return="Night"
	elif [ $tvar_hours -gt 16 ]
	then
		return="Evening"
	elif [ $tvar_hours -gt 13 ]
	then
		return="Afternoon"
	elif [ $tvar_hours -gt 11 ]
	then
		return="Midday"
	elif [ $tvar_hours -gt 8 ]
	then
		return="Morning"
	elif [ $tvar_hours -gt 6 ]
	then
		return="Early Morning"
	elif [ $tvar_hours -gt 3 ]
	then
		return="Very Early Morning"
	elif [ $tvar_hours -gt 0 ]
	then
		return="Very Late Night"
	else
		return="TIME ERR"
	fi
}


#---------------------------------------------------------------


var_dateTime=`date`				# Get current date+time

GetTimeOfDay "$var_dateTime"	# Get time of day
var_ToD=$return

read -p "Current loc: " var_loc	# Get current location (fuzzy)



echo $var_loc
echo $var_ToD
echo $var_dateTime