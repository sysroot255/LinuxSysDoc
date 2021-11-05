# Networking cmd

config: /etc/network/*

Changing hostname:
```bash
 $ sudo hostnamectl set-hostname $NEWHOSTNAME
 ```

Get network interface informations
```bash
 $ sudo vim /etc/network/interfaces
 ```
- Change dhcp to static 
- add address and netmask for static IP
- add auto enp0s3 

reboot

check error with 
```bash
 $ sudo systemctl status networking.service
```

restart networking service
```bash
 $ sudo systemctl restart networking.service

 $ sudo ip link set enp0s3 up
 $ sudo ip link set enp0s3 down
```

when adding the gatway in /etc/networking/interfaces
```bash
 $ ip route
```
we can see newly added route


## Forwarding

1) Must activate a service with sysctl
```bash
 $ sudo sysctl 
# Activate the forwarding
 $ sudo sysctl net.ipv4.ip_forwarding
 0
 $ sudo sysctl net.ipv4.ip_forwarding=1
```
2) Activate NAT with iptable
```bash
 $ iptables -t nat -A POSTROUTING -j MASQUERADE
```
delete all iptables rules
```bash
 $ iptables -F
```

 **!!! Do not restart service on router beacuse the variable ip_forwarding will be reset !!!**

 Check the route and list hop's

 ```
 $ traceroute 8.8.8.8
 ```

 3) Add port forwarding with iptable

 