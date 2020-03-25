#include <stdlib.h>  		// calloc(), malloc()
#include "gimme_mem.h"


void* gimme_mem_calloc(size_t bufSize)
{
	return calloc(1, bufSize);
}


void* gimme_mem_malloc(size_t bufSize)
{
	return malloc(bufSize);
}
