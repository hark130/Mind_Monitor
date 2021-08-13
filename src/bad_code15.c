#include <sys/types.h>      // pid_t
#include <sys/wait.h>       // waitpid()
#include <stdio.h>          // fprintf()
#include <stdlib.h>         // exit(), free()
#include <string.h>         // strcpy()
#include <unistd.h>         // fork()
#include "gimme_mem.h"      // gimme_mem_malloc()
#include "mimo_wrappers.h"  // setup_mimo(), teardown_mimo()

#define BUF_SIZE 64


void double_free(char *buf)
{
    // PRINT
    printf("CHILD: %s", buf);
    free(buf);
}


/*
 *  Purpose - Encapsulate all the work the child process will do
 */
int execute_child(void);


int main(void)
{
    /***********************************************************/
    /* 11. Multi-Process Double Free                           */
    /***********************************************************/
    // SETUP
    setup_mimo();

    // LOCAL VARIABLES
    pid_t pid = 0;             // Process IDentifier
    pid_t wait_ret = 0;        // Return value from waitpid()
    int status = 0;            // Child PID status information
    int parent_exit_code = 0;  // Exit code for the child process

    // PARENT WORK
    // Fork off the parent process
    pid = fork();
    if (pid < 0)
    {
        fprintf(stderr, "PARENT: Failed to fork!\n");
        parent_exit_code = EXIT_FAILURE;  // Error
    }
    else if (pid > 0)
    {
        fprintf(stdout, "PARENT: Fork successful\n");
        wait_ret = waitpid(pid, &status, 0);
        if (-1 == wait_ret)
        {
            fprintf(stderr, "PARENT: waitpid() failed!\n");
            parent_exit_code = EXIT_FAILURE;  // Error
        }
        else if (wait_ret != pid)
        {
            fprintf(stderr, "PARENT: Unexpected return from waitpid()!\n");
            parent_exit_code = EXIT_FAILURE;  // Error
        }
        else if (WIFEXITED(status))
        {
            parent_exit_code = WEXITSTATUS(status);
        }
    }
    else
    {
        execute_child();
    }

    // PARENT CLEAN UP
    teardown_mimo();
    exit(parent_exit_code);
}


int execute_child(void)
{
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
    exit(EXIT_SUCCESS);
}
