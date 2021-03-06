# vi: set filetype=sh sw=4 ts=4 expandtab autoindent:
# To be sourced from user's .profile

# Run on first login
[[ -f ~/.pod/profiled ]] || {
    # Secrets
    [[ -f ~/.pod-secrets.gpg ]] && pod secrets decrypt

    # Projects
    [[ -f ~/.pod/args ]] && {
        echo "Processing pod args"

        # Clone projects
        mkdir -p ~/src
        cd ~/src
        for url in $(< ~/.pod/args); do
            echo Cloning $url
            git clone $url
        done
        cd
    }
    touch ~/.pod/profiled
    read -p "Pod initialised, press enter to start tmux..."
}

# Run on each login
# If we aren't under tmux, attach to existing session or create a new one
[[ -z $TMUX ]] && {
    if tmux has -t 0 &> /dev/null; then
        socket=$(echo $TMUX | cut -d, -f1)
        # tmux refuses to attach if too open, and we are messing with
        # perms from ./pairing
        chmod o-rwx $socket
    	tmux attach -d -t 0
    else
    	tmux new-session -s pod
    fi
}
