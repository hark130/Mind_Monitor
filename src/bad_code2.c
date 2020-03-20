#include <stdio.h>          // printf()
#include <stdlib.h>         // free()
#include <string.h>         // strcpy()
#include "gimme_mem.h"      // gimme_mem_malloc()

#define BUF_SIZE 64


int main(void)
{
    /***********************************************************/
    /* 2. Invalid write of size 1 (OVERFLOW)                   */
    /***********************************************************/
    // LOCAL VARIABLES
    char strLiteral[] = {"Hello World!\n"};
    char *bufOverwrite = (char *)gimme_mem_malloc(sizeof(strLiteral) - 1);

    // COPY
    strcpy(bufOverwrite, strLiteral);

    // PRINT
    printf("%s", bufOverwrite);

    // CLEAN UP
    free(bufOverwrite);

    // DONE
    return 0;
}
