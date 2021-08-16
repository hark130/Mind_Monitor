# Mind_Monitor
A comparison of various C Programming memory debuggers

## MEMORY DEBUGGERS

* Dmalloc
* Electric Fence
* Valgrind
* Memwatch
* Mtrace
* AddressSanitizer (ASAN)

## DEPENDENCIES

From the `Mind_Monitor` directory:
`devops/script/dependency_checker.sh`

| Tool           | Verify                             | Install                             |
| :------------: | :--------------------------------- | :---------------------------------- |
| Dmalloc        | `dmalloc --version`                | `apt install libdmalloc*`           |
| Electric Fence | `dpkg-query --list electric-fence` | `apt install electric-fence`        |
| Valgrind       | `valgrind --version`               | `apt install valgrind`              |
| Memwatch       | `ls src/memwatch.?`                | `devops/script/install_memwatch.sh` |
| Mtrace         | `mtrace --version`                 | Built into glibc                    |
| ASAN           | `gcc -fsanitize=address --version` | `apt install gcc`

## RUN TESTS

From the `Mind_Monitor` directory:
`devops/script/test_all.sh`

## TEST RESULTS

| Filename     | Description                      | Dmalloc                         | Electric Fence           | Valgrind                 | Memwatch           | Mtrace                    | ASAN                      |
| :----------- | :------------------------------- | :-----------------------------: | :----------------------: | :----------------------: | :----------------: | :-----------------------: | :-----------------------: |
| bad_code1.c  | Uninit. mem                      | :x::anger:                      | :x:                      | :heavy_check_mark:       | :x:                | :x:                       | :heavy_check_mark::anger: |
| bad_code2.c  | Buffer overflow (Heap)           | :heavy_check_mark::anger::boom: | :x:                      | :heavy_check_mark:       | :heavy_check_mark: | :x:                       | :heavy_check_mark:        |
| bad_code3.c  | Memory leak                      | :heavy_check_mark::anger:       | :x:                      | :heavy_check_mark:       | :heavy_check_mark: | :heavy_check_mark:        | :heavy_check_mark:        |
| bad_code4.c  | Invalid mem access               | :x::anger:                      | :x::boom:                | :heavy_check_mark:       | :x:                | :x:                       | :heavy_check_mark:        |
| bad_code5.c  | Double free                      | :heavy_check_mark::anger::boom: | :heavy_check_mark::boom: | :heavy_check_mark:       | :heavy_check_mark: | :x:                       | :heavy_check_mark:        |
| bad_code6.c  | Uninit. integer                  | :x::anger:                      | :x:                      | :heavy_check_mark:       | :x::anger:         | :x:                       | :x:                       |
| bad_code7.c  | Overlapping memcpy               | :x::anger:                      | :x:                      | :x:                      | :x:                | :x:                       | :heavy_check_mark:        |
| bad_code8.c  | Fishy malloc values              | :heavy_check_mark::anger::boom: | :heavy_check_mark::boom: | :heavy_check_mark::boom: | :x::boom:          | :x::boom:                 | :heavy_check_mark:        |
| bad_code9.c  | Fishy calloc values              | :heavy_check_mark::anger::boom: | :x::boom:                | :heavy_check_mark::boom: | :x::boom:          | :x::boom:                 | :heavy_check_mark:        |
| bad_code10.c | Multi-process memory leak        | :heavy_check_mark::anger:       | :x:                      | :x:                      | :heavy_check_mark: | :heavy_check_mark::anger: | :x:                       |
| bad_code11.c | Multi-process double free        | :x::anger:                      | :heavy_check_mark:       | :x:                      | :heavy_check_mark: | :x:                       | :x:                       |
| bad_code12.c | Multi-thread memory leak         | :heavy_check_mark::anger:       | :x:                      | :heavy_check_mark:       | :heavy_check_mark: | :heavy_check_mark:        | :heavy_check_mark:        |
| bad_code13.c | Multi-thread double free         | :heavy_check_mark::anger:       | :heavy_check_mark:       | :heavy_check_mark:       | :heavy_check_mark: | :x::boom:                 | :heavy_check_mark:        |
| bad_code14.c | Multi-process memory leak (wait) | :heavy_check_mark:              | :x:                      | :x:                      | :heavy_check_mark: | :x:                       | :x:                       |
| bad_code15.c | Multi-process double free (wait) | :x:                             | :heavy_check_mark:       | :heavy_check_mark:       | :heavy_check_mark: | :x:                       | :heavy_check_mark:        |
| bad_code16.c | Buffer overflow (Stack)          | :x:                             | :x:                      | :x:                      | :x:                | :x:                       | :heavy_check_mark:        |

**LEGEND**

| Emoji              | Meaning                                    |
| :----------------: | :----------------------------------------- |
| :anger:            | False positive, misleading/missing results |
| :boom:             | Seg fault or core dump                     |
| :grey_question:    | Test not yet executed                      |
| :heavy_check_mark: | Succeeded in finding the error             |
| :x:                | Failed to find the error                   |

NOTES:

	- Some ideas came from https://valgrind.org/docs/manual/mc-manual.html
	- Bad Code 10 is the multi-process version of Bad Code 3
	- Bad Code 11 is the multi-process version of Bad Code 5
	- Bad Code 12 is the multi-thread version of Bad Code 3
	- Bad Code 13 is the multi-thread version of Bad Code 5
	- Bad Code 14 is Bad Code 10 with waitpid() implemented
	- Bad Code 15 is Bad Code 11 with waitpid() implemented
	- Turns out Mtrace's response to Bad Code 13 isn't anything above and beyond normal execution
	- Bad Code 16 borrowed heavily from Bad Code 2
	- *_code6_memwatch.bin and *_code16_memwatch.bin are failing to create a log file at runtime.  Theory: "...memwatch will auto-initialize on the first call to a memory function..." and neither test case calls a memory function.  I verified the binaries were linked against memwatch (e.g., `readelf -a *_code6_memwatch.bin | grep mw`).  I even tried to manually initialize memwatch with `mwInit()`, `mwDoFlush(1)`, and `mwTerm()`.

## CONCLUSION

### Errors Found

* Dmalloc - 9/16
* Electric Fence - 5/16
* Valgrind - 11/16
* Memwatch - 9/16
* Mtrace - 2.5/16
* ASAN - 12/16

NOTE: Mtrace has seemingly non-deterministic results for Bad Code 10 so it gets a :anger: and a half point

### Ease Of Use

On a scale of 1 to 5 (5 being the easiest to use):

* Dmalloc - 2/5
* Electric Fence - 3/5
* Valgrind - 4/5
* Memwatch - 3/5
* Mtrace - 3/5
* ASAN - 5/5

### Readable Output

On a scale of 1 to 5 (5 being the easiest to read):

* Dmalloc - 2/5
* Electric Fence - 4/5
* Valgrind - 3/5
* Memwatch - 5/5
* Mtrace - 5/5
* ASAN - 4/5

### Final Ranking

Ranked best to worst:

1. ASAN (85.0%)
1. Memwatch (72.1%)
1. Valgrind (69.6%)
1. Mtrace (58.5%)
1. Electric Fence (57.1%)
1. Dmalloc (45.4%)
