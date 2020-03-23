CC = gcc
CFLAGS=-Wall
DIST = ./dist/
CODE = ./src/

library:
# 	echo "\nBUILD LIBRARY\n"
	$(CC) $(CFLAGS) -o $(DIST)gimme_mem.o -c $(CODE)gimme_mem.c

good1:
# 	$(MAKE) clean
	$(MAKE) library
# 	echo "\nBUILD GOOD\n"
	$(CC) $(CFLAGS) -o $(DIST)good_code1.o -c $(CODE)good_code1.c
	$(CC) $(CFLAGS) -o $(DIST)good_code1.bin $(DIST)gimme_mem.o $(DIST)good_code1.o
# 	echo "\nEXECUTE GOOD\n"
# 	./$(DIST)good_code1.bin
# 	echo "\nVALGRIND GOOD\n"
# 	valgrind -v --leak-check=full --track-origins=yes --tool=memcheck $(DIST)good_code1.bin

bad1:
# 	$(MAKE) clean
	$(MAKE) library
# 	echo "\nBUILD BAD\n"
	$(CC) $(CFLAGS) -o $(DIST)bad_code1.o -c $(CODE)bad_code1.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code1.bin $(DIST)gimme_mem.o $(DIST)bad_code1.o
# 	echo "\nEXECUTE BAD\n"
# 	./$(DIST)bad_code1.bin
# 	echo "\nVALGRIND BAD\n"
# 	valgrind -v --leak-check=full --track-origins=yes --tool=memcheck $(DIST)bad_code1.bin

good2:
# 	$(MAKE) clean
	$(MAKE) library
# 	echo "\nBUILD GOOD\n"
	$(CC) $(CFLAGS) -o $(DIST)good_code2.o -c $(CODE)good_code2.c
	$(CC) $(CFLAGS) -o $(DIST)good_code2.bin $(DIST)gimme_mem.o $(DIST)good_code2.o
# 	echo "\nEXECUTE GOOD\n"
# 	./$(DIST)good_code2.bin
# 	echo "\nVALGRIND GOOD\n"
# 	valgrind -v --leak-check=full --track-origins=yes --tool=memcheck $(DIST)good_code2.bin

bad2:
# 	$(MAKE) clean
	$(MAKE) library
# 	echo "\nBUILD BAD\n"
	$(CC) $(CFLAGS) -o $(DIST)bad_code2.o -c $(CODE)bad_code2.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code2.bin $(DIST)gimme_mem.o $(DIST)bad_code2.o
# 	echo "\nEXECUTE BAD\n"
# 	./$(DIST)bad_code2.bin
# 	echo "\nVALGRIND BAD\n"
# 	valgrind -v --leak-check=full --track-origins=yes --tool=memcheck $(DIST)bad_code2.bin

good3:
# 	$(MAKE) clean
	$(MAKE) library
# 	echo "\nBUILD GOOD\n"
	$(CC) $(CFLAGS) -o $(DIST)good_code3.o -c $(CODE)good_code3.c
	$(CC) $(CFLAGS) -o $(DIST)good_code3.bin $(DIST)gimme_mem.o $(DIST)good_code3.o
# 	echo "\nEXECUTE GOOD\n"
# 	./$(DIST)good_code3.bin
# 	echo "\nVALGRIND GOOD\n"
# 	valgrind -v --leak-check=full --track-origins=yes --tool=memcheck $(DIST)good_code3.bin

bad3:
# 	$(MAKE) clean
	$(MAKE) library
# 	echo "\nBUILD BAD\n"
	$(CC) $(CFLAGS) -o $(DIST)bad_code3.o -c $(CODE)bad_code3.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code3.bin $(DIST)gimme_mem.o $(DIST)bad_code3.o
# 	echo "\nEXECUTE BAD\n"
# 	./$(DIST)bad_code3.bin
# 	echo "\nVALGRIND BAD\n"
# 	valgrind -v --leak-check=full --track-origins=yes --tool=memcheck --error-exitcode=1 $(DIST)bad_code3.bin

good4:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code4.o -c $(CODE)good_code4.c
	$(CC) $(CFLAGS) -o $(DIST)good_code4.bin $(DIST)gimme_mem.o $(DIST)good_code4.o

bad4:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code4.o -c $(CODE)bad_code4.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code4.bin $(DIST)gimme_mem.o $(DIST)bad_code4.o

good5:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code5.o -c $(CODE)good_code5.c
	$(CC) $(CFLAGS) -o $(DIST)good_code5.bin $(DIST)gimme_mem.o $(DIST)good_code5.o

bad5:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code5.o -c $(CODE)bad_code5.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code5.bin $(DIST)gimme_mem.o $(DIST)bad_code5.o

good6:
	$(CC) -o $(DIST)good_code6.bin $(CODE)good_code6.c

bad6:
	$(CC) -o $(DIST)bad_code6.bin $(CODE)bad_code6.c

good7:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code7.o -c $(CODE)good_code7.c
	$(CC) $(CFLAGS) -o $(DIST)good_code7.bin $(DIST)gimme_mem.o $(DIST)good_code7.o

bad7:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code7.o -c $(CODE)bad_code7.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code7.bin $(DIST)gimme_mem.o $(DIST)bad_code7.o

good8:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code8.o -c $(CODE)good_code8.c
	$(CC) $(CFLAGS) -o $(DIST)good_code8.bin $(DIST)gimme_mem.o $(DIST)good_code8.o

bad8:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code8.o -c $(CODE)bad_code8.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code8.bin $(DIST)gimme_mem.o $(DIST)bad_code8.o

good9:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)good_code9.o -c $(CODE)good_code9.c
	$(CC) $(CFLAGS) -o $(DIST)good_code9.bin $(DIST)gimme_mem.o $(DIST)good_code9.o

bad9:
	$(MAKE) library
	$(CC) $(CFLAGS) -o $(DIST)bad_code9.o -c $(CODE)bad_code9.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code9.bin $(DIST)gimme_mem.o $(DIST)bad_code9.o

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
