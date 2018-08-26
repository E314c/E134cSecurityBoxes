# Return Jumping

In this demo we'll show one of the simplest things you can do with a stack overflow: changing the program flow by modifying the return address.  
For this, you'll see from `vuln.c` that the executable accepts a string parameter, does a comparison, then ouputs either `Success !\n` or `Failure !\n`.  
Our goal as _"hackers"_ will be to get the "Success" message _without_ supplying the correct password, which might demonstrate an authenication bypass or otherwise.

## Compiling
This executable should already exist and have been compiled. If you want to change and recompile, you'll need the following command from the directory:
`gcc vuln.c -g -m32 -o vuln -fno-stack-protector -no-pie`
basically:  
- `-g` enables debug symbols
- `-m32` emulates 32 bit mode
- `-fno-stack-protector` disables stack canaries
- `-no-pie` don't enable Position Idependent Execution (so no ASLR) 
note: we should not need `-z execstack` as we will not be executing code in the stack.

## Debugging 
`gdb ./vuln`
Run the executable in Gnu DeBugger and examine the file:
- `disassemble main`: to view the addresses and instructions that make up the `main`
- `break 14`, `break 21` and `break 37`: Add break points for after the string copy, on the function return and ust after function return in main
- `run notThePass`, `run Bypass`, `run $(cat exploit)`: try running with an incorrect password, with the correct one and then with a large one.
- When you hit a breakpoint:
  - `info registers` (or `i r`): See the current contents of the registers
  - `x/20x $esp`: view 20 bytes of data around the stack pointer
  - `cont` to move on



## Inadvertent canary
You may be wondering why there's a new function defined for `printSuccess()`, and that's because I was having a few issues with an `LEA` instruction that referenced an address from `ebx`. You can see the code i'm talking about in the disassembly under `printf("Failure !\n);` code.

It turns out that the stack handling in this program has an inadertent canary value, where ebx must be contain the value that was originally in `$ebp-4`, else a later address lookup will fail.
This means our exploit need not change the value in that location when doing the stack overwrite. 

You can see the problem at the end of the `getPassword()` disassembly:
```asm
mov     -0x4(%ebp), %ebx
leave
ret
```
The move attempts to restore the value at `$ebp-4` into `ebx`. Even though this value is the same every run (due to `-no-pie`), we are unable to have the value in our exploit as it contains `\x00` as one of the bytes, which will be treated as a NULL terminator and prematurely end our exploit string.
Feel free to have a look yourself: Add a breakpoint at the beginning of `getPassword()`, check the value around `$ebp-4` and see how it gets overwritten by our exploit code. This results in a segfault when the `puts` function attempts to read the string it needs to print (as it gets the address via the `lea    -0x1fa2(%ebx), %eax`, which determines the address based on `ebx` and loads it into `eax`)