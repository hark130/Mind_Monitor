#include <stdio.h>          // printf()
#include "mimo_wrappers.h"  // setup_mimo(), teardown_mimo()

#define BUF_SIZE 64


int main(void)
{
    /***********************************************************/
    /* 6. Unitialized memory part deux                         */
    /***********************************************************/
    // SETUP
    setup_mimo();

    // LOCAL VARIABLES
    int randoInt;

    // INITIALIZE IT
    randoInt = 42;

    // PRINT
    printf("My integer is %d\n", randoInt);

    // DONE
    teardown_mimo();
    return 0;
}
