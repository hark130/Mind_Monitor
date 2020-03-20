CC = gcc
CFLAGS=-Wall
DIST = ./dist/
CODE = ./src/

bad:
	$(CC) $(CFLAGS) -o $(DIST)bad_code.o -c $(CODE)bad_code.c
	$(CC) $(CFLAGS) -o $(DIST)bad_code.bin $(DIST)bad_code.o

all:
	$(MAKE) bad

clean: 
	rm -f $(DIST)*.o $(DIST)*.exe $(DIST)*.bin $(DIST)*.lib $(DIST)*.so
