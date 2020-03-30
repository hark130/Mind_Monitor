#include <sys/types.h>      // pid_t
#include <stdio.h>          // fprintf()
#include <stdlib.h>         // exit(), free()
#include <string.h>         // strcpy()
#include <unistd.h>         // fork()
#include "gimme_mem.h"      // gimme_mem_malloc()
#include "mimo_wrappers.h"  // setup_mimo(), teardown_mimo()

#define BUF_SIZE 64


/*
 *  Purpose - Encapsulate all the work the child process will do
 */
int execute_child(void);


int main(void)
{
    /***********************************************************/
    /* 10. Multi-Threaded Memory Leak                          */
    /***********************************************************/
    // LOCAL VARIABLES
    pid_t pid = 0;  // Process IDentifier

    // PARENT WORK
    // Fork off the parent process
    pid = fork();
    if (pid < 0)
    {
        fprintf(stderr, "PARENT: Failed to fork!\n");
        exit(EXIT_FAILURE);  // Error
    }
    else if (pid > 0)
    {
        fprintf(stdout, "PARENT: Fork successful\n");
        exit(EXIT_SUCCESS);  // Child process successfully forked
    }

    execute_child();
}


int execute_child(void)
{
    // SETUP
    setup_mimo();

    // LOCAL VARIABLES
    char *bufLeak = (char *)gimme_mem_malloc((BUF_SIZE * sizeof(char)) + 1);

    // COPY
    strcpy(bufLeak, "Hello World!\n");

    // PRINT
    printf("CHILD: %s", bufLeak);

    // CLEAN UP
    free(bufLeak);

    // DONE
    teardown_mimo();
    exit(EXIT_SUCCESS);
}
