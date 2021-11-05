# How to Create a Bash Alias

1. Open your .bashrc file

Using a text editor, open your .bashrc file, which is typically found in your home directory.

> vim ~/.bashrc

### Why .bashrc?

This file is loaded whenever a new bash instance is started and should included bash-specific commands, like aliases.

2. Create the alias

The anatomy of an alias is as follows:

> alias alias_name="text to alias"

Here is a common example:

> alias ll="ls -lha"

This means that whenever you type ll, it will be as if you had typed ls -lha.

It is basically a substitution, so if you have an alias set up like this: alias g="git". Then you can type g pull, which will execute git pull.

3. Reload your bashrc

If you'd like to use your alias, you can either open a new bash shell, or source your .bashrc file in your current shell using:

> source ~/.bashrc

This basically executes everything in your .bashrc file as if you had typed each command.
