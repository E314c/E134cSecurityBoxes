#!/bin/sh
#!/bin/bash
# -- Password hasher -- #
# FOR DEMO PURPOSES ONLY #

#Do some input validation?


#Loop through given file and, for each line, hash it and append to output file
echo "Input file is: $1";
echo "Outputting to: $2";
cat $1 | while read password

do
        shortPass=`echo $password | head -c 20` 
        echo -en "\r\e[KHashing $shortPass"; 
        # echo the password to stndin, so we can pipe into md5sum
        # only take the first 32 chars (as md5sum likes to append extra bits)
        # append that to the output file specified
        # add a new line.
        
        # MD5
        echo -n $password | md5sum | head -c 32 >> "$2.md5";
        echo "">> "$2.md5";
        
        # SHA512
        echo -n $password | openssl sha512 | head -c 32 >> "$2.sha512";
        echo "">> "$2.sha512";
	
        # Php default (bcrypt)
        php -r "echo(password_hash('$password', PASSWORD_DEFAULT));" >> "$2.phpDefaultHash";
        echo "">> "$2.phpDefaultHash";

done
echo -e "\r\e[KFinished               "
