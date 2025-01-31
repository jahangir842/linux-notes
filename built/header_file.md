A **header file** is a file that contains declarations for functions, macros, constants, and data types used in C and C++ programs. Header files allow code reusability and modular programming by providing function prototypes and definitions that can be included in multiple source files.

## 📌 Key Features of Header Files:
- **Function Declarations**: Provides function prototypes so they can be used before defining them.
- **Macro Definitions**: Contains `#define` macros for constant values and code simplifications.
- **Data Type Definitions**: Defines structures (`struct`), enumerations (`enum`), and type aliases (`typedef` or `using`).
- **Code Modularity**: Encourages code separation by allowing implementations (`.c` or `.cpp` files) to be independent of function declarations.

---

## 🔹 Examples of Common Header Files:
| Header File | Purpose |
|------------|---------|
| `<stdio.h>` | Standard Input/Output functions (`printf`, `scanf`) |
| `<stdlib.h>` | Memory management (`malloc`, `free`), process control (`exit`) |
| `<string.h>` | String manipulation functions (`strlen`, `strcpy`) |
| `<math.h>` | Math functions (`sqrt`, `pow`, `sin`) |
| `<time.h>` | Time and date functions (`time`, `clock`) |
| `<unistd.h>` | POSIX system calls (`sleep`, `getpid`) |

---

## 🔹 How to Use a Header File
To use a header file, you include it in your C or C++ source file using `#include`:

```c
#include <stdio.h>

int main() {
    printf("Hello, World!\n");
    return 0;
}
```

This includes the `<stdio.h>` header, allowing us to use the `printf()` function.

---

## 🔹 Custom Header Files
You can also create your own header files. For example:

1️⃣ Create a header file **`myheader.h`**:
```c
#ifndef MYHEADER_H
#define MYHEADER_H

void greet();

#endif
```

2️⃣ Create a source file **`myheader.c`**:
```c
#include <stdio.h>
#include "myheader.h"

void greet() {
    printf("Hello from my custom header!\n");
}
```

3️⃣ Use it in **`main.c`**:
```c
#include "myheader.h"

int main() {
    greet();
    return 0;
}
```

Compile and run:
```sh
gcc main.c myheader.c -o program
./program
```

---

### 🛠️ Where Are System Header Files Stored?
On Linux, system header files are typically found in:
- `/usr/include/` (common system headers)
- `/usr/local/include/` (additional libraries)
- `/usr/include/x86_64-linux-gnu/` (architecture-specific headers)

Let me know if you need more details! 🚀
