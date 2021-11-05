# Raspberry PI exercises

## Exploring a linux machine

Linux Checklist
- Unusual Accounts
- Unusual Log Entries
- Unusual Processes and Services
- Unusual Files
- Unusual Network Usage
- Unusual Scheduled Tasks
- Other Unusual Items

1. Unusual Accounts:

Look in /etc/passwd for users accounts:

```bash
$ sudo cat /etc/passwd
$ sudo cat /etc/passwd | grep bash
```

Using htop we can see  several users are running processes.

Look for orphaned files, which could be a sign of an attacker’s temporary account that has been deleted.

```bash
$ find / -nouser -print
```

2. Log Entries:

check informations in the log folder:

```bash
$ cat /var/log/*
```
3. Processes and Services:

Look at all runing processes:

```bash
$ ps -auxGet
```

lsof command shows all files and ports used by the running process:
```bash
$ lsof -p
```

You can run chkconfig to see which services are enabled at various run levels:

```bash
$ chkconfig – -list
```

4.  Files:

Look for unusual SUID root files: 

```bash
$ find / -uid 0 –perm -4000 –print
```

Look for unusual large files (greater than 10 MegaBytes):

```bash
$ find / -size +10000k –print
```

Look for files named with dots and spaces (“…”, “.. “,“. “, and ” “) used to camouflage files:
$ find / -name ” ” –print 
$ find / -name “.. ” –print
$ find / -name “. ” –print
$ find / -name ” ” –print

Look for processes running out of or accessing files that have been unlinked (i.e., link count is zero). 
An attacker may be hiding data in or running a backdoor from such files:
```bash
$ lsof +L1On a Linux machine with RPM installed (RedHat, Mandrake, etc.),
```

Run the RPM tool to verify packages:
```bash
$ rpm –Va | sort
```

5. Network Usage:

Look for promiscuous mode, which might indicate a sniffer:

```bash
$ ip link | grep PROMISC
```

Note that the ifconfig doesn’t work reliably for detecting promiscuous mode on Linux kernel 2.4, so please use “ip link” for detecting it.

Look for unusual port listeners:

```bash
$ netstat –nap
```

Get more details about running processes listening on ports:

```bash
$ lsof –i 
```
These commands require knowledge of which TCP and UDP ports are normally listening on your system. 

Look for unusual ARP entries, mapping IP address to MAC addresses that aren’t correct for the LAN:

```bash
$ arp –a
```

6. Scheduled Tasks:

Look for cron jobs scheduled by root and any other UID 0 accounts:

```bash
$ crontab –u root –l
```

Look for unusual system-wide cron jobs:

```bash
$ cat /etc/crontab# ls /etc/cron.*
```

7. Other Unusual Items:

Sluggish system performance:

```bash
$ uptime – 
```

Look at “load average”Excessive memory use:

```bash
$ free
```

Sudden decreases in available disk space:

```bash
$ df
```
