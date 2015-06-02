#!/bin/bash

set -e;

#LIMITATIONS
#This script does not account for reactor poms that are not situated one directory up from their children
#or conversely module elements that contain paths other than simply submodule names

#This is the namespace wich we have to define for the poms and then subsequently have to use the x prefix for all xpath element names
#its a ball ache tat we cannot just ignore it but xmlstarlet is very picky, it also must be defined in this way so that its whole is not
#enclosed in quotes otherwise it will not be interpreted correctly by xmlstarlet
NS=x\='http://maven.apache.org/POM/4.0.0';

ensurePathHasTrialingSlashRemoved(){
	#Expands the parameter and deletes the ending forward slash if it exists
	echo ${1%/}
}

getTrailingPathSegment()
{
	#this expands the parameter but deletes everything up to the final forward slash, including the slash
	echo ${1##*/};
}

getPathMinusTrailingSegment()
{
	#this expands the parameter but deletes everything after the final forward slash including the slash itself
	echo ${1%/*};
}

getScriptName(){
	#$0 holds the path to the script
	getTrailingPathSegment "$0";
}


#We have to use the namespace directly otherwise the expansion by bash causes it to be misinterpreted
selectElement(){
	XML_FILE="${1}";
	XPATH="${2}";
	xmlstarlet sel -N ${NS} -t -v "${XPATH}" "${XML_FILE}";
}

updateElement(){
	XML_FILE="${1}";
	XPATH="${2}";
	NEW_VALUE="${3}";
	xmlstarlet ed --inplace -N ${NS} -u "${XPATH}" -v "${NEW_VALUE}" "${XML_FILE}";
}

deleteElement(){
	XML_FILE="${1}";
	XPATH="${2}";
	xmlstarlet ed --inplace -N ${NS} -d "${XPATH}" "${XML_FILE}";
}

insertElement(){
	 XML_FILE="${1}";
	 XPATH="${2}";
	 ELEMENT_NAME="${3}";
	 NEW_VALUE="${4}";
	 #-s "//x:dependency[x:groupId='javax.inject']" -t elem -n "newElem" -v "yoyoyoyoyoyo" pom.xml
	 xmlstarlet ed --inplace -N ${NS} -s "${XPATH}" -t elem -n "${ELEMENT_NAME}" -v "${NEW_VALUE}" "${XML_FILE}";
	 #xml ed -s /config -t elem -n sub -v "" -i /config/sub -t attr -n class -v com.foo test.xml
}


findNextParentFolderContainingPomFile(){
	PARENT_FOLDER_PATH=$(getPathMinusTrailingSegment ${1});

	while [[ ! -e "${PARENT_FOLDER_PATH}/pom.xml" ]]; do
		PARENT_FOLDER_PATH=$(getPathMinusTrailingSegment "${PARENT_FOLDER_PATH}");
	done
	echo "${PARENT_FOLDER_PATH}";
}

selectGroupId(){
	MODULE_PATH="${1}";
	GROUP_ID="";
	while [[ ${GROUP_ID} == "" ]]; do
		GROUP_ID=$(selectElement "${MODULE_PATH}/pom.xml" /x:project/x:groupId);
		MODULE_PATH=$(getPathMinusTrailingSegment "${MODULE_PATH}");
	done
	echo "${GROUP_ID}";
}

updateGroupIdForDependencies(){
	#For all poms update any dependency having the given artifact id with the new groupId
	GROUP_ID="${1}";
	ARTIFACT_ID="${2}";
	find . -name pom.xml | while read pomfile; do 
		updateElement "${pomfile}" "//x:dependency[x:artifactId=\"${ARTIFACT_ID}\"]/x:groupId" "${GROUP_ID}";
	done;
}

updateDefinedGroupId(){
		XML_FILE="${1}";
		GROUP_ID="${2}";
		updateElement "${XML_FILE}" "/x:project/x:groupId" "${GROUP_ID}";		
}

#Remove trailing slashes from the input paths if there are any
EXISTING_MODULE_PATH=$(ensurePathHasTrialingSlashRemoved "${1}");
echo "EXISTING_MODULE_PATH ${EXISTING_MODULE_PATH}";
NEW_MODULE_PATH=$(ensurePathHasTrialingSlashRemoved "${2}");
echo "NEW_MODULE_PATH ${NEW_MODULE_PATH}";
#Optional parameter
NEW_GROUP_ID="${3}";

if [[ -z "${EXISTING_MODULE_PATH}" || -z "${NEW_MODULE_PATH}" ]]; then
	echo "Usage: $(getScriptName) EXISTING_MODULE_PATH NEW_MODULE_PATH";
	exit 1;
fi

if [[ ! -d "${EXISTING_MODULE_PATH}" ]]; then
	echo "No directory found at at the EXISTING_MODULE_PATH:${EXISTING_MODULE_PATH} exiting!";
	exit 1;
fi

if [[ -d "${NEW_MODULE_PATH}" ]]; then
	echo "NEW_MODULE_PATH:${NEW_MODULE_PATH} already exists as a directory, exiting!";
	exit 1;
fi


OLD_ARTIFACT_ID=$(selectElement "${EXISTING_MODULE_PATH}/pom.xml" "/x:project/x:artifactId");
echo "OLD_ARTIFACT_ID ${OLD_ARTIFACT_ID}";

NEW_ARTIFACT_ID=$(getTrailingPathSegment "${NEW_MODULE_PATH}");
echo "NEW_ARTIFACT_ID ${NEW_ARTIFACT_ID}";

OLD_GROUP_ID=$(selectGroupId "${EXISTING_MODULE_PATH}");
echo "OLD_GROUP_ID ${OLD_GROUP_ID}";

#If the new group id is set then do the following
if [[ ! -z ${NEW_GROUP_ID} ]]; then
	echo "NEW_GROUP_ID ${NEW_GROUP_ID}";
fi

GROUP_ID_PATH_IN_REPOSITORY=$(echo ${OLD_GROUP_ID} | perl -p -i -e "s|\.|/|g");
echo "GROUP_ID_PATH_IN_REPOSITORY ${GROUP_ID_PATH_IN_REPOSITORY}";

#remove any module malarkey for parent module pom and add to new parent module pom
EXISTING_PARENT_MODULE_PATH=$(findNextParentFolderContainingPomFile ${EXISTING_MODULE_PATH});
echo "EXISTING_PARENT_MODULE_PATH ${EXISTING_PARENT_MODULE_PATH}";

NEW_PARENT_MODULE_PATH=$(findNextParentFolderContainingPomFile ${NEW_MODULE_PATH});
echo "NEW_PARENT_MODULE_PATH ${NEW_PARENT_MODULE_PATH}";

read -p "Press any key to continue or ctrl+c to exit . . .";

echo "Starting processing";

#If the new group id is set then do the following
if [[ ! -z ${NEW_GROUP_ID} ]]; then
	updateGroupIdForDependencies "${NEW_GROUP_ID}" "${OLD_ARTIFACT_ID}";
	#If the group id is not defined then insert it otherwise update it
	if [[ -z $(selectElement "${EXISTING_MODULE_PATH}/pom.xml" "/x:project/x:groupId") ]]; then
		insertElement "${EXISTING_MODULE_PATH}/pom.xml" "/x:project" "groupId" "${NEW_GROUP_ID}";
	else 
		updateDefinedGroupId "${EXISTING_MODULE_PATH}/pom.xml" "${NEW_GROUP_ID}";
	fi
fi

deleteElement "${EXISTING_PARENT_MODULE_PATH}/pom.xml" "/x:project/x:modules/x:module[contains(.,\"${OLD_ARTIFACT_ID}\")]";
insertElement "${NEW_PARENT_MODULE_PATH}/pom.xml" "/x:project/x:modules" "module" "${NEW_ARTIFACT_ID}";

#Replace all instances of the old module name in the poms
find . -name pom.xml | xargs perl -p -i -e "s|${OLD_ARTIFACT_ID}|${NEW_ARTIFACT_ID}|g";

#svn move the module
svn move "${EXISTING_MODULE_PATH}" "${NEW_MODULE_PATH}";

#Remove old artifact in repository to ensure that nothing is still pointing at it
rm -rf "${HOME}/.m2/repository/${GROUP_ID_PATH_IN_REPOSITORY}/${OLD_ARTIFACT_ID}";
