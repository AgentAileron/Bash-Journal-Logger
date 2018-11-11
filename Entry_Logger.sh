#!/bin/bash
# Simple script to automate journal entry process
# Rithesh R Jayaram 2018
#---------------------------------------------------------------

# // Function to get time frame from date/time
GetTimeOfDay () {
	tvar_hours=`date -d "$1" +"%H"`	# Get just the hours from 24h time
	
	# Chained if statements, hooh boy... I'm sure there's a better way, maybe
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
		return="<TIME ERR>"
	fi
}

#---------------------------------------------------------------

# // Function to get time since last entry
GetTimeSinceLastEntry () {
	if ls ../*.txt 1> /dev/null 2>&1;
	then
		tvar_lastfile=`ls -t ../*.txt | head -n 1`			  # TODO: Sort by name, not date
		tvar_lastdate=`tail -n+1 "$tvar_lastfile" | head -n1`	# Get date / time from last entry made
		
		tvar_lastdate=`date -d "$tvar_lastdate" +"%s"`
		tvar_dateTimeDiff=`date -d "$1" +"%s"`
		tvar_dateTimeDiff=`expr "$tvar_dateTimeDiff" - "$tvar_lastdate"`
		
		if [ $tvar_dateTimeDiff -gt 31557600 ]		# Over a year since last entry
		then
			let "tvar_dateTimeDiff /= 31557600"
			return="over $tvar_dateTimeDiff year(s)"
		elif [ $tvar_dateTimeDiff -gt 86400 ]		# Over a day since last entry
		then
			let "tvar_dateTimeDiff /= 86400"
			return="$tvar_dateTimeDiff day(s)"
		elif [ $tvar_dateTimeDiff -gt 3600 ]		# Over an hour since last entry
		then
			let "tvar_dateTimeDiff /= 3600"
			return="$tvar_dateTimeDiff hour(s)"
		elif [ $tvar_dateTimeDiff -gt 3600 ]		# Less than an hour since last entry
		then
			return="less than an hour"
		else
			return="<TIME ERR>"
		fi
		
	else
		return="<FILE ERR>"	# When file cannot be found
	fi
	
}

#---------------------------------------------------------------

var_datetime=`date`				# Get current date+time

GetTimeOfDay "$var_dateTime"	# Get time of day
var_tod=$return

read -p "Current loc: " var_loc	# Get current location (fuzzy)

GetTimeSinceLastEntry "$var_datetime"	# Get time since last entry
var_sincelastentry=$return

