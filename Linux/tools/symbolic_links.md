# What is Symbolic Links in Linux? How to Create Symbolic Links?
[linux Handbook](https://linuxhandbook.com/symbolic-link-linux/)

A symbolic link, also known as a symlink or a soft link, is a special type of file that simply points to another file or directory just like shortcuts in Windows. Creating symbolic link is like creating alias to an actual file.

If you try to access the symbolic link, you actually access the target file to which the symlink points to. Changes performed on the content of the link file changes the content of the actual target file.

If you use the ls command with option -l, this is what a symbolic link looks like:
```bash
lrwxrwxrwx 1 abhishek abhishek 23 Jul  2 08:51 link_prog -> newdir/test_dir/prog.py
```

In most Linux distributions, the links are displayed in a different color than the rest of the entries so that you can distinguish the links from the regular files and directories.
Soft Link Linux Terminal
Soft Link displayed in different color

Symbolic links offer a convenient way to organize and share files. They provide quick access to long and confusing directory paths. They are heavily used in linking libraries in Linux.

Now that you know a little about the symbolic links, let’s see how to create them.
How to create a symbolic link in Linux

To create a symbolic link to target file from link name, you can use the ln command with -s option like this:

> ln -s target_file link_name

The -s option is important here. It determines that the link is soft link. If you don’t use it, it will create a hard link. I’ll explain the difference between soft links and hard links in a different article.
