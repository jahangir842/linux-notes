## Guide: LLM Model Downloads from Hugging Face

### 1. Install & Login
Ensure you have the latest version of the Hugging Face Hub tools. 
> **Tip:** Always use the modern `hf` command instead of the older `huggingface-cli` for better performance and clearer feedback.

```bash
pip install -U "huggingface_hub[cli]"

# Log in to authenticate your session for restricted models like Llama
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
