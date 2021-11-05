# Raspberry pi hardening

## Source
[website](https://chrisapproved.com/blog/raspberry-pi-hardening.html)

[github](https://gitlab.com/cgoff/raspberry-pi-hardening)
## Table of Contents

    Preamble
    Configuration files and scripts
    Initial Configuration
        Change the password for user pi
        Create new user
        Disable pi account
        [optional] Disable wireless interfaces
        [optional] Configure SMTP client
        Configure automatic security updates
        Configure backups
    Application Hardening
        ssh configuration
        Firewall configuration
        [optional] fail2ban configuration
        [optional] psad configuration
        nginx web server configuration
        LetsEncrypt certificate configuration
    Security Monitoring
        Wazuh agent configuration
        Configure logwatch
        SHODAN network monitoring
        Qualys Community Edition
        Server uptime monitoring
    Additional Recommendations
        Log to RAM to save SD card writes

# Preamble

The genesis of this guide was documenting a repeatable process for creating a hardened baseline configuration to protect friends and family using Raspberry Pi (RPi) devices for IoT projects, many of which were exposed to the internet.

The documentation turned into something that can serve as a general recommendation for security hardening and monitoring (see the NIST Cybersecurity Framework for Protection and Detection). This includes some common applications used in IoT projects, such as a web server configured to serve static web pages.

My goal for this guide is to help anyone with minimal knowledge of security to prototype or deploy an RPi project with confidence. Scripts and configuration files should be well commented so folks understand why it should be configured that way and help any troubleshooting that may need to occur.

The idea is a properly configured system should perform only the necessary functions required to deliver a service. This, in combination with patching security vulnerabilites, vastly decreases the attack surface of your device and therefore the ability for someone to compromise your system.
 WARNING
Please report issues! The configurations should apply to Raspberry Pi and Raspberry Pi [Wireless] Zero systems equally and are tested against the Raspbian 10 operating system. I have made every effort to make these configurations work while performing them remotely on a headless system, but I recommend having your Pi physically accessible with a screen and keyboard to recover from locking yourself out.

Configuration files and scripts
Configuration files and scripts associated with and referenced in this guide are located in  this git repository. If you aren't sure how to use git, I recommend reviewing git - the simple guide, by Roger Dudler.

Execute the following command to clone the entire project to a directory on your RPi device:

git clone https://gitlab.com/cgoff/raspberry-pi-hardening.git

You can keep it updated with the following command:

git pull

Initial Configuration

    Create a new user
    Add new user to 'sudoers' group
    Change user 'pi' password
    Disable 'pi' user
    Install 

The first steps involve creating a new user to replace the pi user, which will be disabled. After this, commands requiring root or admin privileges will have to be preceded with the sudo command.
Change the password for user pi
Logged in as pi, enter the following command and follow the instructions:

passwd

I recommend choosing a password 24 characters or more in length. Use a password manager such as Lastpass or an online tool such as this Diceware generator to make this process easier and more secure.
Create a new user

sudo adduser <username>
sudo adduser <username> sudo

Exit, then log back in as your new user. Run the visudo tool; if successful your new user has the correct privileges assigned.

sudo visudo

Now log back in as your newly created account and disable the pi account.
Disable pi account
Enter the following command to disable the pi account:

sudo usermod --lock --expiredate 1 pi

Test this by logging out then attempting to log back in as the pi user account. If it fails, this was successfully configured.

[optional] Disable wireless interfaces
If you are getting network connectivity to your RPi via a cable, you should consider disabling unused wireless functionality. While this isn't a perfect solution to prevent sideways movement into a wireless network (if an attacker has root, re-enabling the wireless features is trivial), it does allow the creation of a high-quality alert that something unexpected is happening on your system.

sudo vim /boot/config.txt

Add the following to the file:

# Disable wireless services
dtoverlay=pi3-disable-wifi
dtoverlay=pi3-disable-bt

Exit and reboot your Pi.

sudo reboot

[optional] Configure SMTP client
A highly recommended step is to install msmtp so system alerts (such as unattended upgrades status) can be e-mailed to you. You will need configuration information from your e-mail provider for this next step.

Example e-mail provider documentation for Gmail.

sudo apt install msmtp msmtp-mta

sudo vim /etc/msmtprc

Place the following in the msmtprc file:

# Default values for all accounts
defaults
auth on
tls on

# Gmail
account gmail
host smtp.gmail.com
from username@gmail.com

port 587
user username
password **your password**

# Syslog logging with facility LOG_MAIL instead of the default LOG_USER.
syslog LOG_MAIL

# Set a default account
account default : gmail

Note that the above configuration logs to the syslog service by default. This can be found here:

/var/log/mail.log

Test the configuration:

$ echo "This is a test email" | msmtp --debug your@emailaddress.com

Configure automatic security updates
 WARNING
It's important to note that while automating updates is important, they can and will cause problems at some point. New bugs or incompatibilities can be introduced which break software.

This will configure unattended-upgrades for automatic updates of your RPi system.

sudo apt install unattended-upgrades apt-listchanges apticron

Copy 50unattended-upgrades from the git respository into /etc/apt/apt.conf.d/

↪ 50unattended-upgrades configuration file.
Verify configuration:

sudo unattended-upgrade -d --dry-run

Log location for monitoring:

/var/log/unattended-upgrades/unattended-upgrades.log

Configure backups of your RPi system
This will configure backups for your RPi system.

sudo lsblk

Note the name of your SD card (e.g. mmcblk0). Now we're going to utilize dd to create a complete image of your SD card, which can easily be restored. After you have ssh configuration complete, use this command to image your Raspberry Pi remotely, and compress it to a file on your local Linux system:

ssh -t username@hostname sudo dd bs=4M if=/dev/mmcblk0 | pv | gzip > rpi.img.gz

This has the added bonus of doing all the compression on your local system, freeing up the CPU on your RPi.

Alternatively, if you remove the SD card from your RPi and place it in a Linux computer, you can image the card with this command:

sudo dd bs=4M if=/dev/mmcblk0 | gzip > rpi.img.gz

If, at any time, you need to recover your image:

gunzip --stdout rpi.img.gz | sudo dd bs=4M of=/dev/mmcblk0

Application Hardening
These are additional steps you can take to harden specific applications on your Raspberry Pi.

ssh configuration

    Remove ability for root user to login.
    Enable authentication via certificate.
    Set connectivity only from known systems.

Create ssh-users group:

sudo groupadd ssh-users
sudo usermod -a -G ssh-users $USER

On the host system(s) where you will be connecting to the RPi system from via SSH you will need to generate a private and public keypair, and then add the public key of the host system to the RPi system:

ssh-keygen -t ed25519 -a 777
ssh-copy-id -i <pub key> <username>@<rpi hostname>

Edit /etc/ssh/sshd_config with the following configuration changes:

PermitRootLogin no
PubkeyAuthentication yes
PasswordAuthentication no
UsePAM no
X11Forwarding no
AllowGroups ssh-users

Restart ssh to apply the configuration:

sudo systemctl restart ssh

Firewall configuration

    Whitelisting.
    Enable SSH connectivity.
    Enable HTTP/S connectivity.
    Enable ufw.

Install ufw and pre-configure for SSH and web services:

sudo apt install ufw
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw limit ssh
sudo ufw logging on
sudo ufw logging high # see warning below
sudo ufw enable

Note that the ufw limit command only works for IPv4 connections at this time. It is pre-configured to deny connections if a single IP address attempts to initiate 6 or more connections within 30 seconds (REF: man ufw).
 WARNING

It is important to understand that the configuration of ufw logging high may decrease the life of your RPi SD card, but may be needed if adding other security tools such as psad that require detailed logs to function. See Additional Recommendations for a solution.

Verify the firewall rules:

sudo ufw status numbered

[optional] fail2ban configuration
This will allow us to automatically react to obvious attempts to brute-force or exploit vulnerabilities on your system.

sudo apt install fail2ban

sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

sudo vim /etc/fail2ban/jail.local

Add the following to the file under each jail as shown:

[ssd]
enabled = true

[nginx-botsearch]
enabled = true
port = http,https
filter = nginx-botsearch
logpath = %(nginx_error_log)s
bantime = 30d

[nginx-noscript]
enabled = true
port = http,https
filter = nginx-noscript
logpath = %(nginx_access_log)s
maxretry = 1
bantime = 30d

[nginx-badbots]
enabled = true
port = http,https
filter = nginx-badbots
logpath = %(nginx_access_log)s
maxretry = 1
bantime = 30d

Save the file, and restart fail2ban:

sudo service fail2ban restart

We're going to create a new filter specific to banning script accesses. Since all we are doing with nginx is delivering static pages, you can with relative safety automatically ban anyone looking for scripts as it is highly likely that it is someone looking to exploit application vulnerabilities and not a legitimate user.

sudo vim /etc/fail2ban/filter.d/nginx-noscript.conf

Add the following to the file:

[Definition]
failregex = ^<HOST> -*.GET.*(\.php|\.asp|\.aspx|\.exe|\.pl|\.py|\.rb|\.cgi|\.scgi)
ignoreregex =

Copy apache-badbots.conf to nginx-badbots.conf:

sudo cp /etc/fail2ban/filter.d/apache-badbots.conf /etc/fail2ban/filter.d/nginx-badbots.conf

Restart fail2ban:

sudo service fail2ban restart

[optional] psad configuration
The Port Scan Attack Detector (PSAD) is a tool that will help detect port scans on your system, and automatically create blocks with ufw.

sudo apt install psad
sudo vim /etc/psad/psad.conf

Add the following to psad.conf:

EMAIL_ADDRESSES your email address(s)
HOSTNAME    your server's hostname
ENABLE_AUTO_IDS ENABLE_AUTO_IDS Y;
ENABLE_AUTO_IDS_EMAILS  ENABLE_AUTO_IDS_EMAILS Y;
EXPECT_TCP_OPTIONS  EXPECT_TCP_OPTIONS Y;

We'll need to add chains to the firewall:

sudo vim /etc/ufw/before.rules

Add the following lines before the COMMIT line a the bottom:

# for PSAD
-A INPUT -j LOG --log-tcp-options
-A FORWARD -j LOG --log-tcp-options

Do the same for /etc/ufw/before6.rules.

Finally update the signatures, reload, and start:

sudo ufw reload
sudo psad -R
sudo psad --sig-update
sudo psad -H

nginx Web Server
nginx is a popular lightweight web server application that works very well with limited resources. We're going to install nginx and harden the configuration. Note that this will be a restrictive configuration specific to serving static web pages. If you need to add more functionality such as PHP, this guide does not include the additional configuration necessary to implement.

Install nginx:

sudo apt install nginx

In order to make changes to the default html root, you'll need to change the ownership of the /var/www/html directory to both your user and the www-data group:

sudo chown -R "$USER":www-data /var/www/html

You should now be able to manage files and directories in the html root as you please. This isn't required, but we can add some rate-limiting functionality to help prevent small-scale DoS attacks:

sudo vim /etc/nginx/nginx.conf
# Add to the html{} section:
http {
limit_req_zone $binary_remote_addr zone=global:10m rate=20r/m;
limit_conn_zone $binary_remote_addr zone=addr:10m;
}

sudo vim /etc/nginx/sites-enabled/default
# Add to the server{} section:
server {
  location {
    limit_req zone=global burst=10 nodelay;
    limit_conn addr 1;
    limit_rate 100k;
    limit_req_status 429;
  }
}

↪ nginx.conf file for Raspberry Pi systems
↪ default.conf file for Raspberry Pi systems

Finally, let's disable the www-data user from making outbound connections. If this account is compromised, it could potentially be used to make outbound connectivity. Note that you have essentially two firewalls, one each for IPv4 and IPv6 protocols. ufw makes changes to both automatically, but when manually entering iptables commands both iptables and ip6tables must be configured.

sudo iptables -A OUTPUT -o ethX -m owner --uid-owner www-data -j REJECT
# Add to the IPv6 firewall; only required if utilizing IPv6
sudo ip6tables -A OUTPUT -o ethX -m owner --uid-owner www-data -j REJECT
# Reload the firewall config to apply
sudo ufw reload

Letsencrypt Certificate
Install certbot for nginx, and configure automatic renewal of certificates.

sudo apt-get install certbot python-certbot-nginx

sudo certbot --nginx

You can verify that it worked by checking your site through SSL Labs. Let's tidy up the SSL configuration and get that A+ score:

sudo vim /etc/letsencrypt/options-ssl-nginx.conf

# Add the following to options-ssl-nginx.conf
ssl_session_timeout 10m;
ssl_session_tickets off;
ssl_stapling on;
ssl_stapling_verify on;
ssl_trusted_certificate /etc/letsencrypt/live/<domain>/fullchain.pem;
ssl_protocols TLSv1.2 TLSv1.3;
ssl_prefer_server_ciphers on;
ssl_ciphers EECDH+AESGCM:EDH+AESGCM;

Restart nginx to apply the configuration change:

sudo systemctl restart nginx

[optional] Security Monitoring
Hardened configuration is most of the battle, but visibility into what your system is doing is paramount to identifying any potential incidents. This section is optional, some of which requires a pre-configured ossec server to complete. If you do not have one, I recommend Security Onion, which includes it as part of the distribution.

Wazuh agent configuration
↪ ossec.conf file for Raspberry Pi systems

Wazuh is an updated fork of ossec. Wazuh still utilizes ossec configurations, however for the purposes of this guide you can use the terms interchangeably.

Since there isn't a Raspbian binary available from the developer, you'll need to compile from source. Use the defaults from the install.sh file except selecting AGENT and using the IP address of the ossec manager you already have in your environment.

apt install make gcc libc6-dev curl policycoreutils automake autoconf libtool
curl -Ls https://github.com/wazuh/wazuh/archive/v3.9.5.tar.gz | tar zx
cd wazuh-*
sudo ./install.sh
sudo /var/ossec/bin/agent-auth -m <ip of ossec manager> -p 1515
sudo /var/ossec/bin/ossec-control start

Verify connectivity by tailing the ossec log on both the manager and agent.

tail /var/ossec/logs/ossec.log

As a bonus, if you'd like to send the Wazuh/ossec data (and more) across a seperate security monitoring network, read my guide on how to do so with ZeroTier.

Configure logwatch
logwatch is a handy tool we will configure to send daily system summary messages to your e-mail.

sudo apt install logwatch
sudo vim /usr/share/logwatch/dist.conf

Add the following to dist.conf, assuming you have previously configured msmtp:

mailer = "/usr/bin/msmtp user@domain"
TmpDir = /tmp
MailFrom = noreply@domain
Range = yesterday
Detail = high
Format = html

Test your configuration:

sudo /etc/cron.daily/00logwatch

Monitor for vulnerabilities with SHODAN

SHODAN now offers a free monitoring service with some restrictions. If you have a publically facing RPi project, this is worth configuring. Updates will be sent to your e-mail address.





Once configured, SHODAN will notify you of vulnerabilities found at your IP address(es), and visibile services listening on ports.
Monitor for vulnerabilities with Qualys Community Edition

Qualys offers a free Community Edition of their vulnerability scanner which can be used on up to 3 external assets. Handy for learning how their product works, and keeping your RPi services updated and properly configured.
Server Uptime Monitoring

If you're interested in remotely monitoring the uptime of your RPi, I'd suggest signing up for Freshping or Uptime Robot. These services, once configured, will notify you if your IP address becomes unavailable.

Additional Recommendations
Additional recommendations that are not necessarily security related, but improve performance or experience.

Log to RAM to save SD card writes

Typical inexpensive SD cards have a limited number of writes available. The solution to this is to prolong the life by writing to memory and periodically writing the data back to disk.

In order to do this with minimal configuration, there is an excellent little tool called zram-config which makes the whole process painless. Installation and documentation can be found on at this git repository: https://github.com/ecdye/zram-config. 