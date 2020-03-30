#ifndef __MIMO_WRAPPERS_H__
#define __MIMO_WRAPPERS_H__

#ifdef MIMO_DMALLOC
#include <dmalloc.h>
#endif  // MIMO_DMALLOC

#ifdef MEMWATCH
#include "memwatch.h"
#endif  // MEMWATCH


/*
 * Purpose - Modular wrapper to handle debugger setup with minimal code
 *	change.
 */
void setup_mimo(void);


/*
 * Purpose - Modular wrapper to handle debugger teardown with minimal code
 *	change.
 */
void teardown_mimo(void);


#endif  // __MIMO_WRAPPERS_H__
