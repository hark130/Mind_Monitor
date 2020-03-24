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
| Electric Fence | :question: | :question: |
| Valgrind       | `valgrind --version` | `apt install valgrind` |
| Memwatch       | :question: | :question: |
| Mtrace         | `mtrace --version` | Built into glibc |


## RUN TESTS

From the `Mind_Monitor` directory:
`devops/script/test_all.sh`

## RESULTS

| Filename    | Description         | Dmalloc    | Electric Fence  | Memcheck   | Memwatch   | Mtrace     |
| :---------- | :------------------ | :--------: | :-------------: | :--------: | :--------: | :--------: |
| bad_code1.c | Uninit. mem         | :question: | :question:      | :heavy_check_mark:       | :question: | :x:       |
| bad_code2.c | Buffer overflow     | :question: | :question:      | :heavy_check_mark:       | :question: | :x:       |
| bad_code3.c | Memory leak         | :question: | :question:      | :heavy_check_mark:       | :question: | :heavy_check_mark:       |
| bad_code4.c | Invalid mem access  | :question: | :question:      | :heavy_check_mark:       | :question: | :x:       |
| bad_code5.c | Double free         | :question: | :question:      | :heavy_check_mark:       | :question: | :x:       |
| bad_code6.c | Uninit. integer     | :question: | :question:      | :heavy_check_mark:       | :question: | :x:       |
| bad_code7.c | Overlapping memcpy  | :question: | :question:      | :x:       | :question: | :x:       |
| bad_code8.c | Fishy malloc values | :question: | :question:      | :heavy_check_mark:       | :question: | :x:       |
| bad_code9.c | Fishy calloc values | :question: | :question:      | :heavy_check_mark:       | :question: | :x:       |


NOTE:  Some ideas came from https://valgrind.org/docs/manual/mc-manual.html
