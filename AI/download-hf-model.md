### 1. Install & Login
Ensure you have the latest version of the hub tools. Use `hf` (the modern, faster CLI) or the standard `huggingface-cli`.

```bash
pip install -U "huggingface_hub[cli]"
# Log in to ensure your session is active for restricted models
hf auth login
```

### 2. Download One File at a Time (Safest)
If you want to be extremely surgical to avoid session issues, you can download specific files individually. This ensures that even if one 50GB shard fails, the others are already safely on disk.

```bash
# Example: Downloading just the config first
hf download meta-llama/Llama-4-Maverick-17B-128E-Instruct config.json --local-dir ./llama-4-maverick

# Example: Downloading a specific weights shard
hf download meta-llama/Llama-4-Maverick-17B-128E-Instruct model-00001-of-00010.safetensors --local-dir ./llama-4-maverick
```

### 3. The "Set and Forget" Method (Recommended)
You don't actually need to manually download every single file. You can use `hf download` for the whole repo. If it crashes, **just run the same command again**. It will check which files are already finished and resume the interrupted ones.

To keep it tidy and avoid the complex "cache" symlinks, use the `--local-dir` flag:

```bash
hf download meta-llama/Llama-4-Maverick-17B-128E-Instruct \
    --local-dir ./Llama-4-Maverick \
    --local-dir-use-symlinks False
```

### 4. Advanced: Filter by Pattern
If you only want the weights (excluding GGUF or other formats that might be in the same repo), use patterns:

```bash
hf download meta-llama/Llama-4-Maverick-17B-128E-Instruct \
    --include "*.safetensors" "*.json" "*.model" \
    --local-dir ./Llama-4-Maverick
```

---

### Why this solves your "Session Expired" issue:
1.  **Persistence:** The CLI stores a `.progress` or temporary file. When you restart, it performs a `Range` request to pick up exactly where the byte-stream stopped.
2.  **Concurrency:** If you have high bandwidth but an unstable session, you can actually *limit* the number of parallel downloads to make it more stable:
    * Set the environment variable: `export HF_HUB_ENABLE_HF_TRANSFER=0` (standard transfer is more robust for bad connections than the high-speed `hf_transfer`).
3.  **Local Directory:** Using `--local-dir-use-symlinks False` makes the files "real" files in your folder immediately, which is easier to verify manually.

**Pro-tip:** If you are on a very restricted connection, use a simple `bash` loop to retry the download automatically if it exits with an error:
```bash
until hf download meta-llama/Llama-4-Maverick-17B-128E-Instruct --local-dir ./Llama-4-Maverick; do
    echo "Download crashed, retrying in 5 seconds..."
    sleep 5
done
```
