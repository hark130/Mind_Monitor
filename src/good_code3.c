#include <stdio.h>          // printf()
#include <stdlib.h>         // free()
#include <string.h>         // strcpy()
#include "gimme_mem.h"      // gimme_mem_malloc()

#define BUF_SIZE 64


int main(void)
{
    /***********************************************************/
    /* 3. Memory Leak                                          */
    /***********************************************************/
    // LOCAL VARIABLES
    char *bufLeak = (char *)gimme_mem_malloc((BUF_SIZE * sizeof(char)) + 1);

    // COPY
    strcpy(bufLeak, "Hello World!\n");

    // PRINT
    printf("%s", bufLeak);

    // CLEAN UP
    free(bufLeak);

    // DONE
    return 0;
}
