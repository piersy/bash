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
export PS1="$white[$yellow\$(date +%H:%M)$white]$green\u$white@$red\h$white:$cyan\w $GREEN\$(__git_ps1 '[%s]')$cyan
$ $NC"
}

#export FLEX_HOME="/cygdrive/c/Flex/Flex4.1"
#export FLEX_HOME="/cygdrive/c/Flex/flex_sdk_4.0.0.14159A"
#export FLASH_PATH="/cygdrive/c/FlashPlayer"
export M2_HOME="/home/piers/programs/apache-maven-3.2.2"
export M2="$M2_HOME/bin"
export JAVA_7_HOME="/usr/lib/jvm/java-7-openjdk-amd64"
export JAVA_6_HOME="/usr/lib/jvm/jdk1.6.0_26_oracle"
export JAVA_8_HOME="${HOME}/dev/jdk1.8.0_60"
export JAVA_HOME=${JAVA_8_HOME};
export MONGO="/home/piers/programs/mongodb-linux-x86_64-2.4.9"
export EDITOR='vim';
#export GIT_HOME="/cygdrive/c/Program Files (x86)/Git"
#export SBT_PATH="/cygdrive/c/Program Files (x86)/sbt"

#export GRADLE_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5006"

export EB_HOME="/home/piers/programs/ElasticBeanstalkCommandLineTool/AWS-ElasticBeanstalk-CLI-2.6.3/eb/linux/python2.7";

export PATH=$M2:$JAVA_6_HOME/bin:${HOME}/multi-box-login:${HOME}/maven:~/dev/scripts/Loginscripts:~/dev/scripts/legacy-webapps:${MONGO}/bin:$EB_HOME:$PATH


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
	#go install location
	export GOROOT="${HOME}/dev/go";
	#the go binaries needbe on path so tha 
	export PATH="$PATH:$GOROOT/bin";
    #There are a few scripts located here which are usefull to have on the path
#	export PATH="${PATH}:/home/piers/dev/vimgobins/bin/";
    export YOTI_BACKEND="${HOME}/dev/projects/yoti-backend";
    #Vagrant settings vagrant used for kube environment
    export VAGRANT_DEFAULT_PROVIDER=virtualbox
    
    #Settings for use with the vagrant-vms project running kube
    #Nodes are the workers for kubernetes
    #export NUM_NODES="1";
    #Masters are the management box for kube clusters
    #export NUM_MASTERS="1";
}


#Define aliases here
aliases()
{
	#My Aliases

	#Quickly see all my processes
	alias myprocs='ps -fu $USER'
	alias ack='ack-grep';
	alias ..='cd ..'
	alias la='ls -Al' # show hidden files

	alias workspace='cd  ${WORKSPACE}';	
	alias scripts='cd  ${HOME}/dev/scripts';
	alias projects='cd  ${HOME}/dev/projects';
	alias dev='cd  ${HOME}/dev/'
	alias ipass='cd  ${HOME}/dev/legacy-projects/ipass-server';
	alias magazine-service='cd  ${HOME}/dev/projects/magazine-service';
	alias documents='cd  ${HOME}/Documents';
	alias logs='cd  ${HOME}/dev/logs';

    #yoti-backend aliases
	alias lt='Ylogtail';
	alias yl='Ylog';
	alias bs='buildServicesInDocker.sh';
	alias ds='deployServicesInDocker.sh';

    #Ensures all vim keypresses are logged to this file
    #then i can review it to find out my most used shortcuts
    #alias vim='vim -w ~/.vim/keylog'
    #git aliases        
	alias gk='git checkout';


	#Screen aliases
	alias scr='screen -r';
	alias sls='screen -ls';
	alias swipe='screen -wipe';
	alias redshift='redshift -l 51.5:-0.3';
	alias jps='jps -lm';
	alias rm='rm -v';
	alias d='docker';
	alias vimgo='vim -u ~/.vimrc.go';
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

	
	#Larger Bash History lines - these settings now defunct, see below
	#export HISTSIZE=100000
	#export HISTFILESIZE=100000
	
    # Eternal bash history.
    # ---------------------
    # Undocumented feature which sets the size to "unlimited".
    # http://stackoverflow.com/questions/9457233/unlimited-bash-history
    export HISTFILESIZE=
    export HISTSIZE=
    export HISTTIMEFORMAT="[%F %T] "
    # Change the file location because certain bash sessions truncate .bash_history file upon close.
    # http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
    export HISTFILE=~/.bash_eternal_history
    # Force prompt to write history after every command.
    # http://superuser.com/questions/20900/bash-history-loss
    PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

	#Append history to the hist file at end of session rather than overwrite
	#shopt -s histappend

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

	#bind f2 to git status
	bind '"\eOQ":"git status\n"'

	#bind f3 to ls -alh
	bind '"\eOR":"ls -alh\n"'

	#bind ctrl+up to cd ..
	bind '"\e[1;5A":"cd ..\n"'

    #bind f4 to git branch -a
    bind '"\eOS":"git branch -a\n"'

    #bind f5 to git diff
    bind '"\e[15~":"git diff\n"'

    #bind f6 to git commit
    bind '"\e[17~":"git commit --verbose --reedit-message=HEAD --reset-author\n"'

    #bind f9 to git cd -
    bind '"\e[20~":"cd -\n"'

    #bind alt+§ to fg
    bind '"\e§":"fg\n"'

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

# Automatically add completion for all aliases to commands having completion functions
function alias_completion {
    local namespace="alias_completion"

    # parse function based completion definitions, where capture group 2 => function and 3 => trigger
    local compl_regex='complete( +[^ ]+)* -F ([^ ]+) ("[^"]+"|[^ ]+)'
    # parse alias definitions, where capture group 1 => trigger, 2 => command, 3 => command arguments
    local alias_regex="alias ([^=]+)='(\"[^\"]+\"|[^ ]+)(( +[^ ]+)*)'"

    # create array of function completion triggers, keeping multi-word triggers together
    eval "local completions=($(complete -p | sed -Ene "/$compl_regex/s//'\3'/p"))"
    (( ${#completions[@]} == 0 )) && return 0

    # create temporary file for wrapper functions and completions
    rm -f "/tmp/${namespace}-*.tmp" # preliminary cleanup
    local tmp_file; tmp_file="$(mktemp "/tmp/${namespace}-${RANDOM}XXX.tmp")" || return 1

    local completion_loader; completion_loader="$(complete -p -D 2>/dev/null | sed -Ene 's/.* -F ([^ ]*).*/\1/p')"

    # read in "<alias> '<aliased command>' '<command args>'" lines from defined aliases
    local line; while read line; do
        eval "local alias_tokens; alias_tokens=($line)" 2>/dev/null || continue # some alias arg patterns cause an eval parse error
        local alias_name="${alias_tokens[0]}" alias_cmd="${alias_tokens[1]}" alias_args="${alias_tokens[2]# }"

        # skip aliases to pipes, boolean control structures and other command lists
        # (leveraging that eval errs out if $alias_args contains unquoted shell metacharacters)
        eval "local alias_arg_words; alias_arg_words=($alias_args)" 2>/dev/null || continue
        # avoid expanding wildcards
        read -a alias_arg_words <<< "$alias_args"

        # skip alias if there is no completion function triggered by the aliased command
        if [[ ! " ${completions[*]} " =~ " $alias_cmd " ]]; then
            if [[ -n "$completion_loader" ]]; then
                # force loading of completions for the aliased command
                eval "$completion_loader $alias_cmd"
                # 124 means completion loader was successful
                [[ $? -eq 124 ]] || continue
                completions+=($alias_cmd)
            else
                continue
            fi
        fi
        local new_completion="$(complete -p "$alias_cmd")"

        # create a wrapper inserting the alias arguments if any
        if [[ -n $alias_args ]]; then
            local compl_func="${new_completion/#* -F /}"; compl_func="${compl_func%% *}"
            # avoid recursive call loops by ignoring our own functions
            if [[ "${compl_func#_$namespace::}" == $compl_func ]]; then
                local compl_wrapper="_${namespace}::${alias_name}"
                    echo "function $compl_wrapper {
                        (( COMP_CWORD += ${#alias_arg_words[@]} ))
                        COMP_WORDS=($alias_cmd $alias_args \${COMP_WORDS[@]:1})
                        (( COMP_POINT -= \${#COMP_LINE} ))
                        COMP_LINE=\${COMP_LINE/$alias_name/$alias_cmd $alias_args}
                        (( COMP_POINT += \${#COMP_LINE} ))
                        $compl_func
                    }" >> "$tmp_file"
                    new_completion="${new_completion/ -F $compl_func / -F $compl_wrapper }"
            fi
        fi

        # replace completion trigger by alias
        new_completion="${new_completion% *} $alias_name"
        echo "$new_completion" >> "$tmp_file"
    done < <(alias -p | sed -Ene "s/$alias_regex/\1 '\2' '\3'/p")
    source "$tmp_file" && rm -f "$tmp_file"
} 

######################### - Run The Shit! - ###################################
#Set the termial type, used to be vt100 turns out that it does't support colors properly
export TERM=xterm-256color
#Export variables
variables;
#Define aliases
aliases;
# set a fancy prompt
loginprompt;
#set bash options
bashopts
#Enable custum key bindings
bindings;
#source the yoti-backend initialise script as we allways work within it
source "${YOTI_BACKEND}/initialise.sh"
#Add bash completion for aliases
alias_completion;



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
	find . -name "$@" 2>/dev/null;
}

iqf()
{
	find . -iname "$@" 2>/dev/null;
}

findInRepo()
{
	svn ls -R --depth infinity ${REPO} | grep "${1}";
}

countLinesOfJava(){
	find -name "*.java" -exec bash -c 'cat $1 | wc -l' - {} \; | awk '{s+=$1} END {print s}';
}

stopalldocker(){
	docker stop $(docker ps -q);
}

stopalldockerAsync(){
	for container in $(docker ps -q); do
		docker stop $container &
	done
}

removealldocker(){
	docker rm $(docker ps -a -q);
}

cleandockerimages(){
	docker rmi $(docker images | grep "^<none>" | awk '{print $3}');
}

setgopath(){
	export GOPATH=$(pwd);
    export PATH="${GOPATH}/bin:${PATH}";
}

#usage: new-session [-AdDP] [-F format] [-n window-name] [-s session-name] [-t target-session] [-x width] [-y height] [command]
#A more advanced con=mmand for later
# tmux send-keys -t "$pane" C-z 'some -new command' Enter
tux-kube(){
(
cd ~/dev/kubediffs
if ! tmux has-session -t kube; then
    tmux new-session -d -s kube
    tmux rename-window -t kube VimKubeDiffs
    tmux send -t kube:VimKubeDiffs vim ENTER
    bk #switch to backend
    tmux new-window -t kube -n Vim
    tmux send -t kube:Vim vim ENTER
    tmux new-window -t kube -n Build
    tmux new-window -t kube -n SshMaster
    tmux new-window -t kube -n SshNode
    tmux new-window -t kube -n pod
fi
tmux -2 attach-session -d -t 'kube'
)
}

tux-working-kube(){
(
cd ~/dev/kubediffs
if ! tmux has-session -t working-kube; then
    tmux new-session -d -s working-kube
    tmux send -t working-kube.0 vim ENTER
    tmux rename-window -t working-kube.0 VimKubeDiffs
    cd ~/dev/kubernetes
    tmux new-window -t working-kube -n Build
    tmux new-window -t working-kube -n SshMaster
    tmux new-window -t working-kube -n SshNode
    tmux new-window -t working-kube -n pod
fi
tmux -2 attach-session -d -t 'working-kube'
)
}

#Useful one liners to make into functions one day

#Subtitute words in files 
#find . -name "*.go" |  xargs perl -p -i -e  's|FoundWord|ReplacementWord|'


#print the captured bit
#perl -ne 'm|local.pages.root=(.*)| &&  print "$1";' piers.properties

#grep the disk as a file finding the given text and the preceeding and following 300 lines of context 
#sudo grep -B300 -A300 'export GOPATH="$MAIN_GOPATH:$PERSONAL_GOPATH"' /dev/sda7 > file2.txt

# grep inside find
#find . -name  "*.go" -exec grep -H '10.0.0.214' '{}' \;

#Find multiple files in multiple directories
#find /usr/lib /usr/local/lib -type f \( -name "libtesseract.a" -o -name "liblept.a" -o -name "libjpeg.a" -o -name "libtiff.a" -o -name "libpng.a" -o -name "libz.a" -o -name "libm.a" -o -name "libstdc++.a" \)
