# Rpi installation process

## Config with raspi-config
- languages
- keyboard
- wifi 
- display CEA = TV / DFT = monitor

```bash
sudo raspi-config
```
## SSH

First change pi password:
```bash
$ passwd
$ sudo passwd
```
**!!! sudo passwd change the root password !!!**

Enable and run SSH service

```bash
$ sudo systemctl enable ssh
$ sudo systemctl start ssh
```
login via SSH

```bash
$ sudo ssh pi@172.30.40.39
```

# Change hostname
```bash
$ sudo raspi-config
```
## matrix 
