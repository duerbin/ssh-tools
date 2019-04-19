# Usage:
# source iterm2.zsh

# iTerm2 window/tab color commands
#   Requires iTerm2 >= Build 1.0.0.20110804
#   http://code.google.com/p/iterm2/wiki/ProprietaryEscapeCodes

BASE_PATH='/Users/dueb/github/codesummary/myshell/ssh-tools'
COLOR_ARR=($(awk '{print $2}' $BASE_PATH/color.dat))

function splitString()
{
    basestr=${COLOR_ARR[$1]}
    echo $basestr
    ((num=16#${basestr:0:2}))
    ((num1=16#${basestr:2:2}))
    ((num2=16#${basestr:4:2}))
}


function tabcolor() {
    echo -ne "\033]6;1;bg;red;brightness;$1\a"
    echo -ne "\033]6;1;bg;green;brightness;$2\a"
    echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}
function tabreset() {
    echo -ne "\033]6;1;bg;*;default\a"
}

function iterm2_tab_set_title() {
    echo "ttttt"
    echo $*
    echo $#
    echo $1
    if [ $# -eq 0 ];then
        echo -ne "\033]0;`pwd`\007";
    elif [ $# -eq 1 ];then
        if [ "$1" == "" ];then
            echo -ne "\033]0;nihao\007";
        else
            echo -ne "\033]0;nihao\007";
        fi
    else
        echo "Error: too many arguments."
    fi
}

# Change the color of the tab when using SSH
# reset the color after the connection closes
function colorssh() {
    if [[ -n "$ITERM_SESSION_ID" ]]; then
        trap "tabreset" INT EXIT
        #iterm2_tab_set_title "nihao"
        if [[ ${#COLOR_ARR[@]} -gt $*  ]]; then
            splitString $*
            tabcolor $num $num1 $num2
        else
            tabcolor 240 255 255
        fi
    fi
}

colorssh $*
