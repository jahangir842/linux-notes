## Guide: LLM Model Downloads from Hugging Face

### 1. Install & Login
Ensure you have the latest version of the Hugging Face Hub tools. 
> **Tip:** Always use the modern `hf` command instead of the older `huggingface-cli` for better performance and clearer feedback.

```bash
pip install -U "huggingface_hub[cli]"

hf auth login
```

### 2. Download One File at a Time (The "Safest" Strategy)
If your connection is very unstable, you can target specific files. By using `--max-workers 1`, you ensure the CLI focuses all available bandwidth on a single file, reducing the risk of multiple simultaneous timeouts.

```bash
# Example: Downloading just the config first
hf download meta-llama/Llama-4-Maverick-17B-128E-Instruct config.json --local-dir ./Llama-4-Maverick --max-workers 1

# Example: Downloading a specific weight shard
hf download meta-llama/Llama-4-Maverick-17B-128E-Instruct model-00015-of-00055.safetensors --local-dir ./Llama-4-Maverick --max-workers 1
```

### 3. The "Set and Forget" Method (Recommended)
You don't need to manually trigger every shard. This command will scan the repo and download everything missing. By setting workers to `1`, you prevent the "session juggling" that often leads to expiration errors.

```bash
hf download meta-llama/Llama-4-Maverick-17B-128E-Instruct \
    --local-dir ./Llama-4-Maverick \
    --max-workers 1
```

### 4. Advanced: Filter by Pattern
To avoid downloading unnecessary files (like documentation or alternative formats), use patterns while maintaining the single-worker safety:

```bash
hf download meta-llama/Llama-4-Maverick-17B-128E-Instruct \
    --include "*.safetensors" "*.json" "*.model" \
    --local-dir ./Llama-4-Maverick \
    --max-workers 1
```

---

### Why this solves "Session Expired" & Connection Issues

* **Persistence:** The `hf` tool creates `.incomplete` files. If the session drops, it uses a **Range Request** to pick up exactly where it left off (e.g., resuming from 3GB of a 20GB file).
* **Worker Control:** Using `--max-workers 1` is critical for weak connections. It prevents the CLI from trying to open 5+ simultaneous connections, which often triggers security flags or causes bandwidth starvation that drops the session.
* **Automatic Cleanup:** When you use `--local-dir`, `hf` automatically places the finished files in your folder and cleans up the cache once the download is verified.

> **Pro-Tip: The Auto-Retry Loop**
> If your session expires frequently, wrap the command in a `bash` loop. This will automatically restart the download (and resume progress) every time it crashes:
> ```bash
> until hf download meta-llama/Llama-4-Maverick-17B-128E-Instruct --local-dir ./Llama-4-Maverick --max-workers 1; do
>     echo "Download interrupted. Resuming in 10 seconds..."
>     sleep 10
> done
> ```

---

### The Auto-Resume Script (`download_llama.sh`)

Create a file named `download_llama.sh` in your current directory:

```bash
nano download_llama.sh
```

Put this in the file:

```bash
#!/bin/bash

# Configuration
MODEL_ID="meta-llama/Llama-4-Maverick-17B-128E-Instruct"
LOCAL_DIR="./Llama-4-Maverick-17B-128E-Instruct"

echo "Starting download for $MODEL_ID..."

# Loop until the command exits successfully (status 0)
until hf download "$MODEL_ID" \
    --local-dir "$LOCAL_DIR" \
    --max-workers 1; do
    
    # If the command fails, it enters this block
    EXIT_CODE=$?
    echo "--------------------------------------------------------"
    echo "Download interrupted (Exit Code: $EXIT_CODE)."
    echo "Likely cause: Session expired or network timeout."
    echo "Retrying in 10 seconds..."
    echo "--------------------------------------------------------"
    sleep 10
done

echo "Success! Model download is complete."
```

---

### How to use it:

1.  **Make the script executable:**
    ```bash
    chmod +x download_llama.sh
    ```
2.  **Run it:**
    ```bash
    ./download_llama.sh
    ```

### Why this script is perfect for your current status:

* **Zero Manual Effort:** When Shard 15 (your current 21GB hurdle) eventually causes a timeout, the script catches the error and restarts the `hf download` command immediately.
* **Sequential Progress:** By keeping `--max-workers 1`, it ensures that even if it takes 48 hours, the shards are completed one by one without cluttering your bandwidth with multiple failing streams.
* **Verification:** Once all 69 files (weights + configs) are finished, the loop will naturally break, and you'll see the "Success!" message.

### Monitoring Tip:
Since you are inside a `vllm-deployment` folder, you can run this script in a `screen` or `tmux` session. That way, you can close your terminal window and the download will continue in the background.

```bash
# Start a new session
screen -S llama_download

# Run your script
./download_llama.sh

# Press Ctrl+A then D to detach (background it)
# To come back later and check: screen -r llama_download
```

---

## How to use `screen` command

### 1. Create a New Session
Open a new session and give it a name so you can find it easily later. Run this from your `~/projects/vllm-deployment/vllm` folder:

```bash
screen -S llama-dl
```
*Your terminal will clear. You are now "inside" the screen session.*

---

### 2. Start Your Script
Now, run the auto-resume script we created:

```bash
./download_llama.sh
```

---

### 3. "Detach" from the Session
This is the most important part. You want the script to keep running, but you want your terminal back (or you want to close it).

* Press **`Ctrl + A`**, then let go and immediately press **`D`**.
* You will see a message: `[detached from llama-dl]`

**You can now safely close your terminal or turn off your local PC (if you are SSH'ing into `pc3`).** The download will continue on the server.

---

### 4. How to Check Progress Later
When you want to see how many shards are finished or check the current speed, log back into your machine and "re-attach":

```bash
screen -r llama-dl
```

---

### 5. Common Screen Commands
If you forget where you are or what's running, use these:

| Goal | Command |
| :--- | :--- |
| **List all active screens** | `screen -ls` |
| **Detach (leave it running)** | `Ctrl + A` then `D` |
| **Re-attach to a session** | `screen -r llama-dl` |
| **Kill/Stop a session** | `Ctrl + A` then `K` (or just `exit` the script and type `exit`) |

### Troubleshooting: "There is no screen to be resumed"
If you try `screen -r` and it says it's already "Attached" but you can't see it (perhaps a previous SSH session hung), force it to detach from the old ghost session and attach to you:

```bash
screen -d -r llama-dl
```

**Status Check:** Once you've moved the process into `screen`, you can relax. Even if your internet at home blips, as long as `pc3` stays online, that script will keep retrying until all 55 shards are sitting in your folder.
