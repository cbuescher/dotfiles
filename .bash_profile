# import aliases
if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
fi

# include ~/bin in PATH
if [ -d ~/bin ]; then
        export PATH=$HOME/bin:$PATH
fi

# nicer iTerm tabs
if [ $ITERM_SESSION_ID ]; then
  export PROMPT_COMMAND='echo -ne "\033];${USER}@${HOSTNAME}\007"; ':"$PROMPT_COMMAND";
fi

# gitprompt
GIT_PROMPT_ONLY_IN_REPO=1

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export EDITOR=vim
export LANGUAGE="en_US.UTF-8"

# lolcommit delay
LOLCOMMITS_DELAY=60

#maven
export MAVEN_OPTS="-Xmx1024m"

#gradle
export GRADLE_OPTS="-Xms1024m -Xmx1024m"

#path
export PATH=.:/Users/christoph/Library/Python/2.7/bin:$GRADLE_HOME/bin:$M2:$PATH

#use git completions
source ~/scripts/git-completion.bash

#customize history 
export HISTFILESIZE=50000
export HISTSIZE=50000
export HISTCONTROL=erasedups
shopt -s histappend 

#source nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
#old export NVM_DIR=~/.nvm
#old source $(brew --prefix nvm)/nvm.sh


#test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
#!/bin/bash
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/christoph/.sdkman"
[[ -s "/Users/christoph/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/christoph/.sdkman/bin/sdkman-init.sh"

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
