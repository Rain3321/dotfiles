# colors
GREEN='\e[0;32m\]'
B_GREEN='\e[1;32m\]'
MAGENTA='\e[0;35m\]'
B_MAGENTA='\e[1;35m\]'
YELLOW='\e[0;33m\]'
B_YELLOW='\e[1;33m\]'
RED='\e[0;31m'
BLUE='\e[0;34m'
B_BLUE='\e[1;34m'
CYAN='\e[0;36m\]'
COLOR_END='\[\033[0m\]'

# PROMPT ----------------------------------------------------------------------
# PS1="\h:\W \u\$ "  # default promopt
function gbr {
    git status --short 2> /dev/null 1> /dev/null
    if [ "$?" -ne "0" ]; then
        return 1
    else
        branch="`git branch | grep '^\*' | cut -c 3-`"
        branch_str="\033[1;031m$branch\033[0m"

        stat=`git s \
            | awk '{print $1}' \
            | sort | uniq -c \
            | tr '\n' ' ' \
            | sed -E 's/([0-9]+) /\1/g; s/  */ /g; s/ *$//'`

        stash_size=`git stash list | wc -l | sed 's/ //g'`
        stash_icon=" \e[0;92m≡\033[0m"
        printf "[$branch_str]$stat$stash_icon$stash_size"
        return 0
    fi
}

export PS1="${MAGENTA}\$(date '+%Y-%m-%d-%a %VW') \
${B_YELLOW}\$(date +%T) \
${GREEN}\u \
${B_MAGENTA}\h \
${B_BLUE}\w \
${COLOR_END}\
\$(gbr)\n\$ "

alias ll='ls -al'
alias cl='clear'
alias ku='kubectl'
alias ws='cd ~/ws'
alias java-change='jenv local $(jenv versions | fzf)'
alias f='open .'
alias vim='nvim'
alias vi='nvim'
source /opt/homebrew/bin/fav.sh

# vdi alias

alias ext="open -n 'vmware-view://baro.gagi@vdi-ext.kakaopaycorp.net/'"
alias issue="open -n 'vmware-view://baro.gagi@vdi-issue.kakaopaycorp.net/'"

export PATH="$PATH:/Application/Visual Studio Code.app/Contents/Resources/app/bin"
export NODE_EXTRA_CA_CERTS="/Users/baro.gagi/Downloads/MenloSecurityCustomerRootCA.crt"
