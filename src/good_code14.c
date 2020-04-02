#include <sys/types.h>      // pid_t
#include <pthread.h>        // pthread_create()
#include <stdio.h>          // fprintf()
#include <stdlib.h>         // exit(), free()
#include <string.h>         // strcpy()
#include "gimme_mem.h"      // gimme_mem_malloc()
#include "mimo_wrappers.h"  // setup_mimo(), teardown_mimo()

#define BUF_SIZE 64
#define START_STRING "ORIGINAL THREAD"
#define NEW_STRING "NEW THREAD"


/*
 *  Purpose - Encapsulate all the work the new thread will do
 */
void *execute_thread(void);


int main(void)
{
    /***********************************************************/
    /* 14. Multi-Thread (detached thread) Memory Leak          */
    /***********************************************************/
    // SETUP
    setup_mimo();

    // LOCAL VARIABLES
    pthread_t thread_id = 0;
    pthread_attr_t thread_attr;

    // CREATE THREAD ATTRIBUTES
    // Initialize
    if(!pthread_attr_init(&thread_attr))
    {
        printf("%s: Initialized thread attributes\n", START_STRING);
    }
    else
    {
        fprintf(stderr, "%s: Failed to initialize thread attribures\n", START_STRING);
    }
    // Set
    if (!pthread_attr_setdetachstate(&thread_attr, PTHREAD_CREATE_DETACHED))
    {
        printf("%s: Thread configured to detach\n", START_STRING);
    }
    else
    {
        fprintf(stderr, "%s: Failed to properly configure thread\n", START_STRING);
    }

    // SPAWN THREAD
    printf("%s: Creating new thread\n", START_STRING); 
    if(!pthread_create(&thread_id, NULL, (void *)execute_thread, NULL))
    {
        printf("%s: New thread successfully created\n", START_STRING);
    }
    else
    {
        fprintf(stderr, "%s: Failed to create new thread\n", START_STRING);
    }

    // CLEAN UP
    // Destroy thread attributes
    if(!pthread_attr_destroy(&thread_attr))
    {
        printf("%s: Destroyed thread attributes\n", START_STRING);
    }
    else
    {
        fprintf(stderr, "%s: Failed to destroy thread attribures\n", START_STRING);
    }

    // DONE
    teardown_mimo();
    exit(EXIT_SUCCESS);
}


void *execute_thread(void)
{
    // SETUP
    setup_mimo();

    // LOCAL VARIABLES
    char *bufLeak = (char *)gimme_mem_malloc((BUF_SIZE * sizeof(char)) + 1);

    // COPY
    strcpy(bufLeak, "Hello World!\n");

    // PRINT
    printf("%s: %s", NEW_STRING, bufLeak);

    // CLEAN UP
    free(bufLeak);

    // DONE
    teardown_mimo();
    return NULL;
}
