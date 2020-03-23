#include <stdio.h>          // printf()
#include <stdlib.h>         // free()
#include <string.h>         // strcpy()
#include "gimme_mem.h"      // gimme_mem_malloc()
#include "mimo_wrappers.h"  // setup_mimo(), teardown_mimo()

#define BUF_SIZE 64


int main(void)
{
    /***********************************************************/
    /* 9. Fishy values passed into calloc                      */
    /***********************************************************/
    // SETUP
    setup_mimo();

    // LOCAL VARIABLES
    char *bufFishyCalloc = (char *)gimme_mem_calloc((BUF_SIZE * sizeof(char)) + 1);

    // COPY
    strcpy(bufFishyCalloc, "Hello World!\n");

    // PRINT
    printf("%s", bufFishyCalloc);

    // CLEAN UP
    free(bufFishyCalloc);

    // DONE
    teardown_mimo();
    return 0;
}
