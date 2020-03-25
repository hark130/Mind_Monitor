#include "mimo_wrappers.h"
#include <dmalloc.h>


void setup_mimo(void)
{
    return;  // Default behavior
}


void teardown_mimo(void)
{
    /*
     *  This function shuts the library down and logs the final statistics and
     *  information especially the non-freed memory pointers.
     *
     *  From: https://dmalloc.com/docs/5.3.0/online/dmalloc_13.html
     */
    dmalloc_shutdown();
    return;  // Default behavior
}
