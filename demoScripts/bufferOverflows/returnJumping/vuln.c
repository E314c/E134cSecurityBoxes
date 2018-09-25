/** 
 * This is purposefully vulnerable code with an obvious buffer overflow.
 * When compiling, you will want to ensure you have disabled stack-canaries
*/
#include <stdio.h>
#include <string.h>

int getPassword(char *str ) {
    const char pass[10] = "Bypass";
    char localCopy[10];

    // copy the string so we don't modify it:
    strcpy(localCopy, str);

    // Process the password
    int i =0;
    for (i = 0; localCopy[i] != NULL && pass[i] != NULL; i++)
    {
        if (localCopy[i] != pass[i])
        {
            return 0;
        }
    }
    // Return
    return localCopy[i] == pass[i];
}

void printSuccess(){
    printf("Success !\n");
}

int main(int argc, char *argv[]) {
    if(argc < 2) {
        printf("This program requires an argument for comparison\n");
        return 1;
    }

    printf("String length given: %d\n", strlen(argv[1]));

    int correct = getPassword(argv[1]);

    if(correct) {
        printSuccess();
    } else {
        printf("Failure !\n");
    }
}