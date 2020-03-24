# Mind_Monitor
A comparison of various C Programming memory debuggers

## MEMORY DEBUGGERS

* Dmalloc
* Electric Fence
* Memcheck (AKA Valgrind)
* Memwatch
* Mtrace

## DEPENDENCIES

From the `Mind_Monitor` directory:
`devops/script/dependency_checker.sh`

| Tool           | Verify | Install |
| :------------: | :----- | :------ |
| Dmalloc        | `dmalloc --version` | `apt install libdmalloc*` |
| Electric Fence | :grey_question: | :grey_question: |
| Valgrind       | `valgrind --version` | `apt install valgrind` |
| Memwatch       | :grey_question: | :grey_question: |
| Mtrace         | `mtrace --version` | Built into glibc |


## RUN TESTS

From the `Mind_Monitor` directory:
`devops/script/test_all.sh`

## RESULTS

| Filename    | Description         | Dmalloc         | Electric Fence  | Memcheck           | Memwatch        | Mtrace     |
| :---------- | :------------------ | :-------------: | :-------------: | :----------------: | :-------------: | :--------: |
| bad_code1.c | Uninit. mem         | :grey_question: | :grey_question: | :heavy_check_mark: | :grey_question: | :x: |
| bad_code2.c | Buffer overflow     | :grey_question: | :grey_question: | :heavy_check_mark: | :grey_question: | :x: |
| bad_code3.c | Memory leak         | :grey_question: | :grey_question: | :heavy_check_mark: | :grey_question: | :heavy_check_mark: |
| bad_code4.c | Invalid mem access  | :grey_question: | :grey_question: | :heavy_check_mark: | :grey_question: | :x: |
| bad_code5.c | Double free         | :grey_question: | :grey_question: | :heavy_check_mark: | :grey_question: | :x: |
| bad_code6.c | Uninit. integer     | :grey_question: | :grey_question: | :heavy_check_mark: | :grey_question: | :x: |
| bad_code7.c | Overlapping memcpy  | :grey_question: | :grey_question: | :x: | :grey_question: | :x: |
| bad_code8.c | Fishy malloc values | :grey_question: | :grey_question: | :heavy_check_mark: | :grey_question: | :x: |
| bad_code9.c | Fishy calloc values | :grey_question: | :grey_question: | :heavy_check_mark: | :grey_question: | :x: |


NOTE:  Some ideas came from https://valgrind.org/docs/manual/mc-manual.html
