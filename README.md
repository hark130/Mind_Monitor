# Mind_Monitor
A comparison of various C Programming memory debuggers

## MEMORY DEBUGGERS

* Dmalloc
* Electric Fence
* Memcheck (AKA Valgrind)
* Memwatch
* Mtrace

## RESULTS

| Filename    | Description        | Dmalloc    | Electric Fence  | Memcheck   | Memwatch   | Mtrace     |
| :---------- | :----------------- | :--------: | :-------------: | :--------: | :--------: | :--------: |
| bad_code1.c | Uninit. mem        | :question: | :question:      | :+1:       | :question: | :question: |
| bad_code2.c | Buffer overflow    | :question: | :question:      | :+1:       | :question: | :question: |
| bad_code3.c | Memory leak        | :question: | :question:      | :+1:       | :question: | :question: |
| bad_code4.c | Invalid mem access | :question: | :question:      | :+1:       | :question: | :question: |
| bad_code5.c | Double free        | :question: | :question:      | :+1:       | :question: | :question: |
| bad_code6.c | Uninit. integer    | :question: | :question:      | :+1:       | :question: | :question: |


NOTE:  Future ideas from https://valgrind.org/docs/manual/mc-manual.html
* Overlapping src and dst pointers in memcpy and related functions.
* Passing a fishy (presumably negative) value to the size parameter of a memory allocation function.
