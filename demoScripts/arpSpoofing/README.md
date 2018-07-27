# Arpspoofing demo

## Required Machines
- Kali
- Ubuntu
- Metasploitable

## Steps
1. Open a browser on the __ubuntu__ instance and load up [http://metasploitable](http://metasploitable) / [192.168.64.2](192.168.64.2)
2. Observe the page is normal
3. Run `arp` in a terminal and notice `metasploitable` is bound to MAC `...:ABBA`
4. On the __Kali__ instance, run the `demo.sh` script in this directory
5. Refresh the page in the __ubuntu__ instance
6. notice that `msfadmin/msfadmin` has become `HACKED/HACKED`

## Presentation covering this:
`5 - ARP poisoning and Man-In-The-Middle attacks.pdf`