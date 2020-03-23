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

all_good:
	$(MAKE) good1
	$(MAKE) good2
	$(MAKE) good3
	$(MAKE) good4
	$(MAKE) good5

all_bad:
	$(MAKE) bad1
	$(MAKE) bad2
	$(MAKE) bad3
	$(MAKE) bad4
	$(MAKE) bad5

all:
	$(MAKE) clean
	$(MAKE) all_good
	$(MAKE) all_bad

clean: 
	rm -f $(DIST)*.o $(DIST)*.exe $(DIST)*.bin $(DIST)*.lib $(DIST)*.so
