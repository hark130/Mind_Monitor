# Mind_Monitor
A comparison of various C Programming memory debuggers

## MEMORY DEBUGGERS

* Dmalloc
* Electric Fence
* Memcheck (AKA Valgrind)
* Memwatch
* Mtrace

## RUN TESTS

From the `Mind_Monitor` directory:
`devops/script/test_all.sh`

## RESULTS

| Filename    | Description         | Dmalloc    | Electric Fence  | Memcheck   | Memwatch   | Mtrace     |
| :---------- | :------------------ | :--------: | :-------------: | :--------: | :--------: | :--------: |
| bad_code1.c | Uninit. mem         | :question: | :question:      | :+1:       | :question: | :question: |
| bad_code2.c | Buffer overflow     | :question: | :question:      | :+1:       | :question: | :question: |
| bad_code3.c | Memory leak         | :question: | :question:      | :+1:       | :question: | :question: |
| bad_code4.c | Invalid mem access  | :question: | :question:      | :+1:       | :question: | :question: |
| bad_code5.c | Double free         | :question: | :question:      | :+1:       | :question: | :question: |
| bad_code6.c | Uninit. integer     | :question: | :question:      | :+1:       | :question: | :question: |
| bad_code7.c | Overlapping memcpy  | :question: | :question:      | :-1:       | :question: | :question: |
| bad_code8.c | Fishy malloc values | :question: | :question:      | :+1:       | :question: | :question: |
| bad_code9.c | Fishy calloc values | :question: | :question:      | :+1:       | :question: | :question: |


NOTE:  Some ideas came from https://valgrind.org/docs/manual/mc-manual.html
