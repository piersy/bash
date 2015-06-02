#!/bin/bash

#Strict mode
set -e;

#Usage multiBoxLogin sessionName boxname boxname boxname


#Get the directory that this file is in
SCRIPT_DIRECTORY=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

export SCRIPT_DIRECTORY=${SCRIPT_DIRECTORY};
echo "${SCRIPT_DIRECTORY}/screenUtils.sh";
source "${SCRIPT_DIRECTORY}/screenUtils.sh";


SESSION_NAME=${1};

createSession ${SESSION_NAME};

setWindowTitle 0 "Local"

windowNumber=1;
# Iterate over positional parameters starting at 2
for boxname in "${@:2}"; do
	echo "createWindowAndSendCommand ${windowNumber} ${boxname} \"ssh ${boxname}\";"
	createWindowAndSendCommand ${windowNumber} ${boxname} "ssh ${boxname}";
	(( windowNumber+=1 ))
done

screen -r;

