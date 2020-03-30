#include <mcheck.h>
#include "mimo_wrappers.h"


void setup_mimo(void)
{
	/*
       $ gcc -g t_mtrace.c -o t_mtrace
       $ export MALLOC_TRACE=/tmp/t
       $ ./t_mtrace
       $ mtrace ./t_mtrace $MALLOC_TRACE
	 */
	mtrace();  // Necessary for mtrace to work
	return;
}


void teardown_mimo(void)
{
	return;  // Default behavior
}
