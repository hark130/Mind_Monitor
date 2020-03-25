#ifndef __GIMME_MEM__
#define __GIMME_MEM__

#ifdef MIMO_DMALLOC
#include <dmalloc.h>
#endif  // MIMO_DMALLOC


/*
 * Purpose - Use calloc to allocate heap memory
 */
void* gimme_mem_calloc(size_t bufSize);


/*
 * Purpose - Use malloc to allocate heap memory
 */
void* gimme_mem_malloc(size_t bufSize);


#endif  // __GIMME_MEM__
