CC = gcc
CFLAGS=-Wall
MTRACE_FLAGS=-g
DMALLOC_FLAGS=-DDMALLOC -DDMALLOC_FUNC_CHECK -DMIMO_DMALLOC
DIST = ./dist/
CODE = ./src/

library:
	$(CC) $(CFLAGS) -o $(DIST)gimme_mem.o -c $(CODE)gimme_mem.c
	$(CC) $(CFLAGS) -o $(DIST)mimo_wrappers.o -c $(CODE)mimo_wrappers.c
	$(CC) $(CFLAGS) -o $(DIST)mimo_wrappers_mtrace.o -c $(CODE)mimo_wrappers_mtrace.c
	$(CC) $(CFLAGS) -o $(DIST)mimo_wrappers_dmalloc.o -c $(CODE)mimo_wrappers_dmalloc.c

good1:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code1.o -c $(CODE)good_code1.c
	$(CC) $(CFLAGS) -o $(DIST)good_code1.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)good_code1.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)good_code1_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)good_code1.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)good_code1_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)good_code1.c -ldmallocth

bad1:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code1.o -c $(CODE)bad_code1.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code1.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)bad_code1.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)bad_code1_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)bad_code1.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)bad_code1_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)bad_code1.c -ldmallocth

good2:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code2.o -c $(CODE)good_code2.c
	$(CC) $(CFLAGS) -o $(DIST)good_code2.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)good_code2.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)good_code2_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)good_code2.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)good_code2_dmalloc.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_dmalloc.o $(CODE)good_code2.c -ldmallocth

bad2:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code2.o -c $(CODE)bad_code2.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code2.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)bad_code2.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)bad_code2_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)bad_code2.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)bad_code2_dmalloc.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_dmalloc.o $(CODE)bad_code2.c -ldmallocth

good3:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code3.o -c $(CODE)good_code3.c
	$(CC) $(CFLAGS) -o $(DIST)good_code3.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)good_code3.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)good_code3_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)good_code3.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)good_code3_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)good_code3.c -ldmallocth

bad3:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code3.o -c $(CODE)bad_code3.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code3.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)bad_code3.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)bad_code3_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)bad_code3.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)bad_code3_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)bad_code3.c -ldmallocth

good4:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code4.o -c $(CODE)good_code4.c
	$(CC) $(CFLAGS) -o $(DIST)good_code4.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)good_code4.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)good_code4_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)good_code4.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)good_code4_dmalloc.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_dmalloc.o $(CODE)good_code4.c -ldmallocth

bad4:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code4.o -c $(CODE)bad_code4.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code4.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)bad_code4.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)bad_code4_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)bad_code4.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)bad_code4_dmalloc.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_dmalloc.o $(CODE)bad_code4.c -ldmallocth

good5:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code5.o -c $(CODE)good_code5.c
	$(CC) $(CFLAGS) -o $(DIST)good_code5.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)good_code5.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)good_code5_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)good_code5.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)good_code5_dmalloc.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_dmalloc.o $(CODE)good_code5.c -ldmallocth

bad5:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code5.o -c $(CODE)bad_code5.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code5.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)bad_code5.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)bad_code5_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)bad_code5.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)bad_code5_dmalloc.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_dmalloc.o $(CODE)bad_code5.c -ldmallocth

good6:
	$(MAKE) library
	$(CC) -o $(DIST)good_code6.bin $(DIST)mimo_wrappers.o $(CODE)good_code6.c
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)good_code6_mtrace.bin $(DIST)mimo_wrappers_mtrace.o $(CODE)good_code6.c
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)good_code6_dmalloc.bin $(DIST)mimo_wrappers_dmalloc.o $(CODE)good_code6.c -ldmallocth

bad6:
	$(MAKE) library
	$(CC) -o $(DIST)bad_code6.bin $(DIST)mimo_wrappers.o $(CODE)bad_code6.c
	# Removed $(CFLAGS) to avoid compiler warning about the bad code
	$(CC) $(MTRACE_FLAGS) -o $(DIST)bad_code6_mtrace.bin $(DIST)mimo_wrappers_mtrace.o $(CODE)bad_code6.c
	# Removed $(CFLAGS) to avoid compiler warning about the bad code
	$(CC) $(DMALLOC_FLAGS) -o $(DIST)bad_code6_dmalloc.bin $(DIST)mimo_wrappers_dmalloc.o $(CODE)bad_code6.c -ldmallocth

good7:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code7.o -c $(CODE)good_code7.c
	$(CC) $(CFLAGS) -o $(DIST)good_code7.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)good_code7.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)good_code7_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)good_code7.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)good_code7_dmalloc.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_dmalloc.o $(CODE)good_code7.c -ldmallocth

bad7:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code7.o -c $(CODE)bad_code7.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code7.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)bad_code7.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)bad_code7_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)bad_code7.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)bad_code7_dmalloc.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_dmalloc.o $(CODE)bad_code7.c -ldmallocth

good8:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code8.o -c $(CODE)good_code8.c
	$(CC) $(CFLAGS) -o $(DIST)good_code8.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)good_code8.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)good_code8_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)good_code8.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)good_code8_dmalloc.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_dmalloc.o $(CODE)good_code8.c -ldmallocth

bad8:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code8.o -c $(CODE)bad_code8.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code8.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)bad_code8.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)bad_code8_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)bad_code8.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)bad_code8_dmalloc.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_dmalloc.o $(CODE)bad_code8.c -ldmallocth

good9:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code9.o -c $(CODE)good_code9.c
	$(CC) $(CFLAGS) -o $(DIST)good_code9.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)good_code9.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)good_code9_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)good_code9.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)good_code9_dmalloc.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_dmalloc.o $(CODE)good_code9.c -ldmallocth

bad9:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code9.o -c $(CODE)bad_code9.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code9.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)bad_code9.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)bad_code9_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)bad_code9.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)bad_code9_dmalloc.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_dmalloc.o $(CODE)bad_code9.c -ldmallocth

all_good:
	$(MAKE) good1
	$(MAKE) good2
	$(MAKE) good3
	$(MAKE) good4
	$(MAKE) good5
	$(MAKE) good6
	$(MAKE) good7
	$(MAKE) good8
	$(MAKE) good9

all_bad:
	$(MAKE) bad1
	$(MAKE) bad2
	$(MAKE) bad3
	$(MAKE) bad4
	$(MAKE) bad5
	$(MAKE) bad6
	$(MAKE) bad7
	$(MAKE) bad8
	$(MAKE) bad9

all:
	$(MAKE) clean
	$(MAKE) all_good
	$(MAKE) all_bad

clean: 
	rm -f $(DIST)*.o $(DIST)*.exe $(DIST)*.bin $(DIST)*.lib $(DIST)*.so
