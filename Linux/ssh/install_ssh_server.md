#How To Install and Enable SSH Server on Debian 10
[reference](https://devconnected.com/how-to-install-and-enable-ssh-server-on-debian-10/)

This tutorial focuses on setting up and configuring a SSH server on a Debian 10 minimal server

SSH, for Secure Shell, is a network protocol that is used in order to operate remote logins to distant machines within a local network or over Internet. SSH architectures typically includes a SSH server that is used by SSH clients to connect to the remote machine.

As a system administrator, it is very likely that you are using SSH on a daily basis to connect to remote machines across your network.

As a consequence, when new hosts are onboarded to your infrastructure, you may have to configure them to install and enable SSH on them.

In this tutorial, we are going to see how you can install and enable SSH, via OpenSSH, on a Debian 10 distributions.

Table of Contents

    Prerequisites
    Installing OpenSSH Server on Debian 10
        Enabling SSH traffic on your firewall settings
        Enable SSH server on system boot
    Configuring your SSH server on Debian
        Changing SSH default port
        Disabling Root Login on your SSH server
        Configuring key-based SSH authentication
        Restarting your SSH server to apply changes
    Connecting to your SSH server
    Exiting your SSH server
    Disabling your SSH server
    Troubleshooting
        Debian : SSH connection refused
        Debian : SSH access denied
            SSH password access denied
            SSH key access denied
    Debian : Unable to locate package openssh-server
    Conclusion

Prerequisites

In order to install a SSH server on Debian 10, you will need to have sudo privileges on your host.

To check whether you have sudo privileges or not, run the following command

$ sudo -l

If you are seeing the following entries on your terminal, it means that you have elevated privileges
Checking sudo privileges on Debian 10

By default, the ssh utility should be installed on your host, even on minimal configurations.

In order to check the version of your SSH utility, you can run the following command

$ ssh -V

Checking SSH version on Debian 10

As you can see, I am running OpenSSH v7.9 with OpenSSL v1.1.1.

Note that it does not mean that SSH servers are installed on my host, it just means that I may able to connect to remote machines as a client using the SSH utility.

It also mean that specific utilities related the SSH protocol (such as scp for example) or related to FTP servers (such as sftp) will be available on my host.
Installing OpenSSH Server on Debian 10

First of all, make sure that your packages are up to date by running an update command

$ sudo apt-get update

Updating apt packages on Debian 10

In order to install a SSH server on Debian 10, run the following command

$ sudo apt-get install openssh-server

The command should run a complete installation process and it should set up all the necessary files for your SSH server.

If the installation was successful, you should now have a sshd service installed on your host.

To check your newly installed service, run the following command

$ sudo systemctl status sshd

Checking ssh server status on Debian 10

By default, your SSH server is going to run on port 22.

This is the default port assigned for SSH communications. You can check if this is the case on your host by running the following netstat command

$ netstat -tulpn | grep 22

Great! Your SSH server is now up and running on your Debian 10 host.
Enabling SSH traffic on your firewall settings

If you are using UFW as a default firewall on your Debian 10 system, it is likely that you need to allow SSH connections on your host.

To enable SSH connections on your host, run the following command

$ sudo ufw allow ssh

Enabling SSH connections with UFW on Debian 10
Enable SSH server on system boot

As you probably saw, your SSH server is now running as a service on your host.

It is also very likely that it is instructed to start at boot time.

To check whether your service is enable or not, you can run the following command

$ sudo systemctl list-unit-files | grep enabled | grep ssh

If no results are shown on your terminal, enable the service and run the command again

$ sudo systemctl enable ssh

Enabling the SSH server on boot on Debian 10
Configuring your SSH server on Debian

Before giving access to users through SSH, it is important to have a set of secure settings to avoid being attacked, especially if your server is running as an online VPS.

As we already saw in the past, SSH attacks are pretty common but they can be avoided if we change default settings available.

By default, your SSH configuration files are located at /etc/ssh/
Listing SSH configuration files in etc

In this directory, you are going to find many different configuration files, but the most important ones are :

    ssh_config: defines SSH rules for clients. It means that it defines rules that are applied everytime you use SSH to connect to a remote host or to transfer files between hosts;
    sshd_config: defines SSH rules for your SSH server. It is used for example to define the reachable SSH port or to deny specific users from communicating with your server.

We are obviously going to modify the server-wide part of our SSH setup as we are interested in configuring and securing our OpenSSH server.
Changing SSH default port

The first step towards running a secure SSH server is to change the default assigned by the OpenSSH server.

Edit your sshd_config configuration file and look for the following line.

#Port 22

Make sure to change your port to one that is not reserved for other protocols. I will choose 2222 in this case.
Changing the default SSH port

When connecting to your host, if it not running on the default port, you are going to specify the SSH port yourself.

Please refer to the ‘Connecting to your SSH server’ section for further information.
Disabling Root Login on your SSH server

By default, root login is available on your SSH server.

It should obviously not be the case as it would be a complete disaster if hackers were to login as root on your server.

If by chance you disabled the root account in your Debian 10 installation, you can still configure your SSH server to refuse root login, in case you choose to re-enable your root login one day.

To disable root login on your SSH server, modify the following line

#PermitRootLogin

PermitRootLogin no

Disabling root login for SSH on Debian
Configuring key-based SSH authentication

In SSH, there are two ways of connecting to your host : by using password authentication (what we are doing here), or having a set of SSH keys.

If you are curious about key-based SSH authentication on Debian 10, there is a tutorial available on the subject here.
Restarting your SSH server to apply changes

In order for the changes to be applied, restart your SSH service and make sure that it is correctly restarted

$ sudo systemctl restart sshd
$ sudo systemctl status sshd

SSH server status from systemd

Also, if you change the default port, make sure that the changes were correctly applied by running a simple netstat command

$ netstat -tulpn | grep 2222

Checking SSH port on Linux using netstat
Connecting to your SSH server

In order to connect to your SSH server, you are going to use the ssh command with the following syntax

$ ssh -p <port> <username>@<ip_address>

If you are connecting over a LAN network, make sure to get the local IP address of your machine with the following command

$ sudo ifconfig

Checking local IP using ifconfig

For example, in order to connect to my own instance located at 127.0.0.1, I would run the following command

$ ssh -p 2222 <user>@127.0.0.1

You will be asked to provide your password and to certify that the authenticity of the server is correct.
Connecting to SSH server on Debian 10 Buster
Exiting your SSH server

In order to exit from your SSH server on Debian 10, you can hit Ctrl + D or type ‘logout’ and your connection will be terminated.
Logout from the SSH server
Disabling your SSH server

In order to disable your SSH server on Debian 10, run the following command

$ sudo systemctl stop sshd
$ sudo systemctl status sshd

Stopping SSH server on Debian 10

From there, your SSH server won’t be accessible anymore.
Connection refused from the SSH server
Troubleshooting

In some cases, you may run into many error messages when trying to setup a SSH server on Debian 10.

Here is the list of the common errors you might get during the setup.
Debian : SSH connection refused

Usually, you are getting this error because your firewall is not properly configured on Debian.

To solve “SSH connection refused” you have to double check your UFW firewall settings.

By default, Debian uses UFW as a default firewall, so you might want to check your firewall rules and see if SSH is correctly allowed.

$ sudo ufw status

Status: active
 
To                         Action      From
--                         ------      ----
22/tcp                     ALLOW       Anywhere

If you are using iptables, you can also have a check at your current IP rules with the iptables command.

$ sudo iptables -L -n

Chain INPUT (policy ACCEPT)
target     prot opt source               destination
ACCEPT     tcp  --  anywhere             anywhere            tcp dpt:ssh

If the rule is not set for SSH, you can set by running the iptables command again.

$ sudo iptables -I INPUT -p tcp -m tcp --dport 22 -j ACCEPT

Debian : SSH access denied

Sometimes, you may be denied the access to your SSH server with this error message “SSH access denied” on Debian.

To solve this issue, it depends on the authentication method you are using.
SSH password access denied

If you are using the password method, double check your password and make sure you are entering it correctly.

Also, it is possible to configure SSH servers to allow only a specific subset of users : if this is the case, make sure you belong to that list.

Finally, if you want to log-in as root, make sure that you modified the “PermitRootLogin” option in your “sshd_config” file.

#PermitRootLogin

PermitRootLogin yes

SSH key access denied

If you are using SSH keys for your SSH authentication, you may need to double check that the key is correctly located in the “authorized_keys” file.

If you are not sure about how to do it, follow our guide about SSH key authentication on Debian 10.
Debian : Unable to locate package openssh-server

For this one, you have to make sure that you have set correctly your APT repositories.

Add the following entry to your sources.list file and update your packages.

$ sudo nano /etc/apt/sources.list

deb http://ftp.us.debian.org/debian wheezy main

$ sudo apt-get update

Conclusion

In this tutorial, you learnt how you can install and configure a SSH server on Debian 10 hosts.

You also learnt about basic configuration options that need to be applied in order to run a secure and robust SSH server over a LAN or over Internet.

If you are curious about Linux system administration, we have a ton of tutorials on the subject in a dedicated category.

