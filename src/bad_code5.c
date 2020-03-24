#include <stdio.h>          // printf()
#include <stdlib.h>         // free()
#include <string.h>         // strcpy(), memset()
#include "gimme_mem.h"      // gimme_mem_malloc()
#include "mimo_wrappers.h"  // setup_mimo(), teardown_mimo()

#define BUF_SIZE 64


void double_free(char *buf)
{
    // PRINT
    printf("%s", buf);
    free(buf);
}


int main(void)
{
    /***********************************************************/
    /* 5. Double Free                                          */
    /***********************************************************/
    // SETUP
    setup_mimo();

    // LOCAL VARIABLES
    char *bufDbleFree = (char *)gimme_mem_malloc((BUF_SIZE * sizeof(char)) + 1);

    // COPY
    strcpy(bufDbleFree, "Hello World!\n");

    // PRINT
    double_free(bufDbleFree);

    // CLEAN UP
    free(bufDbleFree);

    // DONE
    teardown_mimo();
    return 0;
}
