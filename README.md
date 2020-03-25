# Mind_Monitor
A comparison of various C Programming memory debuggers

## MEMORY DEBUGGERS

* Dmalloc
* Electric Fence
* Valgrind
* Memwatch
* Mtrace

## DEPENDENCIES

From the `Mind_Monitor` directory:
`devops/script/dependency_checker.sh`

| Tool           | Verify | Install |
| :------------: | :----- | :------ |
| Dmalloc        | `dmalloc --version` | `apt install libdmalloc*` |
| Electric Fence | `dpkg-query --list electric-fence` | `apt install electric-fence` |
| Valgrind       | `valgrind --version` | `apt install valgrind` |
| Memwatch       | :grey_question: | :grey_question: |
| Mtrace         | `mtrace --version` | Built into glibc |


## RUN TESTS

From the `Mind_Monitor` directory:
`devops/script/test_all.sh`

## TEST RESULTS

| Filename    | Description         | Dmalloc         | Electric Fence  | Valgrind           | Memwatch        | Mtrace     |
| :---------- | :------------------ | :-------------: | :-------------: | :----------------: | :-------------: | :--------: |
| bad_code1.c | Uninit. mem         | :x::anger: | :grey_question: | :heavy_check_mark: | :grey_question: | :x: |
| bad_code2.c | Buffer overflow     | :heavy_check_mark::anger::boom: | :grey_question: | :heavy_check_mark: | :grey_question: | :x: |
| bad_code3.c | Memory leak         | :heavy_check_mark::anger: | :grey_question: | :heavy_check_mark: | :grey_question: | :heavy_check_mark: |
| bad_code4.c | Invalid mem access  | :x::anger: | :grey_question: | :heavy_check_mark: | :grey_question: | :x: |
| bad_code5.c | Double free         | :heavy_check_mark::anger::boom: | :grey_question: | :heavy_check_mark: | :grey_question: | :x: |
| bad_code6.c | Uninit. integer     | :x::anger: | :grey_question: | :heavy_check_mark: | :grey_question: | :x: |
| bad_code7.c | Overlapping memcpy  | :x::anger: | :grey_question: | :x:                | :grey_question: | :x: |
| bad_code8.c | Fishy malloc values | :heavy_check_mark::anger::boom: | :grey_question: | :heavy_check_mark::boom: | :grey_question: | :x::boom: |
| bad_code9.c | Fishy calloc values | :heavy_check_mark::anger::boom: | :grey_question: | :heavy_check_mark::boom: | :grey_question: | :x::boom: |

**LEGEND**

| Emoji              | Meaning                              |
| :----------------: | :----------------------------------- |
| :anger:            | False positive or misleading results |
| :boom:             | Seg fault or core dump               |
| :grey_question:    | Test not yet executed                |
| :heavy_check_mark: | Succeeded in finding the error       |
| :x:                | Failed to find the error             |

NOTE:  Some ideas came from https://valgrind.org/docs/manual/mc-manual.html

## CONCLUSION

### Errors Found

* Dmalloc - 5/9
* Electric Fence - ?/9
* Valgrind - 8/9
* Memwatch - ?/9
* Mtrace - 1/9

### Ease Of Use

On a scale of 1 to 5 (5 being the easiest to use):

* Dmalloc - 2/5
* Electric Fence - ?/5
* Valgrind - 4/5
* Memwatch - ?/5
* Mtrace - 3/5

### Readable Output

On a scale of 1 to 5 (5 being the easiest to read):

* Dmalloc - 2/5
* Electric Fence - ?/5
* Valgrind - 3/5
* Memwatch - ?/5
* Mtrace - 5/5

### Final Ranking

Ranked best to worst:

1. valgrind (76.3%)
1. mtrace (57%)
1. 
1. 
1. dmalloc (45.2%)
