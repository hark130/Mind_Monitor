CC = gcc
CFLAGS=-Wall
MTRACE_FLAGS=-g
DMALLOC_FLAGS=-DDMALLOC -DDMALLOC_FUNC_CHECK -DMIMO_DMALLOC
EFENCE_FLAGS=-g
MEMWATCH_FLAGS=-DMEMWATCH -DMW_STDIO -g
DIST = ./dist/
LOGS = ./devops/logs/
CODE = ./src/

library:
	$(CC) -o $(DIST)memwatch.o -c $(CODE)memwatch.c
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
	$(CC) $(CFLAGS) $(EFENCE_FLAGS) -o $(DIST)good_code1_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)good_code1.c -lefence
	$(CC) $(CFLAGS) $(MEMWATCH_FLAGS) -o $(DIST)good_code1_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)good_code1.c

bad1:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code1.o -c $(CODE)bad_code1.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code1.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)bad_code1.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)bad_code1_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)bad_code1.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)bad_code1_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)bad_code1.c -ldmallocth
	$(CC) $(CFLAGS) $(EFENCE_FLAGS) -o $(DIST)bad_code1_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)bad_code1.c -lefence
	$(CC) $(CFLAGS) $(MEMWATCH_FLAGS) -o $(DIST)bad_code1_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)bad_code1.c

good2:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code2.o -c $(CODE)good_code2.c
	$(CC) $(CFLAGS) -o $(DIST)good_code2.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)good_code2.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)good_code2_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)good_code2.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)good_code2_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)good_code2.c -ldmallocth
	$(CC) $(CFLAGS) $(EFENCE_FLAGS) -o $(DIST)good_code2_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)good_code2.c -lefence
	$(CC) $(CFLAGS) $(MEMWATCH_FLAGS) -o $(DIST)good_code2_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)good_code2.c

bad2:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code2.o -c $(CODE)bad_code2.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code2.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)bad_code2.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)bad_code2_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)bad_code2.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)bad_code2_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)bad_code2.c -ldmallocth
	$(CC) $(CFLAGS) $(EFENCE_FLAGS) -o $(DIST)bad_code2_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)bad_code2.c -lefence
	$(CC) $(CFLAGS) $(MEMWATCH_FLAGS) -o $(DIST)bad_code2_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)bad_code2.c

good3:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code3.o -c $(CODE)good_code3.c
	$(CC) $(CFLAGS) -o $(DIST)good_code3.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)good_code3.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)good_code3_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)good_code3.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)good_code3_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)good_code3.c -ldmallocth
	$(CC) $(CFLAGS) $(EFENCE_FLAGS) -o $(DIST)good_code3_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)good_code3.c -lefence
	$(CC) $(CFLAGS) $(MEMWATCH_FLAGS) -o $(DIST)good_code3_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)good_code3.c

bad3:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code3.o -c $(CODE)bad_code3.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code3.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)bad_code3.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)bad_code3_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)bad_code3.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)bad_code3_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)bad_code3.c -ldmallocth
	$(CC) $(CFLAGS) $(EFENCE_FLAGS) -o $(DIST)bad_code3_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)bad_code3.c -lefence
	$(CC) $(CFLAGS) $(MEMWATCH_FLAGS) -o $(DIST)bad_code3_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)bad_code3.c

good4:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code4.o -c $(CODE)good_code4.c
	$(CC) $(CFLAGS) -o $(DIST)good_code4.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)good_code4.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)good_code4_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)good_code4.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)good_code4_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)good_code4.c -ldmallocth
	$(CC) $(CFLAGS) $(EFENCE_FLAGS) -o $(DIST)good_code4_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)good_code4.c -lefence
	$(CC) $(CFLAGS) $(MEMWATCH_FLAGS) -o $(DIST)good_code4_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)good_code4.c

bad4:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code4.o -c $(CODE)bad_code4.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code4.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)bad_code4.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)bad_code4_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)bad_code4.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)bad_code4_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)bad_code4.c -ldmallocth
	$(CC) $(CFLAGS) $(EFENCE_FLAGS) -o $(DIST)bad_code4_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)bad_code4.c -lefence
	$(CC) $(CFLAGS) $(MEMWATCH_FLAGS) -o $(DIST)bad_code4_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)bad_code4.c

good5:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code5.o -c $(CODE)good_code5.c
	$(CC) $(CFLAGS) -o $(DIST)good_code5.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)good_code5.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)good_code5_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)good_code5.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)good_code5_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)good_code5.c -ldmallocth
	$(CC) $(CFLAGS) $(EFENCE_FLAGS) -o $(DIST)good_code5_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)good_code5.c -lefence
	$(CC) $(CFLAGS) $(MEMWATCH_FLAGS) -o $(DIST)good_code5_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)good_code5.c

bad5:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code5.o -c $(CODE)bad_code5.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code5.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)bad_code5.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)bad_code5_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)bad_code5.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)bad_code5_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)bad_code5.c -ldmallocth
	$(CC) $(CFLAGS) $(EFENCE_FLAGS) -o $(DIST)bad_code5_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)bad_code5.c -lefence
	$(CC) $(CFLAGS) $(MEMWATCH_FLAGS) -o $(DIST)bad_code5_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)bad_code5.c

good6:
	$(MAKE) library
	$(CC) -o $(DIST)good_code6.bin $(DIST)mimo_wrappers.o $(CODE)good_code6.c
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)good_code6_mtrace.bin $(DIST)mimo_wrappers_mtrace.o $(CODE)good_code6.c
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)good_code6_dmalloc.bin $(DIST)mimo_wrappers_dmalloc.o $(CODE)good_code6.c -ldmallocth
	$(CC) $(CFLAGS) $(EFENCE_FLAGS) -o $(DIST)good_code6_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)good_code6.c -lefence
	$(CC) $(CFLAGS) $(MEMWATCH_FLAGS) -o $(DIST)good_code6_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)good_code6.c

bad6:
	$(MAKE) library
	# Removed $(CFLAGS) to avoid compiler warning about the bad code
	$(CC) -o $(DIST)bad_code6.bin $(DIST)mimo_wrappers.o $(CODE)bad_code6.c
	# Removed $(CFLAGS) to avoid compiler warning about the bad code
	$(CC) $(MTRACE_FLAGS) -o $(DIST)bad_code6_mtrace.bin $(DIST)mimo_wrappers_mtrace.o $(CODE)bad_code6.c
	# Removed $(CFLAGS) to avoid compiler warning about the bad code
	$(CC) $(DMALLOC_FLAGS) -o $(DIST)bad_code6_dmalloc.bin $(DIST)mimo_wrappers_dmalloc.o $(CODE)bad_code6.c -ldmallocth
	# Removed $(CFLAGS) to avoid compiler warning about the bad code
	$(CC) $(EFENCE_FLAGS) -o $(DIST)bad_code6_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)bad_code6.c -lefence
	# Removed $(CFLAGS) to avoid compiler warning about the bad code
	$(CC) $(MEMWATCH_FLAGS) -o $(DIST)bad_code6_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)bad_code6.c

good7:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code7.o -c $(CODE)good_code7.c
	$(CC) $(CFLAGS) -o $(DIST)good_code7.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)good_code7.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)good_code7_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)good_code7.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)good_code7_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)good_code7.c -ldmallocth
	$(CC) $(CFLAGS) $(EFENCE_FLAGS) -o $(DIST)good_code7_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)good_code7.c -lefence
	$(CC) $(CFLAGS) $(MEMWATCH_FLAGS) -o $(DIST)good_code7_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)good_code7.c

bad7:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code7.o -c $(CODE)bad_code7.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code7.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)bad_code7.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)bad_code7_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)bad_code7.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)bad_code7_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)bad_code7.c -ldmallocth
	$(CC) $(CFLAGS) $(EFENCE_FLAGS) -o $(DIST)bad_code7_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)bad_code7.c -lefence
	$(CC) $(CFLAGS) $(MEMWATCH_FLAGS) -o $(DIST)bad_code7_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)bad_code7.c

good8:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code8.o -c $(CODE)good_code8.c
	$(CC) $(CFLAGS) -o $(DIST)good_code8.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)good_code8.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)good_code8_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)good_code8.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)good_code8_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)good_code8.c -ldmallocth
	$(CC) $(CFLAGS) $(EFENCE_FLAGS) -o $(DIST)good_code8_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)good_code8.c -lefence
	$(CC) $(CFLAGS) $(MEMWATCH_FLAGS) -o $(DIST)good_code8_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)good_code8.c

bad8:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code8.o -c $(CODE)bad_code8.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code8.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)bad_code8.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)bad_code8_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)bad_code8.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)bad_code8_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)bad_code8.c -ldmallocth
	$(CC) $(CFLAGS) $(EFENCE_FLAGS) -o $(DIST)bad_code8_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)bad_code8.c -lefence
	$(CC) $(CFLAGS) $(MEMWATCH_FLAGS) -o $(DIST)bad_code8_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)bad_code8.c

good9:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code9.o -c $(CODE)good_code9.c
	$(CC) $(CFLAGS) -o $(DIST)good_code9.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)good_code9.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)good_code9_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)good_code9.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)good_code9_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)good_code9.c -ldmallocth
	$(CC) $(CFLAGS) $(EFENCE_FLAGS) -o $(DIST)good_code9_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)good_code9.c -lefence
	$(CC) $(CFLAGS) $(MEMWATCH_FLAGS) -o $(DIST)good_code9_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)good_code9.c

bad9:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code9.o -c $(CODE)bad_code9.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code9.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)bad_code9.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)bad_code9_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)bad_code9.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)bad_code9_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)bad_code9.c -ldmallocth
	$(CC) $(CFLAGS) $(EFENCE_FLAGS) -o $(DIST)bad_code9_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)bad_code9.c -lefence
	$(CC) $(CFLAGS) $(MEMWATCH_FLAGS) -o $(DIST)bad_code9_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)bad_code9.c

good10:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code10.o -c $(CODE)good_code10.c
	$(CC) $(CFLAGS) -o $(DIST)good_code10.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)good_code10.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)good_code10_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)good_code10.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)good_code10_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)good_code10.c -ldmallocth
	$(CC) $(CFLAGS) $(EFENCE_FLAGS) -o $(DIST)good_code10_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)good_code10.c -lefence
	$(CC) $(CFLAGS) $(MEMWATCH_FLAGS) -o $(DIST)good_code10_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)good_code10.c

bad10:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code10.o -c $(CODE)bad_code10.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code10.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)bad_code10.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)bad_code10_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)bad_code10.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)bad_code10_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)bad_code10.c -ldmallocth
	$(CC) $(CFLAGS) $(EFENCE_FLAGS) -o $(DIST)bad_code10_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)bad_code10.c -lefence
	$(CC) $(CFLAGS) $(MEMWATCH_FLAGS) -o $(DIST)bad_code10_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)bad_code10.c

good11:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code11.o -c $(CODE)good_code11.c
	$(CC) $(CFLAGS) -o $(DIST)good_code11.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)good_code11.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)good_code11_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)good_code11.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)good_code11_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)good_code11.c -ldmallocth
	$(CC) $(CFLAGS) $(EFENCE_FLAGS) -o $(DIST)good_code11_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)good_code11.c -lefence
	$(CC) $(CFLAGS) $(MEMWATCH_FLAGS) -o $(DIST)good_code11_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)good_code11.c

bad11:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code11.o -c $(CODE)bad_code11.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code11.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)bad_code11.o
	$(CC) $(CFLAGS) $(MTRACE_FLAGS) -o $(DIST)bad_code11_mtrace.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers_mtrace.o $(DIST)bad_code11.o
	$(CC) $(CFLAGS) $(DMALLOC_FLAGS) -o $(DIST)bad_code11_dmalloc.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers_dmalloc.o $(CODE)bad_code11.c -ldmallocth
	$(CC) $(CFLAGS) $(EFENCE_FLAGS) -o $(DIST)bad_code11_efence.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(CODE)bad_code11.c -lefence
	$(CC) $(CFLAGS) $(MEMWATCH_FLAGS) -o $(DIST)bad_code11_memwatch.bin $(CODE)gimme_mem.c $(DIST)mimo_wrappers.o $(DIST)memwatch.o $(CODE)bad_code11.c

good12:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code12.o -c $(CODE)good_code12.c
	$(CC) $(CFLAGS) -o $(DIST)good_code12.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)good_code12.o -pthread

bad12:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code12.o -c $(CODE)bad_code12.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code12.bin $(DIST)gimme_mem.o $(DIST)mimo_wrappers.o $(DIST)bad_code12.o -pthread

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
	$(MAKE) good10
	$(MAKE) good11
	$(MAKE) good12

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
	$(MAKE) bad10
	$(MAKE) bad11
	$(MAKE) bad12

all:
	$(MAKE) clean
	$(MAKE) all_good
	$(MAKE) all_bad

clean_good_logs:
	@rm -f $(LOGS)good*.log

clean_bad_logs:
	@rm -f $(LOGS)bad*.log

clean_logs:
	@$(MAKE) clean_good_logs
	@$(MAKE) clean_bad_logs

clean:
	@$(MAKE) clean_logs > /dev/null 2>&1
	@rm -f $(DIST)*.o $(DIST)*.exe $(DIST)*.bin $(DIST)*.lib $(DIST)*.so
