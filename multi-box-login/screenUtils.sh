#Screen Utils
#Simplifies working with Screen it expects that SESSION_NAME has been exported as an environment 

#Exit on evaluation of unset variable
set -o nounset

#define the return char
returnKey=`printf "\015"`;

#sets the sessionName
#Usage: setSessionName sessionName
setSessionName()
{
	sessionName=$1;
}

#Starts sceen in a detached state ready for commands to be pumped to it must pass sessionname
#Usage: createSession sessionName
createSession()
{
	setSessionName "$1";
	#Screen setup
	cp "${SCRIPT_DIRECTORY}/screenrc_detaching" "${SCRIPT_DIRECTORY}/tempScreenrc/.screenrc_detaching_with_sessionname";
	echo -e "\nsessionname $sessionName" >> "${SCRIPT_DIRECTORY}/tempScreenrc/.screenrc_detaching_with_sessionname"
	#Start screen detached with the correct sessionname
	screen -c "${SCRIPT_DIRECTORY}/tempScreenrc/.screenrc_detaching_with_sessionname"
	
	#There appears to be a bug (in cygwin) where the sessions is incorretly named if we do not create and  kill a window and then wipe
	# createWindow 1 temp;
	# killWindow 1;
	# screen -wipe;
}


#stuffs a command to screen takes the sessionname and windowname and then the command to execute
#You may use $returnKey to represtent pressing retun and thereby chain multiple commands together
#$returnKey is appended automatically so if entering one command it is nort required nor is it required at the end
#Usage: stuffCommandToWindow window(number or title) "command" 
stuffCommandToWindow()
{
	#echo " screen -r $sessionName -p $1 -X stuff $2";
	screen -r $sessionName -p $1 -X stuff "$2 $returnKey";
}

#sends a command to multiple windows in a screen takes the sessionname and windowlist(name or number, if specified as a sequence should use seq in backticks and then double quotes, if a plain list then just double quotes) and then the command to execute
#Usage: stuffCommandToWindows "`seq x y`" "command" 
stuffCommandToWindows() 
{
	for window in $1;
	do
		stuffCommandToWindow $window "$2";
	done
}

#Sets the window title
#Usage: setWindowTitle window title
setWindowTitle()
{
	screen -r $sessionName -p $1 -X title $2;
}

#Create a new window
#Usage: createWindow windowNumber title
createWindow()
{
	#echo "screen -r $sessionName -p $1 -X screen -t $2";
	screen -r $sessionName -p $1 -X screen -t "$2";
}

#Create new windows specify window numbers and titles
#Usage: createWindows "`seq x y`" "a b c d"
createWindows()
{
	unset TITLES;
	# read into an array (space is delimiter)
	read -ra TITLES <<< "$2"

	TITLES_INDEX=0;
	
	for windowNumber in $1;
	do
		createWindow $windowNumber "${TITLES[$TITLES_INDEX]}";
		let TITLES_INDEX++;
	done
}

#kill a window
#Usage: killWindow window(name or number)
killWindow()
{
	screen -r $sessionName -p $1 -X kill;
}

#All in the name
#Usage: createWindowAndSendCommnd windowNumber title command
createWindowAndSendCommand()
{
	createWindow $1 "$2";
	stuffCommandToWindow $1 "$3";
}

#All in the name
#Usage: createWindowsAndSendCommnds "`seq x y`"|"x .. y" "titles . . . " "command"
createWindowsAndSendCommands()
{
	unset TITLES;
	# read into an array (space is delimiter)
	read -ra TITLES <<< "$2"

	TITLES_INDEX=0;
	
	for windowNumber in $1;
	do
		createWindowAndSendCommnd $windowNumber "${TITLES[$TITLES_INDEX]}" "$3";
		let TITLES_INDEX++;
	done
}

#Sends any screen command to a window
#Usage: sendCommandToWindow window(number or title) "command" 
sendCommandToWindow()
{
	screen -r $sessionName -p "$1" -X $2;
}

#Generates a random filename for use with copying across bashrc files
#Attempts to produce something fairly unique
generateTempFileName()
{
	echo tempFile_rand${RANDOM}_`date '+%Y%m%d_%H.%M.%S'`;
}


#Checks if the given file exists in the target window
#Usage: window(name or number) filename
fileExists()
{
	stuffCommandToWindow "$1" "ls $2$returnKey echo \$?";
	sendCommandToWindow  "$1" "hardcopydir $HOME";
	sendCommandToWindow  "$1" "hardcopy -h fileCheckResults";
	
	#I use tac to read the file since default buffer size is 4096 and I dont want to read all that to find the result
	#get linenum of the echo command
	lineNum=`tac ~/fileCheckResults | grep -m 1 -n "echo \\$?" | perl -ne 'if ( m/^(\d+?)/ ) { print $1; }'`;
	#decrement  linenum since we are lookig at the file backwards (tac as opposed to cat)
	#so this is the number of the line with the result
	let lineNum--;
	
	result=`tac ~/fileCheckResults | head -"$lineNum" | tail -1 | perl -ne 'if ( m/^(\d+?)/ ) { print $1; }'`;
	
	#Remove temp file
	rm ~/fileCheckResults;
	
	return $result;
}

