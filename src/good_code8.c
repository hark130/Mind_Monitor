#include <stdio.h>          // printf()
#include <stdlib.h>         // free()
#include <string.h>         // strcpy()
#include "gimme_mem.h"      // gimme_mem_malloc()

#define BUF_SIZE 64


int main(void)
{
    /***********************************************************/
    /* 8. Fishy values passed into malloc                      */
    /***********************************************************/
    // LOCAL VARIABLES
    char *bufFishyMalloc = (char *)gimme_mem_malloc((BUF_SIZE * sizeof(char)) + 1);

    // COPY
    strcpy(bufFishyMalloc, "Hello World!\n");

    // PRINT
    printf("%s", bufFishyMalloc);

    // CLEAN UP
    free(bufFishyMalloc);

    // DONE
    return 0;
}
