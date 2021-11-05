# FRACZ

Fracz is a good excercize to learn basic and advanced git command.
Go to the [website](https://gitexercises.fracz.com/) and follow the instructions to start the game.
Make sure you have git installed onto the machine you want to do the excercize on.

## 1. Exercise: Push a commit you have made

### Instructions

The first exercise is to push a commit that is created when you run the git start command.
Just try git verify after you have initialized the exercises and be proud of passing the first one :-)

### Commands 

```bash
git push

```

## 2. Exercise: Commit one file

### Instructions

There are two files created in the root project directory - **A.txt** and **B.txt**.
The goal is to commit only one of them.
NOTE: Remember that you can submit your solutions with **git verify** command instead of **git push**.

### The easiest solution

**TODO**

#### Further info

You prepare changes to be committed with **git add <file>** command. It adds files from working area to staging area. Only files that are in staging area will be included in the commit when you run the **git commit** command.

Remember that you can **git add -A** to add all changed files to staging area. You can also do this in air with **-a** option for **git commit**, e.g.

### Commands 

```bash
git commit -am "Some Commit Message"
```

## 3. Commit one file of two currently staged

### Instructions

There are two files created in the root project directory - **A.txt** and **B.txt**. They are both added to the staging area.
The goal is to commit only one of them.

### The easiest solution

**TODO**

### Further info

When you have added too many changes to staging area, you can undo them with **git reset <file>** command before the **git commit**.

### The easiest solution

**TODO**

### Further info

When you have added too many changes to staging area, you can undo them with **git reset <file>** command before the **git commit**.

### Commands 

```bash
$ git status
On branch commit-one-file-staged
Your branch is up to date with 'origin/commit-one-file-staged'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   A.txt
        new file:   B.txt


FOR209-03+Admin@FOR209-03 MINGW64 ~/Documents/exercises (commit-one-file-staged)
$ git restore --staged B.txt
```

## 4. Ignore unwanted files

### Instructions

It is often good idea to tell Git which files it should track and which it should not. Developers almost always do not want to include generated files, compiled code or libraries into their project history.

Your task is to create and commit configuration that would ignore:

all files with **exe** extension
all files with **o** extension
all files with **jar** extension
the whole **libraries** directory
Sample files are generated for you.

### The easiest solution

### Further info

A **.gitignore** file specifies intentionally untracked files that Git should ignore.

To ignore all files with specific string inside filename, just type it in, i.e. **dumb** To ignore all files with specific extension use wildcard, i.e. **.exe** To ignore the whole directories, put a slash in the end of the rule, i.e. **libraries/** To specify full path from the **.gitignore** location start rule with slash, i.e. **/libraries**

Note that there is a difference between **libraries/** and **/libraries/** rule. The first one would ignore all directories named **libraries** in the whole project whereas the second one would ignore only the **libraries** directory in the same location as .gitignore file.

Also, it's worth to know that there are [many predefined .gitignores for specific environments](https://github.com/github/gitignore) so you don't have to invent your own. There is even a .gitignore generator.

### commands 

```bash
$ touch .gitigniore  
$ vim .gitigniore  
    *.exe  
    *.o  
    *.jar  
    libraries/*  
    libraries\*  
```
```bash
$ git add .gitignore
$ git commit -am "gitignore"
[ignore-them 85217dc] gitignore
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename .gitigniore => .gitignore (100%)
Status: **PASSED**
You can see the easiest known solution and further info at:
https://gitexercises.fracz.com/e/ignore-them/9l2

Next task: chase-branch
In order to start, execute: git start next

See your progress and instructions at:
https://gitexercises.fracz.com/c/9l2
```

## 5. Chase branch that escaped

### Instructions
You are currently on chase-branch branch. There is also escaped branch that has two more commits.

   HEAD
     |
chase-branch        escaped
     |                 |
     A <----- B <----- C
You want to make chase-branch to point to the same commit as the escaped branch.

                    escaped
                       |
     A <----- B <----- C
                       |
                  chase-branch
                       |
                      HEAD
The easiest solution
Further info
Because the chase branch was direct ancestor of the escaped branch, the pointer could be simply moved and no merge commit is necessary (also, conflicts are impossible to happen in such situations).

This is what Git calls as Fast-Forward merge because the branch pointer is only fast forwarded to the commit you are merging with.

Note that you could easily fool this task by executing command

>git push origin escaped:chase-branch

Remote repository could not tell then if you have done the merge or if you just wanted to set the remote chase-branch to point to the same commit as your local escaped branch (which is what the command above does).

See also: Basic Branching and Merging from Git Book.

### commands

>$ git merge escaped

## 6. Resolve a merge conflict
### Instructions
Merge conflict appears when you change the same part of the same file differently in the two branches you're merging together. Conflicts require developer to solve them by hand.

Your repository looks like this:
```

        HEAD
         |
    merge-conflict
         |
A <----- B
 \
  \----- C
         |
```         
another-piece-of-work
You want to **merge the another-piece-of-work** into your current branch. This will cause a merge conflict which you have to resolve. Your repository should look like this:
```
                 HEAD
                  |
             merge-conflict
                  |
A <----- B <----- D
 \               /
  \----- C <----/
         |
another-piece-of-work
```

### How to resolve merge conflicts using the command line
The most direct way to resolve a merge conflict is to edit the conflicted file. Open the merge.txt file in your favorite editor. For our example lets simply remove all the conflict dividers. The modified merge.txt content should then look like:

```
this is some content to mess with
content to append
totally different content to merge later
```

Once the file has been edited use git add merge.txt to stage the new merged content. To finalize the merge create a new commit by executing:

>git commit -m "merged and resolved the conflict in merge.txt"

Git will see that the conflict has been resolved and creates a new merge commit to finalize the merge.

## Git commands that can help resolve merge conflicts
### General tools

>git status

The status command is in frequent use when a working with Git and during a merge it will help identify conflicted files.

>git log --merge

Passing the --merge argument to the git log command will produce a log with a list of commits that conflict between the merging branches.

> git diff

diff helps find differences between states of a repository/files. This is useful in predicting and preventing merge conflicts.

### Tools for when git fails to start a merge

>git checkout

checkout can be used for undoing changes to files, or for changing branches

>git reset --mixed

reset can be used to undo changes to the working directory and staging area.

### Tools for when git conflicts arise during a merge

>git merge --abort

Executing git merge with the --abort option will exit from the merge process and return the branch to the state before the merge began.

>git reset

Git reset can be used during a merge conflict to reset conflicted files to a know good state

## The easiest solution
### Further info
Because the branches have diverged, fast-forward merge strategy could not be applied. Therefore, a merge conflict was possible. Because two branches made changes in the same file and near the same line, Git decided not to handle the situation itself but to throw a merge conflict (letting user decide what to do).

After you resolve the conflict, you need to add it to staging area to tell Git that you have handled the situation. **git commit** then continues the merging process.

However, when Git stops and tells you that there is a conflict to resolve, you are not left on your own. There are some tricks that can make conflict resolution process a lot easier.

- By default, Git shows only your changes and their changes of conflicting lines. This will look like this:
```
 <<<<<<< HEAD
 2 + ? = 5
 =======
 ? + 3 = 5
 >>>>>>> another-piece-of-work
```
It is often very helpful to see also how the code looked like before both of these changes. Seeing more context can help figure out good conflict resolution a lot faster. You can [checkout each file in diff3 mode](http://git-scm.com/book/en/v2/Git-Tools-Advanced-Merging#_checking_out_conflicts) that shows all three states of conflicting lines.

>git checkout --conflict=diff3 equation.txt

Conflict in **equation.txt** will be presented now as:
```
<<<<<< HEAD
2 + ? = 5
||||||| merged common ancestors
? + ? = 5
=======
? + 3 = 5
>>>>>>> another-piece-of-work
```
If you like the **diff3** presentation of conflicts, you can enable them by default with

>git config merge.conflictstyle diff3

- Sometimes you want either discard your changes or their changes that introduces the conflict. You can do that easily with

> git checkout --ours equation.txt

It's also worth to read the [Basic Branching and Merging](http://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging) from the Git Book.

### commands

```bash
  137  vim equation.txt
  138  git merge another-piece-of-work
  139  cat equation.txt
  140  vim equation.txt
  141  git merge another-piece-of-work
  142  cat equation.txt
  143  git add equation.txt
  144  git commit -m "merge equation"
  145  git verify
  146  git start next
```

## 7. Saving your work

### Instructions

You are working hard on a regular issue while your boss comes in and wants you to fix a bug. State of your current working area is a total mess so you don't feel comfortable with making a commit now. However, you need to fix the found bug ASAP.

Git lets you to save your work on a side and continue it later. Find appropriate Git tool and use it to handle the situation appropriately.

Look for a bug to remove in bug.txt.

After you commit the bugfix, get back to your work. Finish it by adding a new line to bug.txt with

Finally, finished it!
Then, commit your work after bugfix.

### Hint
1. Use [git stash](https://git-scm.com/docs/git-stash) to save your current work in background and clean the working area.
2. Fix the bug.
3. Use **git stash pop** to reapply your changes to working area.
Finish your work (see instructions)

```bash
$ git pull
 ...
file foobar not up to date, cannot merge.
$ git stash
$ git pull
$ git stash pop
```

## The easiest solution
### Further info
It's hard to verify if you have done this task correctly.

Its aim was to demonstrate **git stash** feature. When you run this command on dirty working area, it will save its state in stashed changes. You can do another work then, make any commits, checkout to any branch and then get the stashed changes back. You can think of stash as an intelligent Git clipboard.

An interesting option of stash command is the **--keep-index** which allows to stash all changes that were not added to staging area yet.

Keep in mind that applying stash might lead to conflicts if your working area introducted changes conflicting with stash. Therefore, its often safer to run **git stash apply** instead of **git stash pop** (the first one does not remove stashed changes).

Last thing to remember is that stashes are only local - you can't push them to remote repository.

See Stashing in the Git Book.

# Commands

```bash
  149  **git stash**
  150  **git pull**
  151  ls
  152  git status
  153  **vim bug.txt**
  154  ls
  155  git status
  156  **git add bug.txt**
  157  **git commit -m "Hotfix"**
  158  **git stash pop**
  159  **vim bug.txt**
  160  **git add bug.txt**
  161  git commit -m "after bug fix"
  162  git verify
  163  git log
  164  git reset --soft b62a9b25b4f7da5e94c1fc754fd2803d7bfe8107
  165  git status
  166  vim bug.txt
  167  **git add program.txt**
  168  **git commit -m "after bug fix"**
```

## 8. Change branch history

### Instructions

You were working on a regular issue while your boss came in and told you to fix recent bug in an application. Because your work on the issue hasn't been done yet, you decided to go back where you started and do a bug fix there.

Your repository look like this:

```

        HEAD
         |
change-branch-history
         |
A <----- B
 \
  \----- C
         |
     hot-bugfix
```

Now you realized that the bug is really annoying and you don't want to continue your work without the fix you have made. You wish your repository looked like you started after fixing a bug.

```

                 HEAD
                  |
         change-branch-history
                  |
A <----- C <----- B
         |
     hot-bugfix
```

Achieve that.

### Hint

You need to use [git rebase](https://git-scm.com/docs/git-rebase) command.

