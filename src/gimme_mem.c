#include <stdlib.h>  // malloc
#include "gimme_mem.h"

void* gimme_mem_malloc(size_t bufSize)
{
	return malloc(bufSize);
}
