#!/bin/bash
# Simple script to automate journal entry process
# Rithesh R Jayaram 2018 
#---------------------------------------------------------------

# // Function to get time frame from date/time
GetTimeOfDay () { 
	tvar_hours=`date -d "$1" +"%H"`	# Get just the hours from 24h time
	
	# Chained if statements, hooh boy... I'm sure there's a better way, maybe
	if 	 [ $tvar_hours -ge 22 ]
	then
		return="Late Night"
	elif [ $tvar_hours -ge 19 ]
	then
		return="Night"
	elif [ $tvar_hours -ge 16 ]
	then
		return="Evening"
	elif [ $tvar_hours -ge 13 ]
	then
		return="Afternoon"
	elif [ $tvar_hours -ge 11 ]
	then
		return="Midday"
	elif [ $tvar_hours -ge 8 ]
	then
		return="Morning"
	elif [ $tvar_hours -ge 6 ]
	then
		return="Early Morning"
	elif [ $tvar_hours -ge 3 ]
	then
		return="Very Early Morning"
	elif [ $tvar_hours -ge 0 ]
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
		elif [ $tvar_dateTimeDiff -gt 0 ]		# Less than an hour since last entry
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

# // Get all info needed for headers / filenames
var_datetime=`date`				# Get current date+time

GetTimeOfDay "$var_datetime"	# Get time of day
var_tod=$return

read -p "Current loc: " var_loc	# Get current location (fuzzy)

tvar_lastfile="\n\n\n"	# Basically a null placeholder
GetTimeSinceLastEntry "$var_datetime"	# Get time since last entry
var_sincelastentry=$return

# // Format the internal header for the final Journal file
var_finalheader="${var_datetime}\n"	# date and time
var_finalheader="${var_finalheader}// ${var_tod}, ${var_loc} //\n"
var_finalheader="${var_finalheader}-  ${var_sincelastentry} since last entry  -\n"
var_finalheader="${var_finalheader}\n===========================================================\n"

# // Format the title of the new file
if [ "$tvar_lastfile" != "\n\n\n" ]	# If a previous entry was found, use that index +1
then
	var_newindex=${tvar_lastfile:3:1}
	let "var_newindex++"
else									# If no previous entry exists, use index 1
	var_newindex=1
fi

tvar_fndate=`date -d "$var_datetime" +"%a %b %d %Y"`	# Special date format for filename
var_finalfilename="${var_newindex} - ${tvar_fndate} - ${var_tod}.txt"	# filename (may need to be changed)

# // Create file and insert generated header
while [ -f "../${var_finalfilename}" ]	# Just in case a collision occurs, increment again
do
	let "var_newindex++"
	var_finalfilename="${var_newindex} - ${tvar_fndate} - ${var_tod}.txt"
done

touch "../${var_finalfilename}"		# Create file
echo -e "$var_finalheader" > "../${var_finalfilename}"	# echo formatted header into file

# // Create a temporary file and open vim on it
tvar_tempfile=`mktemp --tmpdir=/tmp/`					# Make temp file
vim "${tvar_tempfile}"									# Open file in vim
cat "${tvar_tempfile}" >> "../${var_finalfilename}"		# Move contents into actual journal file
rm "${tvar_tempfile}"									# Remove temporary file

echo -e "Journal entry saved successfully in \"../${var_finalfilename}\""
