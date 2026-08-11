# AI Model Manager

A lightweight, Zsh-based CLI toolkit for managing local `llama-server` instances. It simplifies starting, stopping, switching, and monitoring large language models served via `llama.cpp`.

## 📋 Prerequisites

Before using this toolkit, ensure the following are installed and configured on your system:

- **Shell**: `zsh` (the scripts are written for Zsh)
- **Backend**: `llama-server` binary from [llama.cpp](https://github.com/ggerganov/llama.cpp) must be installed and available in your `$PATH`
- **Models**: GGUF model files stored in a dedicated directory (default: `~/projects/ai-models`)
- **System Tools**: Standard Unix utilities (`lsof`, `pgrep`, `tail`, `nohup`, `kill`)

## 🛠️ Setup

1. **Place the Scripts**  
   Copy the `.config/` directory contents to a directory included in your `$PATH`, or create symlinks:
   ```bash
   mkdir -p ~/.local/bin
   cp .config/ai-model-* ~/.local/bin/
   cp .config/registry.sh ~/.local/bin/
   chmod +x ~/.local/bin/ai-model-* ~/.local/bin/registry.sh
   ```

2. **Configure `registry.sh`**  
   Edit `~/.local/bin/registry.sh` (or wherever you placed it) to match your environment:
   ```zsh
   MODELS_DIR="$HOME/projects/ai-models"  # Path to your GGUF models
   DEFAULT_PORT=8080                     # Default HTTP port
   DEFAULT_CTX=32768                     # Default context length
   LOG_FILE="$HOME/llama-server.log"     # Log output path
   ```
   Update the `get_model_filename()` function to map your model aliases to actual `.gguf` filenames.

3. **Ensure Consistent Sourcing**  
   The scripts expect `registry.sh` to be in a predictable location. Update the `source` paths in the scripts if you place `registry.sh` elsewhere.

## 🚀 Usage

All commands assume the scripts are in your `$PATH`. Run them from any directory.

### Available Commands

| Command | Description |
|---|---|
| `ai-model-start` | Start a model server |
| `ai-model-stop` | Stop a model server |
| `ai-model-switch` | Switch between models |
| `ai-model-logs` | View live server logs |

---

### Start a Model

Launches `llama-server` in the background with GPU offloading and log redirection.

```bash
# Start with defaults (port 8080, context 32768)
ai-model-start qwen35

# Start with custom context length and port
ai-model-start phi-mini -c 16384 -p 8081

# Start with custom context only
ai-model-start qwen35 -c 65536

# Start with custom port only
ai-model-start phi-mini -p 9000
```

**Options:**
- `-c CTX_SIZE` — Override default context length (default: `32768`)
- `-p PORT` — Override default port (default: `8080`)

**Registered Models:**
| Alias | Model File |
|---|---|
| `qwen35` | `Qwen3.6-35B-A3B-UD-Q4_K_M.gguf` |
| `phi-mini` | `Phi-4-mini-instruct-Q4_K_M.gguf` |

---

### Stop a Model

Gracefully stops the `llama-server` process, first sending `SIGTERM` then `SIGKILL` if unresponsive.

```bash
# Stop model on default port (8080)
ai-model-stop

# Stop model on specific port
ai-model-stop -p 8081
```

---

### Switch Models

Stops any running model on the target port and starts the new one seamlessly.

```bash
# Switch to qwen35 on default port
ai-model-switch qwen35

# Switch with custom context and port
ai-model-switch phi-mini -c 16384 -p 8081
```

---

### View Logs

Streams live logs from the server log file.

```bash
# View last 50 lines and follow
ai-model-logs

# View last 100 lines and follow
ai-model-logs -n 100
```
