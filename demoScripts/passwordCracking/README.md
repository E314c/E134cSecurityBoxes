# Password Cracking


# Cracking with a dictionary and rules
```sh
hashcat -a 0 -m 0 output.md5 /usr/share/wordlists/sqlmap.txt -r /usr/share/hashcat/rules/best64.rule --force
```
## what is all means:
```
-a 0                Attack mode: 0 = Straight
-m 0                Hash type to use: 0 = md5 (see hashcat(1) input options)
[HashFile]          the file to take hashes from.
[dictionary file]   The dictionary file (1 entry per line)
-r [ruleFile]       A file of rules to use to modify the dictionary
```

# Cracking A pattern bruteforce
```sh
hashcat -a 3 -m 0 -1 ?l?d output.md5 --increment --runtime 300 ?1?1?1?1?1?1
```
## what is all means:
```
-a 3                Attack mode: 0 = Brute Force
-m 0                Hash type to use: 0 = md5 (see hashcat(1) input options)
-1 ?l?d             Define a custom character set: lowercase and digits 
--increment         Do incremental masks: start from a single char mask, up to the length of the specified mask
--runtime 300       Limit runtime to 300 seconds
[HashFile]          the file to take hashes from.
[pattern]           using the `?1` as defined earlier
```

# Removing the local cache of pre-cracked passwords
By default, hashcat stores a cache of any cracked passwords in `~/.hashcat/hashcat.potfile`, so it can skip them if the same hash is found or a process crashes and needs to be re-run.
You can `rm` this file if you'd like to crack the file again as if you'd never seen it.

## Plain text files
The file texts in this folder are courtesy of [SkullSecurity](https://wiki.skullsecurity.org/Passwords) and can be donwloaded there.