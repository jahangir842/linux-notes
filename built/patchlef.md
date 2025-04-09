`patchelf` is a command-line utility used on **ELF (Executable and Linkable Format)** binaries in Linux systems. It allows you to modify certain properties of these binaries **without recompiling them**.

---

### 🔧 What can `patchelf` do?

Here are the most common tasks:

| Task                          | Description                                                                 | Example                                                                 |
|-------------------------------|-----------------------------------------------------------------------------|-------------------------------------------------------------------------|
| Change interpreter            | Modify the **interpreter (dynamic linker)** used by an executable          | `patchelf --set-interpreter /lib64/ld-linux-x86-64.so.2 ./binary`      |
| Change or add RPATH / RUNPATH| Modify or add **runtime library search paths**                             | `patchelf --set-rpath '$ORIGIN/../lib' ./binary`                        |
| Remove RPATH                 | Remove any existing runtime path                                            | `patchelf --remove-rpath ./binary`                                     |
| Replace a shared library     | Change the name of a **needed shared library**                              | `patchelf --replace-needed libold.so libnew.so ./binary`               |
| Add a needed library         | Force an ELF binary to **load an extra shared library**                    | `patchelf --add-needed libextra.so ./binary`                           |

---

### 🧠 Why is `patchelf` useful?

1. **Fixing broken binaries** after moving them to a new system.
2. **Making software relocatable** (e.g., for AppImage or Nix).
3. **Customizing dependency loading** paths.
4. **Injecting custom shared libraries** (for debugging or testing).

---

### 🔍 Example: Change RPATH

Let’s say you have a binary that needs to load libraries from `./libs`:

```bash
patchelf --set-rpath '$ORIGIN/libs' ./my_app
```

- `$ORIGIN` is a special keyword that refers to the directory containing the binary.

---

### 🔐 Bonus tip

To inspect ELF binaries before patching, use:

```bash
readelf -l ./binary
ldd ./binary
```

These commands help you identify interpreter paths and linked libraries.

---


## 🧱 What is ELF?

**ELF (Executable and Linkable Format)** is the **standard file format for executables, object code, shared libraries, and core dumps** on **Linux** and most Unix-like operating systems.

It's basically the Linux version of:
- `.exe` on Windows
- `.mach-o` on macOS

---

## 📦 ELF Files: Where You See Them

You interact with ELF files every day in Linux without even realizing it:

| File Type         | Example                             | Purpose                              |
|------------------|-------------------------------------|--------------------------------------|
| Executable        | `/bin/ls`                           | Programs you run                      |
| Shared Library    | `/lib/x86_64-linux-gnu/libc.so.6`   | Dynamic libraries used by executables|
| Object File       | `main.o` (after compilation)        | Intermediate file before linking     |
| Core Dump         | `core`                              | Memory snapshot after a crash        |

---

## 🏗️ Basic Structure of an ELF File

ELF files have **sections** and **segments**:

| Part              | Description                                                                 |
|------------------|-----------------------------------------------------------------------------|
| ELF Header        | Basic metadata: architecture, entry point, type (exec, shared, etc)         |
| Program Headers   | Tell the OS how to load the file into memory                                |
| Section Headers   | Used by compilers/linkers; includes code, symbols, debug info               |
| .text             | Contains actual code (machine instructions)                                 |
| .data / .bss      | Stores initialized / uninitialized global variables                         |
| .dynamic          | Dynamic linking info (needed shared libraries, etc)                         |

---

## 🧪 Example: Check if a file is an ELF

You can verify a file type using:

```bash
file /bin/ls
```

Output:
```
/bin/ls: ELF 64-bit LSB executable, x86-64, dynamically linked ...
```

---

## 🔍 Tools to Inspect ELF Files

| Tool         | Purpose                              | Example                           |
|--------------|--------------------------------------|-----------------------------------|
| `readelf`    | View ELF headers and details         | `readelf -a ./binary`             |
| `objdump`    | Disassemble and inspect internals    | `objdump -d ./binary`             |
| `ldd`        | Show shared libraries used           | `ldd ./binary`                    |
| `strace`     | Trace system calls (related to ELF)  | `strace ./binary`                 |

---

## 🔄 Relation to `patchelf`

Since `patchelf` manipulates ELF binaries, it works by modifying:
- **Interpreter** (dynamic linker) set in the ELF header
- **RPATH** or **RUNPATH**
- **Needed shared libraries** in the `.dynamic` section

---
