#!/bin/bash

sudo iptables -F
sudo iptables -I FORWARD -s 1.1.1.0/24 -j DROP


