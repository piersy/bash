# To the extent possible under law, the author(s) have dedicated all 
# copyright and related and neighboring rights to this software to the 
# public domain worldwide. This software is distributed without any warranty. 
# You should have received a copy of the CC0 Public Domain Dedication along 
# with this software. 
# If not, see <http://creativecommons.org/publicdomain/zero/1.0/>. 

# base-files version 4.0-9

# ~/.bash_profile: executed by bash(1) for login shells.

# The latest version as installed by the Cygwin Setup program can
# always be found at /etc/defaults/etc/skel/.bash_profile

# Modifying /etc/skel/.bash_profile directly will prevent
# setup from updating it.

# The copy in your home directory (~/.bash_profile) is yours, please
# feel free to customise it to create a shell
# environment to your liking.  If you feel a change
# would be benifitial to all, please feel free to send
# a patch to the cygwin mailing list.

# User dependent .bash_profile file

# Set user-defined locale
#export LANG=$(locale -uU)

# Set PATH so it includes user's private bin if it exists
# if [ -d "${HOME}/bin" ] ; then
#   PATH="${HOME}/bin:${PATH}"
# fi

# Set MANPATH so it includes users' private man if it exists
# if [ -d "${HOME}/man" ]; then
#   MANPATH="${HOME}/man:${MANPATH}"
# fi

# Set INFOPATH so it includes users' private info if it exists
# if [ -d "${HOME}/info" ]; then
#   INFOPATH="${HOME}/info:${INFOPATH}"
# fi

# Set colors :
red='\[\033[0;31m\]'
RED='\[\033[1;31m\]'
green='\[\033[0;32m\]'
GREEN='\[\033[1;32m\]'
yellow='\[\033[0;33m\]'
YELLOW='\[\033[1;33m\]'
blue='\[\033[0;34m\]'
BLUE='\[\033[1;34m\]'
magenta='\[\033[0;35m\]'
MAGENTA='\[\033[1;35m\]'
cyan='\[\033[0;36m\]'
CYAN='\[\033[1;36m\]'
white='\[\033[0;37m\]'
WHITE='\[\033[1;37m\]'
NC='\[\033[0m\]' # No Color

#can't indent here since it actually affects the prompt!
loginprompt()
{
export PS1="$white[$yellow\$(date +%H:%M)$white]$green\u$white@$red\h$white:$cyan\w
$ $white"
}

#export FLEX_HOME="/cygdrive/c/Flex/Flex4.1"
#export FLEX_HOME="/cygdrive/c/Flex/flex_sdk_4.0.0.14159A"
#export FLASH_PATH="/cygdrive/c/FlashPlayer"
export M2_HOME="/home/piers/programs/apache-maven-3.2.2"
export M2="$M2_HOME/bin"
export JAVA_7_HOME="/usr/lib/jvm/java-7-openjdk-amd64"
export JAVA_6_HOME="/usr/lib/jvm/jdk1.6.0_26_oracle"
export JAVA_8_HOME="/usr/lib/jvm/java-8-oracle"
export JAVA_HOME=${JAVA_8_HOME};
export MONGO="/home/piers/programs/mongodb-linux-x86_64-2.4.9"
#export GIT_HOME="/cygdrive/c/Program Files (x86)/Git"
#export SBT_PATH="/cygdrive/c/Program Files (x86)/sbt"

#export GRADLE_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5006"

export EB_HOME="/home/piers/programs/ElasticBeanstalkCommandLineTool/AWS-ElasticBeanstalk-CLI-2.6.3/eb/linux/python2.7";

CURRENT_ABSOLUTE_DIR="$(pwd)";

export PATH=$M2:$JAVA_6_HOME/bin:${CURRENT_ABSOLUTE_DIR}/multi-box-login:${CURRENT_ABSOLUTE_DIR}/maven:~/dev/scripts/Loginscripts:~/dev/scripts/legacy-webapps:${MONGO}/bin:$EB_HOME:$PATH


variables()
{
	export MVN="mvn clean install -ff";
	export MVNX="mvn clean install -ff -X";
	export JAVA_DEBUG="-Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8000";
	export ORIGINAL_MAVEN_OPTS="-Djava.awt.headless=false -Xmx2048m -Xms1024m -XX:MaxPermSize=1024m -Dmaven.buildNumber.doCheck=false -DconfigurationReport=true";
	export MAVEN_OPTS="-Djava.awt.headless=false -Xmx2048m -Xms1024m -XX:MaxPermSize=1024m -Dmaven.buildNumber.doCheck=false -DconfigurationReport=true";
	export SMALL_MEM_MAVEN_OPTS="-Djava.awt.headless=false -Xmx1024m -Xms128m -XX:MaxPermSize=512m -Dmaven.buildNumber.doCheck=false -DconfigurationReport=true";
	export WORKSPACE="~/dev/workspace";
	export REPO="svn+ssh://svn@svn.aptusinteractive.com/svn/";
	export ANDROID_HOME="/home/piers/dev/android-sdk-linux-r23.0.2";
	#Go workspace
	export MAIN_GOPATH="$HOME/dev/go"
	export PERSONAL_GOPATH="$HOME/dev/personal/go"
	export GOPATH="$MAIN_GOPATH:$PERSONAL_GOPATH"
	#for convenience add compiled go programs to path
	export PATH="$PATH:$MAIN_GOPATH/bin:$PERSONAL_GOPATH/bin"
	#go install location
	export GOROOT="/usr/local/go"
	#the go binaries needbe on path so tha 
	export PATH="$PATH:$GOROOT/bin"
}


#Define aliases here
aliases()
{
	#My Aliases

	#Quickly see all my processes
	alias myprocs='ps -fu $USER'
	
	alias ..='cd ..'
	alias la='ls -Al' # show hidden files

	alias workspace='cd  ${WORKSPACE}';	
	alias scripts='cd  ${HOME}/dev/scripts';
	alias projects='cd  ${HOME}/dev/projects';
	alias lampkicking='cd ${HOME}/dev/go/src/github.com/lampkicking'
	alias dev='cd  ${HOME}/dev/'
	alias gosrc='cd ${HOME}/dev/go/src'
	alias ipass='cd  ${HOME}/dev/legacy-projects/ipass-server';
	alias magazine-service='cd  ${HOME}/dev/projects/magazine-service';
	alias documents='cd  ${HOME}/Documents';
	alias logs='cd  ${HOME}/dev/logs';
        
	#Screen aliases
	alias scr='screen -r';
	alias sls='screen -ls';
	alias swipe='screen -wipe';
	alias redshift='redshift -l 51.5:-0.3';
	alias jps='jps -lm';
	alias rm='rm -v';
	alias d='docker';
	#Consider using this method
	#alias rm='mv -t /root/MyTrash/'

}

bashopts()
{
	#Commenting out the following till I can see what it does

	# Set up bash only settings
	#if [ `echo $SHELL` == "/usr/local/bin/bash" -o "/bin/bash" ]; then
	#shopt -s cdspell
	#shopt -s extglob
	#shopt -s dotglob
	#shopt -s cmdhist
	#shopt -s lithist
	#shopt -s progcomp
	#shopt -s checkhash
	#shopt -s histreedit
	#shopt -s promptvars
	#shopt -s cdable_vars
	#shopt -s checkwinsize
	#shopt -s hostcomplete
	#shopt -s expand_aliases
	#shopt -s interactive_comments

	bind 'set show-all-if-ambiguous on' # Tab once for complete
	bind 'set visible-stats on' # Show file info in complete

	
	#Larger Bash History lines
	export HISTSIZE=100000
	export HISTFILESIZE=100000
	
	#Append history to the hist file at end of session rather than overwrite
	shopt -s histappend

	#Append commands immediately to the histfile, giving a global history over sessions
	#PROMPT_COMMAND='$PROMPT_COMMAND; history -a; history -n'
	
	#Remove duplicates from the history
	export HISTCONTROL=erasedups

	# Set VI as default editor
	#export EDITOR=vi
}

#Extra key bindings commented out ones seem to be enabled by default on ubuntu
bindings()
{
	#bind ctrl+left back one word
#	bind '"\eOD": backward-word'
	
	#bind ctrl+right forward one word
#	bind '"\eOC": forward-word'
	
	#bind alt+up back one word
#	bind '"\e\e[A": backward-word'
	
	#bind alt+down forward one word
#	bind '"\e\e[B": forward-word'
	
	#Bind alt+left backward kill  word
	bind '"\e[1;3D": backward-kill-word'

	#Bind alt+right forward kill word
	bind '"\e[1;3C": kill-word'
	
	#bind home to beginning of line
#	bind '"\e[1~": beginning-of-line'
	
	#bind end to end of line
#	bind '"\e[4~": end-of-line'
	
	#Bind alt+home kill line back
	#bind '"\eOH":unix-line-discard'
	
	#Bind alt+end kill line forward
	#bind '"\eOF":kill-line'
}


######################### - Run The Shit! - ###################################
#Set the termial type
export TERM=vt100
#Define aliases
aliases;
#Export variables
variables;
# set a fancy prompt
loginprompt;
#set bash options
bashopts
#Enable custum key bindings
bindings;




###################  - Define Custom Functions - #########################

#mkdir and change to it
mcd(){
	mkdir "${1}" && cd "${1}";
}

notify()
{
	echo -en "\007"
}

m()
{
	mvnLogName=MavenLog_`date +%F`;
	${MVN} ${@} | tee ~/${mvnLogName};
	if [ $? != 0 ]
	then
		cp ~/${mvnLogName} ~/${mvnLogName}_Fail
	fi
}

mx()
{
	m ${@} -X;	
}

mn()
{
	m ${@};
	notify;
}

mnx()
{
	mn ${@} -X;
}

debugOn()
{
	export MAVEN_OPTS="${MAVEN_OPTS} ${JAVA_DEBUG}";
}

debugOff()
{
	export MAVEN_OPTS="-Djava.awt.headless=false -Xmx2048m -Xms256m -XX:MaxPermSize=1024m";
}

md()
{
	(
	set -e;
	debugOn;
	m ${@};
	)
	
}

mnd()
{
	(
	set -e;
	debugOn;
	mn ${@};
	)
}

fastBuild()
{
	(set -e; resources; m 2>&1 > ~/resourceslog; (set -e; client; m 2>&1 > ~/clientlog & server; m 2>&1 > ~/serverlog & wait); acceptance-tests; m 2>&1 > ~/acceptance-testslog);
	cat ~/resourceslog ~/clientlog ~/serverlog ~/acceptance-testslog > ~/fastBuildlog;
	rm ~/resourceslog ~/clientlog ~/serverlog ~/acceptance-testslog;
	notify;
}  

aFastBuild()
{
	(set -e; aresources; m > ~/aresourceslog; (set -e; aclient; m > ~/aclientlog & aserver; m > ~/aserverlog & wait); aacceptance-tests; m > ~/aacceptance-testslog);
	cat ~/aresourceslog > ~/afastBuildlog;
	cat ~/aclientlog >> ~/afastBuildlog;
	cat ~/aserverlog >> ~/afastBuildlog;
	cat ~/aacceptance-testslog >> ~/afastBuildlog;
	
	rm ~/aresourceslog ~/aclientlog ~/aserverlog ~/aacceptance-testslog;
	notify;
}  

rebuildResources()
{
	(resources; m; server; m -DskipTests); notify;
}

sb2()
{
	sublime-text-2 ${@} &
}

qf()
{
	find . -name $1;
}

iqf()
{
	find . -iname $1;
}

findInRepo()
{
	svn ls -R --depth infinity ${REPO} | grep "${1}";
}

countLinesOfJava(){
	find -name "*.java" -exec bash -c 'cat $1 | wc -l' - {} \; | awk '{s+=$1} END {print s}';
}

makeNewRemotGitBranch(){
	git push origin origin:refs/heads/${1}
}

#Useful one liners to make into functions one day

#print the captured bit
#perl -ne 'm|local.pages.root=(.*)| &&  print "$1";' piers.properties