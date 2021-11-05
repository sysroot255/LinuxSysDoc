# Iptable

## Summary:

- Basics of iptables – Linux firewall
- Configuration of iptables policies
- How to forward port using iptables in Linux
- How to redirect port in Linux using iptables
- [Flushing iptables rules](https://kerneltalks.com/virtualization/how-to-reset-iptables-to-default-settings/)
- [Disable iptables temporarily](https://kerneltalks.com/howto/how-to-disable-iptables-firewall-temporarily/)

# Basics of iptables – Linux firewall

[Beginner’s tutorial to understand iptables](https://kerneltalks.com/networking/basics-of-iptables-linux-firewall/) – Linux firewall. This article explains about iptable basics, different types of chains, and chain policy defining strategy.



**Linux firewall: iptables!** plays a very important role in securing your Linux system. System hardening or locking down cannot be completed without configuring iptables. Here we are discussing the basics of iptables. This article can be referred to by beginners as an iptables guide. In this article we will walkthrough :

- What is iptables
- iptables chains
- Chain policy defining strategy

## What is iptables
iptables is a Linux native firewall and almost comes pre-installed with all distributions. If by any chance its not on your system you can install an iptables package to get it. As its a firewall, it has got policies termed as ‘chain policies’ which are used to determine whether to allow or block incoming or outgoing connection to or from Linux machine. Different chains used to control the different types of connections defined by its travel direction and policies are defined on each chain type.

```
In newer versions like RHEL7, the firewall is still powered by iptables only the management part is being handled by a new daemon called **firewalld**.[root@kerneltalks ~]# iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080
If you have an interface name other than eth0 then you need to edit your command accordingly. You can even add your source and destinations as well in same command using --src and --dst options. Without them, it’s assumed to any source and any destination.

How to check port redirection in iptable
Verify port redirect rule in iptables using below command –

[root@kerneltalks ~]# iptables -t nat -L -n -v
Chain PREROUTING (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination
    0     0 REDIRECT   tcp  --  eth0   *       0.0.0.0/0            0.0.0.0/0            tcp dpt:80 redir ports 8080
..............
You can see port 80 is being redirected to port 8080 on the server. Note here target is REDIRECT. Do not get confused with port redirection with port forwarding.

How to save iptables rules
To save iptables rules and make them persistent over reboots use below command –

[root@kerneltalks ~]# iptables-save
```

As there are policies you can define, one default policy also exists for all chains. If the connection in question does not match with any of the defined policy chains then iptable applies default policy action to that connection. By default (generally) ALLOW rule is configured in defaults under iptables.

## iptable chains
As we saw earlier iptables rely on chains to determine the action to be taken in connection, let’s understand what are chains. Chains are connection types defined by their travel direction/behavior. There are three types of chains: Input, Output, Forward.

## Input chain :
This chain is used to control incoming connections to the Linux machine. For example, if the user tries to connect the server via ssh (port 22) then the input chain will be checked for IP or user and port if those are allowed. If yes then only the user will be connected to the server otherwise not.

## Output chain :
Yes, this chain controls outgoing connections from the Linux machine. If any application or user tries to connect to outside server/IP then the output chain decides if the app/user can connect to destination IP/port or not.

Both chains are stateful. Meaning only said the connection is allowed and a response is not. Means you have to exclusively define input and output chain if your connection needs both way communication (from source to destination and back)

## Forward chain :
In most of the systems, it’s not used. If your system is being used as a pass-through or for natting or for forwarding traffic then only this chain is used. When connections/packets are to be forwarded to next hop then this chain is used.

You can view the status of all these chains using the command :

```bash
# iptables -L -v
Chain INPUT (policy ACCEPT 8928 packets, 13M bytes)
 pkts bytes target     prot opt in     out     source               destination
 
Chain FORWARD (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination
 
Chain OUTPUT (policy ACCEPT 2201 packets, 677K bytes)
 pkts bytes target     prot opt in     out     source               destination
```
In above output, you can see all three chains details, how many packets were transferred, how much data transferred and default action policy.

## Chain policy defining strategy
There are three policies can be defined for chains.

1. ACCEPT: Allow connection
2. REJECT: Block connection and send back error message informing source that destination blocked it
3. DROP: Block connection only (behave like connection never questioned). The source is unaware of being blocked at the destination.

By default, all chains configured with ACCEPT policy for all connections. When configuring policies manually you have to pick either way from below two :

1. Configure default as REJECT/DROP and exclusively configure each chain and its policy of ALLOW for required IP/subnet/ports.
2. Configure default as ACCEPT and exclusively configure each chain and its policy of REJECT for required IP/subnet/ports.

You will go with number two unless your system has highly sensitive, important data and should be locked out of the outer world. Obviously, its environment criticality and number of IP/subnet/ports to be allowed/denied makes it easier to select a strategy.


# Configuration of iptables policies

Defining iptables policies means allowing or blocking connections based on their direction of travel (incoming, outgoing or forward), IP address, range of IP addresses, and ports. Rules are scanned in order for all connections until iptables gets a match. Hence you need to decide and accordingly define rule numerically so that it gets match first or later than other rules.

```
In newer versions like RHEL7, the firewall is still powered by iptables only the management part is being handled by a new daemon called **firewalld**.
```

**iptables** is the command you need to use to define policies. With below switches –

- -A: To append rule in an existing chain
- -s: Source
- -p: Protocol
- –dport: service port
- -j : action to be taken

Lets start with examples with commands.

## Block/Allow single IP address
To block or allow a single IP address follow below command where we are adding a rule **-A** to input chain  (**INPUT**) for blocking (**-j REJECT**).

```bash
# iptables -A INPUT -s 172.31.1.122 -j REJECT
 
# iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination
REJECT     all  --  ip-172-31-1-122  anywhere            reject-with icmp-port-unreachable
 
----- output clipped -----
```

In the above command we are blocking incoming connections from IP 172.31.1.122. If you see the output of rules listing, you can see our rule is defined properly in iptables. Since we didn’t mention protocol, all protocols are rejected in the rule.

Here chain can be any of the three: input (incoming connection), output (outgoing connection), or forward (forwarding connection). Also, action can be accepted, reject, or drop.

## Block/Allow single IP address range
Same as single IP address, whole address range can be defined in rule too. The above command can be used only instead of IP address you need to define range there.

```bash
# iptables -A INPUT -s 172.31.1.122/22 -j REJECT
 
# iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination
REJECT     all  --  172.31.0.0/22        anywhere            reject-with icmp-port-unreachable
 
# iptables -A INPUT -s 172.31.1.122/255.255.254.0 -j REJECT
 
# iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination
REJECT     all  --  172.31.0.0/22        anywhere            reject-with icmp-port-unreachable
REJECT     all  --  172.31.0.0/23        anywhere            reject-with icmp-port-unreachable
```
I have shown two different notation types to define the IP address range/subnet. But if you observe while displaying rules iptables shows you in /X notation only.

Again action and chain can be any of the three of their types as explained in the previous part.

## Block/Allow specific port
Now, if you want to allow/block specific port then you need to specify protocol and port as shown below :
```bash
# iptables -A INPUT -p tcp --dport telnet -s 172.31.1.122 -j DROP
 
# iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination
DROP       tcp  --  172.31.1.122         anywhere            tcp dpt:telnet
```

Here in this example we blocked the telnet port using TCP protocol from specified source IP. You can choose the chain and action of your choice depending on which rule you want to configure.

## Saving iptables policies
All the configuration done above is not permanent and will be washed away when iptable services restarted or server reboots. To make all these configured rules permanent you need to write these rules.  This can be done by supplying save argument to iptables service (not command!)

```bash
# /sbin/service iptables save
iptables: Saving firewall rules to /etc/sysconfig/iptables:[  OK  ]
```
You can also use iptables-save command.


If you open up /etc/sysconfig/iptables file you will see all your rules saved there.

```bash
# cat /etc/sysconfig/iptables
# Generated by iptables-save v1.4.7 on Tue Jun 13 01:06:01 2017
*filter
:INPUT ACCEPT [32:2576]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [48:6358]
-A INPUT -s 172.31.1.122/32 -j REJECT --reject-with icmp-port-unreachable
-A INPUT -s 172.31.0.0/22 -j REJECT --reject-with icmp-port-unreachable
-A INPUT -s 172.31.0.0/23 -j REJECT --reject-with icmp-port-unreachable
-A INPUT -s 172.31.1.122/32 -p tcp -m tcp --dport 23 -j DROP
COMMIT
# Completed on Tue Jun 13 01:06:01 2017
```

## Deleting rule in iptables
We have seen how to add a rule, how to delete the existing rules. You can use the same commands used above only change is to add **-D** switch instead of **-A**!
```bash
# iptables -D INPUT -s 172.31.1.122 -j REJECT
```

The above command will remove the very first rule we added in iptables in this post.

Also, if you haven’t saved your iptables you can flush all currently configured rules by using -F.

```bash
# iptables -F
```

# How to forward port using iptables in Linux

In this article, we will walk you through port forwarding using **iptables** in Linux. First of all, you need to check if port forwarding is enabled or not on your server. For better understanding, we will be using **eth0** as a reference interface and all our command executions will be related to **eth0** in this article.

## How to check if port forwarding is enabled in Linux
Either you can use **sysctl** to check if forwarding is enabled or not. Use below command to check –

```bash
[root@kerneltalks ~]#  sysctl -a |grep -i eth0.forwarding
net.ipv4.conf.eth0.forwarding = 0
net.ipv6.conf.eth0.forwarding = 0
```
Since both values are zero, port forwarding is disabled for ipv4 and ipv6 on interface eth0.

Or you can use the process filesystem to check if port forwarding is enabled or not.

```bash
[root@kerneltalks ~]# cat /proc/sys/net/ipv4/conf/eth0/forwarding
0
[root@kerneltalks ~]# cat /proc/sys/net/ipv6/conf/eth0/forwarding
0
```
Again here process FS with zero values confirms port forwarding is disabled on our system. Now we need to first enable port forwarding on our system then we will configure port forwarding rules in iptables.

## How to enable port forwarding in Linux
As we checked above, using the same methods you can enable port forwarding in Linux. But its recommended using **sysctl** command rather than replacing 0 by 1 in proc files.

Enable port forwarding in Linux using **sysctl** command –

```bash
[root@kerneltalks ~]# sysctl net.ipv4.conf.eth0.forwarding=1
net.ipv4.conf.eth0.forwarding = 1
[root@kerneltalks ~]# sysctl net.ipv6.conf.eth0.forwarding=1
net.ipv6.conf.eth0.forwarding = 1
```
To make it persistent over reboots, add parameters in /etc/sysctl.conf

```bash
[root@kerneltalks ~]# echo "net.ipv4.conf.eth0.forwarding = 1">>/etc/sysctl.conf
[root@kerneltalks ~]# echo "net.ipv6.conf.eth0.forwarding = 1">>/etc/sysctl.conf
[root@kerneltalks ~]# sysctl -p
net.ipv4.conf.eth0.forwarding = 1
net.ipv6.conf.eth0.forwarding = 1
```
Now, we have port forwarding enabled on our server, we can go ahead with configuring port forwarding rules using **iptables**.

How to forward port in Linux
Here we will forward port 80 to port 8080 on 172.31.40.29. Do not get confused port forwarding with **port redirection**.

We need to insert an entry in **PREROUTING** chain of **iptables** with **DNAT** target. Command will be as follows –

```bash
# iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j DNAT --to 172.31.40.29:8080
# iptables -A FORWARD -p tcp -d 172.31.40.29 --dport 8080 -j ACCEPT
```
Change interface, IP and ports as per your requirement. The first command tells us to redirect packets coming to port 80 to IP 172.31.40.29 on port 8080. Now packet also needs to go through **FORWARD** chain so we are allowing in in the second command.

Now rules have been applied. You need to verify them.

## How to check port forwarding iptables rules
Command to verify port forwarding rules is –

```bash
[root@kerneltalks ~]# iptables -t nat -L -n -v
Chain PREROUTING (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination
    0     0 DNAT       tcp  --  eth0   *       0.0.0.0/0            0.0.0.0/0            tcp dpt:80 to:172.31.40.29:8080
```
Here **REDIRECT** target means its a redirection rule. Since we have configured forwarding rule we see the target as **DNAT**

## How to save iptables rules
To save **iptables** rules and make them persistent over reboots use below command –
```bash
[root@kerneltalks ~]# iptables-save
```

# How to redirect port in Linux using iptables

In this short tutorial, we will walk you through the process to redirect port using iptables. How to check port redirection in Linux and how to save iptables rules.

Our requirement is to redirect port 80 to port 8080 in the same server. This can be done by adding rules in PREROUTING chain. So run below command –

```bash
[root@kerneltalks ~]# iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 8080
```
If you have an interface name other than eth0 then you need to edit your command accordingly. You can even add your source and destinations as well in same command using **--src** and **--dst** options. Without them, it’s assumed to any source and any destination.

## How to check port redirection in iptable
Verify port redirect rule in iptables using below command –
```bash
[root@kerneltalks ~]# iptables -t nat -L -n -v
Chain PREROUTING (policy ACCEPT 0 packets, 0 bytes)
 pkts bytes target     prot opt in     out     source               destination
    0     0 REDIRECT   tcp  --  eth0   *       0.0.0.0/0            0.0.0.0/0            tcp dpt:80 redir ports 8080
..............
```
You can see port 80 is being redirected to port 8080 on the server. Note here target is REDIRECT. Do not get confused with port redirection with port forwarding.

## How to save iptables rules
To save iptables rules and make them persistent over reboots use below command –
```bash
[root@kerneltalks ~]# iptables-save
```