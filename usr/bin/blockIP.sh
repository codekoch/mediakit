#!/bin/bash
sudo iptables -I INPUT -s $1 -j DROP
sudo iptables -I INPUT -s $1 -p tcp --dport 22 -j ACCEPT
sudo iptables -I INPUT -s $1 -p tcp --dport 3000 -j ACCEPT
sudo iptables -I INPUT -s $1 -p tcp --dport 5900 -j ACCEPT
sudo iptables -I INPUT -s $1 -p tcp --dport 5901 -j ACCEPT
sudo iptables -I INPUT -s  1.1.1.0/24 -p tcp --dport 53 -j ACCEPT
sudo iptables -I INPUT -s  1.1.1.0/24 -p udp --dport 53 -j ACCEPT

