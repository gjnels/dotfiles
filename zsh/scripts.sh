#!/bin/bash


# compress a directory
compress() {
    tar cvzf $1.tar.gz $1
}



# choose tmuxp layout using fzf
ftmuxp() {
    # return if already in tmux session
    if [[ -n $TMUX ]]; then
        echo "Already in a tmux session. Nice try :)"
        return
    fi

    # get tmuxp layout names (removing .yml extension)
    ID="$(ls $XDG_CONFIG_HOME/tmuxp | sed -e 's/\.yml$//')"

    # start basic tmux session if no tmuxp layouts found
    if [[ -z "$ID" ]]; then
        tmux new-session
    fi

    msg="Create New Session"

    # get desired tmuxp layout
    ID="${msg}\n$ID"
    ID="$(echo $ID | fzf | cut -d: -f1)"

    if [[ "$ID" = "${msg}" ]]; then
        # chose to start new session
        tmux new-session
    elif [[ -n "$ID" ]]; then
        # load chosen tmuxp layout
        tmuxp load "$ID"
    fi

    # when nothing chosen (hitting ESC in fzf menu), script exits
}
