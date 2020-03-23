#include <stdio.h>          // printf()

#define BUF_SIZE 64


int main(void)
{
    /***********************************************************/
    /* 6. Unitialized memory part deux                         */
    /***********************************************************/
    // LOCAL VARIABLES
    int randoInt;

    // INITIALIZE IT
    // randoInt = 42;

    // PRINT
    printf("My integer is %d\n", randoInt);

    // DONE
    return 0;
}
