#include <stdio.h>          // printf()
#include <stdlib.h>         // free()
#include <string.h>         // memcpy()
#include "gimme_mem.h"      // gimme_mem_malloc()
#include "mimo_wrappers.h"  // setup_mimo(), teardown_mimo()

#define BUF_SIZE 64


int main(void)
{
    /***********************************************************/
    /* 7. Overlapping src and dst pointers in memcpy           */
    /***********************************************************/
    // SETUP
    setup_mimo();

    // LOCAL VARIABLES
    char sourceBuf[] = {'H', 'e', 'l', 'l', 'o', ' ', 'W', 'o', 'r', 'l', 'd', '!', '\n'};
    size_t sourceSize = sizeof(sourceBuf);
    char *bufOverlapCopy = (char *)gimme_mem_calloc((BUF_SIZE * sizeof(char)) + 1);

    // COPY
    memcpy(bufOverlapCopy, sourceBuf, sourceSize);
    memcpy(bufOverlapCopy + sourceSize, bufOverlapCopy, sourceSize);

    // PRINT
    printf("%s", bufOverlapCopy);

    // CLEAN UP
    free(bufOverlapCopy);

    // DONE
    teardown_mimo();
    return 0;
}
