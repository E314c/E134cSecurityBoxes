# Installing OpenCL for Hashcat



## From https://hashcat.net/forum/thread-6079.html
```
Installed The-Distribution-Which-Does-Not-Handle-OpenCL-Well (Kali) Linux on your laptop, but hashcat won't run? 
You probably don't have OpenCL installed yet, which is required by hashcat.

I've got a Lenovo Yoga 2 pro laptop with intel i7 cpu & integrated gpu in the cpu. To get hashcat running there are only a few steps needed:

1) Download the "OpenCL™ 2.0 GPU/CPU driver package for Linux* (64-bit)" from https://software.intel.com/en-us/articles/opencl-drivers

2) Extract the file to your directory of choice

3) Follow the Ubuntu installation instructions from the available PDF on the page above, do this from the commandline of the directory where you extracted files from 2)
$ mkdir intel-opencl 
$ tar -C intel-opencl -Jxf intel-opencl-r3.1-BUILD_ID.x86_64.tar.xz 
$ tar -C intel-opencl -Jxf intel-opencl-devel-r3.1-BUILD_ID.x86_64.tar.xz 
$ tar -C intel-opencl -Jxf intel-opencl-cpu-r3.1-BUILD_ID.x86_64.tar.xz 
$ sudo cp -R intel-opencl/* / 
$ sudo ldconfig

4) run hashcat --benchmark to verify its working. 
(currently hashcat 3.10 exit with an error when testing SHA512 on my laptop. Will probably be fixed in 3.20 according to atom.)

Best regards,
Per Thorsheim
Founder of PasswordsCon 
```