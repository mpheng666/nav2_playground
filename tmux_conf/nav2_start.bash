#!/bin/bash

tmux has-session -t nav2_start
if [ $? != 0 ]; then
    # create a new session
    tmux new-session -s nav2_start -n nav2_start -d

    # use mouse in Ubuntu 16/tmux 2.1
    tmux set -g mouse on

    # Highlight active window
    tmux set-window-option -g window-status-current-bg green

    # history limit
    tmux set -g history-limit 10000

    # Set status bar
    tmux set -g status-bg black
    tmux set -g status-fg white 

    # to enable mouse copy/paste to system buffer
    # to copy text, go to the any window and press this sequence
    #     C-b [
    # now you are in VI mode, use the arrow keys and move to the start of text to copy
    # To select the text, press the key 'v'
    # Continue moving using the arrow keys to highlight the text to copy
    # To copy the text, press the 'y' key
    # Now your highlighted text is in system clipboard, can just use ctrl-V to paste into text editor
    # if you want to paste to another tmux buffer, press this sequence
    #     C-b ]
    tmux setw -g mode-keys vi
    tmux bind-key -t vi-copy 'v' begin-selection
    tmux bind-key -t vi-copy 'y' copy-pipe "xclip -sel clip -i"

    # roscore
    tmux send-keys -t nav2_start ''
    tmux select-layout tiled

    # mobile
    tmux split-window -v -t nav2_start
    tmux send-keys -t nav2_start '' C-m
    tmux select-layout tiled

    tmux split-window -h -t nav2_start
    tmux send-keys -t nav2_start '' 
    tmux select-layout tiled

fi
tmux attach -t nav2_start