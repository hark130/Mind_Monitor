#include <stdio.h>          // printf()
#include <stdlib.h>         // free()
#include <string.h>         // strcpy()
#include "gimme_mem.h"      // gimme_mem_malloc()
#include "mimo_wrappers.h"  // setup_mimo(), teardown_mimo()

#define BUF_SIZE 64


int main(void)
{
    /***********************************************************/
    /* 1. Utilizing unitialized memory                         */
    /***********************************************************/
    // SETUP
    setup_mimo();

    // LOCAL VARIABLES
    char *bufUninit = (char *)gimme_mem_malloc((BUF_SIZE * sizeof(char)) + 1);

    // COPY
    // strcpy(bufUninit, "Hello World!\n");

    // PRINT
    printf("%s", bufUninit);

    // CLEAN UP
    free(bufUninit);

    // DONE
    teardown_mimo();
    return 0;
}
