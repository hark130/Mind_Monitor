#include <stdio.h>          // printf()
#include <stdlib.h>         // free()
#include <string.h>         // strcpy()
#include "gimme_mem.h"      // gimme_mem_malloc()
#include "mimo_wrappers.h"  // setup_mimo(), teardown_mimo()

#define BUF_SIZE 64


int main(void)
{
    /***********************************************************/
    /* 8. Fishy values passed into malloc                      */
    /***********************************************************/
    // SETUP
    setup_mimo();

    // LOCAL VARIABLES
    char *bufFishyMalloc = (char *)gimme_mem_malloc(-1);

    // COPY
    strcpy(bufFishyMalloc, "Hello World!\n");

    // PRINT
    printf("%s", bufFishyMalloc);

    // CLEAN UP
    free(bufFishyMalloc);

    // DONE
    teardown_mimo();
    return 0;
}
