### Controlling Jobs in Bash

#### **Objectives:**
After completing this section, you should be able to:
- Use Bash job control to manage multiple processes started within the same terminal session.

---

### **Describing Jobs and Sessions**

**Job control** is a feature of the shell that enables a single shell instance to run and manage multiple commands concurrently.

- **Job**: Associated with each pipeline (a sequence of commands separated by pipes `|`) entered at a shell prompt. Each job consists of processes in the pipeline, which belong to the same process group. 
  - A minimal pipeline (one command without pipes) still forms a job with one process.
  
- **Foreground Process**: Only one job can read input or receive keyboard-generated signals (like `Ctrl+C`) at any time from a terminal. This job is the **foreground process** of that terminal.

- **Background Process**: Other jobs associated with the terminal are **background processes**. They cannot receive input from the terminal, but they can write to it. A background job might be stopped (suspended) or running. If a background job tries to read from the terminal, it will be suspended automatically.

- **Sessions and Terminals**: 
  - Each terminal is considered its own **session**, with a foreground process and possibly multiple background processes. 
  - A job is part of only one session, and that session is linked to the terminal controlling it.
  - System-level processes (e.g., daemons) do not have a controlling terminal and are not part of any job. When viewed using the `ps` command, these processes will show a `?` in the **TTY** column.

---

### **Running Jobs in the Background**

To run a command in the background, append an ampersand (`&`) to the end of the command. This allows the shell to execute the command in the background and immediately return to the prompt without waiting for the process to finish.

#### Example:
```bash
[user@host ~]$ sleep 10000 &
[1] 5947
[user@host ~]$
```
- **[1]**: Job number.
- **5947**: Process ID (PID) of the background job.

When using a pipeline, the PID of the last command in the pipeline is displayed, but all commands in the pipeline are part of the same job.
```bash
[user@host ~]$ example_command | sort | mail -s "Sort output" &
[1] 5998
```

---

### **Managing Jobs**

#### Viewing Jobs:
You can list all running and suspended jobs with the `jobs` command:
```bash
[user@host ~]$ jobs
[1]+ Running sleep 10000 &
```

#### Bringing a Background Job to the Foreground:
You can bring a background job to the foreground using the `fg` command followed by the job number (`%job_number`):
```bash
[user@host ~]$ fg %1
sleep 10000
```
In this example, the `sleep` command is now running in the foreground.

#### Suspending a Foreground Job:
You can suspend a foreground job by pressing `Ctrl+Z`. This stops the job and moves it to the background.
```bash
[user@host ~]$ sleep 10000
^Z
[1]+ Stopped sleep 10000
```

---

### **Job-Related Commands**

#### `ps j` Command:
The `ps j` command displays information about jobs, including:
- **PPID**: Parent Process ID (process that started this one).
- **PID**: Process ID.
- **PGID**: Process Group ID (typically the same as the PID for the group leader).
- **SID**: Session ID (usually the interactive shell’s PID).
- **STAT**: Current state of the process (`T` indicates it’s suspended, `R` means running).

#### Example:
```bash
[user@host ~]$ ps j
PPID   PID  PGID   SID  TTY   TPGID  STAT UID  TIME COMMAND
2764  2768  2768  2768  pts/0  6377   Ss   1000 0:00 /bin/bash
2768  5947  5947  2768  pts/0  6377   T    1000 0:00 sleep 10000
2768  6377  6377  2768  pts/0  6377   R+   1000 0:00 ps j
```

- In this output, the `sleep` process has been suspended (`T` status).

#### Resuming a Suspended Job in the Background:
To resume a suspended job in the background, use the `bg` command with the job number:
```bash
[user@host ~]$ bg %1
[1]+ sleep 10000 &
```

---

### **Handling Suspended Jobs When Exiting**

If you try to exit the shell while there are suspended jobs, the shell will warn you:
```bash
[user@host ~]$ exit
There are stopped jobs.
```
If you exit again immediately, the shell will terminate the suspended jobs.

---

By mastering these job control techniques, you can manage multiple processes more efficiently, especially when working in a single terminal session.
