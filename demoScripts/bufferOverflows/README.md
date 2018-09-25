# Buffer Overflows

## Disabling gcc protections
`gcc <input.c> -o <outputExec> -fno-stack-protector -z execstack -no-pie`

`gcc vuln.c -g -m32 -o vuln -fno-stack-protector -z execstack -no-pie`


## Basic GDB commands
|command |  description | shortcut version | 
|---|---|---|
|list `x`,`y`| Show source code lines between `x` and `y` | `l 1,10` |
| break `x` | Add a break point at the given address (can be a source code line) | |
| info registers | Print out the current state of the registers | `i r` |
| x/20x $esp | Examine 20 bytes of data around the location pointed to be `esp` | |
| run [args] | Run the executable (with the provided args) | |
| cont | continue execution ||
| disassemble | Disassemble the function given into assembly. The `/s` flag will print source lines near the disassembly too  | `disas` |

## Some Learning resources
## Smashing the Stack for fun and Profit - Aleph One [Phrack Magazine]
http://phrack.org/issues/49/14.html
## [Sam Bowne's Course](https://samsclass.info/127/127_S18.shtml)
In the [Project listings](https://samsclass.info/127/127_S18.shtml#projects) there are project for finding and exploiting buffer overflows
