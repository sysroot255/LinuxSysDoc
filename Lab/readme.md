# Network basics

# Using ISC-dhcpd
## DHCP config:

```bash

 $ sudo apt install isc-dhcp-server

 $ sudo vim /etc/default/isc-dhcp-server
 add:
 INTERFACESv4="enp0s8"
 
 $ sudo vim /etc/dhcpd.conf
add:
subnet 10.0.3.0 netmask 255.255.255.0 {
    range 10.0.3.10 10.0.3.100;
} 

 $ sudo systemctl restart isc-dhcp-server.service
 $ sudo systemctl restart networking.service

 debugg with :
 $ sudo journalctl -xe

 ```
## forwarding config

router:
```bash
sudo vim /etc/sysctl.conf

 $ sudo 
```

client:
```bash
 $ sudo ip route add default via 10.0.3.1
 $ ip route 
```

configure route to other network:

sudo ip route add 10.0.4.0/24 via 192.168.0.2

# Using dnsmasq

install dnsmaq
```bash
 $ sudo apt install dnsmasq
```
create a new config file beacuse the  /etc/dnsmasq.conf will be overwritten in case of a apt update.
```bash
 $ echo $HOSTNAME
 peperoni
 $ sudo vim /etc/dnsmasq.d/local.conf

 add:
 dhcp-range=10.0.3.10,10.0.3.100,24h

 listen-address=10.0.3.1
 bind-interfaces

 expand-hosts
 doamin=peperoni.lan
 local=/peperoni.lan/

# Setup listening on both interfaces
 server=10.0.3.1
 server=192.168.0.1

# Configure routes for all other networks
 server=/.david.lan/192.168.0.192

# For your dhcp to push routes
dhcp-option=121,10.0.4.0/24,192.168.0.117

```

restart one interface:
```bash
 $ sudo ifup enp0s3
 $ sudo ifdown enp0s3