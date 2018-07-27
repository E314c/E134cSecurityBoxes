# Environment Setup script

## What you'll need
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://www.vagrantup.com/downloads.html)

## Current problems
- the damned `kali` image won't upload to vagrant cloud
  - So you can't just `vagrant up`. Sorry :(

## Security concerns
Metasploitable is designed to be vulnerable and should not be network accessible.
Unfortunately, Vagrant requires that the first interface be a NAT and it will port forward a localhost port into the machine to perform it's setup and configuration.
The documentation for Metasploitable2 suggests that this is _okay_, but I'm not entirely happy with it.
Future improvements:
- [ ] Force vagrant ssh to be private key authenicated
- [ ] Add IPtables rules to DROP ALL eth0 traffic _except_ on SSH (for vagrant)

All other machines will have internet access due to the NAT router. You can disable this in each machine, but this will break vagrant's ability to manage the machine until it is re-enabled (vagrant can still force shutdown the machine externally, but it will treat this as an error state).

## Configuration
| Machine | Kali | Ubuntu | Metasploitable |
| -- | -- | -- | -- |
| IP addr | 192.168.64.8 | 192.168.64.4 | 192.168.64.2 |
| Mac Address | 0800-27C5-BEEF | 0800-27C5-ABBA | 0800-27C5-DEAD | 
| /etc/hosts shortcut | `kali` | `ubuntu` | `metasploitable` |
| default user | `root` | `vagrant` | `msfadmin` |
| password  | `toor` | `vagrant` | `msfadmin` |

## Demos
This box system will include a number of demos, which can be see in the `/demoScripts` of this repository.
This folder is also mounted as `/demoScripts` within the kali box so you have access to them.
More demos will be added over time!

## Shared folders.
Both the __ubuntu__ and __kali__ instances have folders that are shared between the host OS and the VM.
On the host machine they are the `./ubuntuFiles/` and `./kaliFiles/` directories.
Within the respective machines they will be mounted on `/hostShare`