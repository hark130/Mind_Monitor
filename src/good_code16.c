#include <stdio.h>          // printf()
#include <stdlib.h>         // free()
#include <string.h>         // strcpy()
#include "gimme_mem.h"      // gimme_mem_malloc()
#include "mimo_wrappers.h"  // setup_mimo(), teardown_mimo()

#define BUF_SIZE 64


int main(void)
{
    /***********************************************************/
    /* 16. Invalid write of size 1 (STACK OVERFLOW)            */
    /***********************************************************/
    // SETUP
    setup_mimo();

    // LOCAL VARIABLES
    char bufOverwrite[BUF_SIZE + 1] = {0};

    // COPY
    strcpy(bufOverwrite, "Hello World!\n");

    // PRINT
    printf("%s", bufOverwrite);

    // DONE
    teardown_mimo();
    return 0;
}
