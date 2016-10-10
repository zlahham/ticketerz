#!/bin/bash

set -e # Exit on errors

if [ -n "$TMUX" ]; then
  export NESTED_TMUX=1
  export TMUX=''
fi

if [ ! $TICKETEE_DIR ]; then export TICKETEE_DIR=$HOME/Dropbox/projects/rails/rails4_in_action/ticketee; fi

cd $TICKETEE_DIR

tmux new-session  -d -s Ticketee
tmux set-environment -t Ticketee -g TICKETEE_DIR $TICKETEE_DIR

tmux new-window     -t Ticketee -n 'Web'
tmux send-key       -t Ticketee 'cd $TICKETEE_DIR'                  Enter 'rails s -p 3333'                       Enter

tmux new-window     -t Ticketee -n 'Console'
tmux send-key       -t Ticketee 'cd $TICKETEE_DIR'                  Enter 'rails c'    Enter

tmux new-window     -t Ticketee -n 'Guard'
tmux send-key       -t Ticketee 'cd $TICKETEE_DIR'                  Enter 'bundle exec guard'    Enter

tmux new-window     -t Ticketee -n 'VIM'
tmux send-key       -t Ticketee 'cd $TICKETEE_DIR'                  Enter 'vim .'                       Enter

if [ -z "$NESTED_TMUX" ]; then
  tmux -2 attach-session -t Ticketee
else
  tmux -2 switch-client -t Ticketee
fi
