#include <stdio.h>          // printf()
#include <stdlib.h>         // free()
#include <string.h>         // strcpy()
#include "gimme_mem.h"      // gimme_mem_malloc()
#include "mimo_wrappers.h"  // setup_mimo(), teardown_mimo()

#define BUF_SIZE 64


int main(void)
{
    /***********************************************************/
    /* 2. Invalid write of size 1 (OVERFLOW)                   */
    /***********************************************************/
    // SETUP
    setup_mimo();

    // LOCAL VARIABLES
    char strLiteral[] = {"Hello World!\n"};
    char *bufOverwrite = (char *)gimme_mem_malloc(sizeof(strLiteral));

    // COPY
    strcpy(bufOverwrite, strLiteral);

    // PRINT
    printf("%s", bufOverwrite);

    // CLEAN UP
    free(bufOverwrite);

    // DONE
    teardown_mimo();
    return 0;
}
