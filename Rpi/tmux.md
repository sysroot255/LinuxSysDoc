# Tmux

[Quick guide to tmux](https://www.hamvocke.com/blog/a-quick-and-easy-guide-to-tmux/)

[Remote Pair Programming Made Easy with SSH and tmux](https://www.hamvocke.com/blog/remote-pair-programming-with-tmux/)

# plugins

[airline](https://github.com/vim-airline/vim-airline)
[nerdtree](https://github.com/preservim/nerdtree)

# cheat sheet

```bash
Ctrl+b c Create a new window (with shell)
Ctrl+b w Choose window from a list
Ctrl+b 0 Switch to window 0 (by number )
Ctrl+b , Rename the current window
Ctrl+b $ Rename the current session
Ctrl+b % Split current pane horizontally into two panes
Ctrl+b "" Split current pane vertically into two panes
Ctrl+b o Go to the next pane
Ctrl+b ; Toggle between the current and previous pane
Ctrl+b x Close the current pane
Ctrl+b s show preview of all sessions
```

Attach et detach are used to let the session run.
Ctrl+b d detach from current session

Use tmux ls to see the tmux list

```bash
 $ tmux ls 
```

Sharing a tmux session

The simplest setup is using the exact same session with multiple tmux client instances. The following steps will get us there:
```bash
- Alice and Bob ssh into the same server
- Alice creates a new tmux sesssion: tmux new -s shared

- Bob connects to that session: tmux attach -t shared
- Bob leave the session: ctrl-b d
```

Please note that “shared” will be the name of the session, feel free to give it any name you like.

ctrl-b [ to navige into long content of ls -l /etc/
