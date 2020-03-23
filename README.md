# Mind_Monitor
A comparison of various C Programming memory debuggers

## MEMORY DEBUGGERS

* Dmalloc
* Electric Fence
* Memcheck (AKA Valgrind)
* Memwatch
* Mtrace

## RESULTS

| Filename    | Description     | Dmalloc    | Electric Fence  | Memcheck   | Memwatch   | Mtrace     |
| :---------- | :-------------- | :--------: | :-------------: | :--------: | :--------: | :--------: |
| bad_code1.c | Uninit. mem     | :question: | :question:      | :+1:       | :question: | :question: |
| bad_code2.c | Buffer overflow | :question: | :question:      | :+1:       | :question: | :question: |
