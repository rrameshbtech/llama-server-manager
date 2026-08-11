#!/bin/zsh
# ==============================================================================
# CENTRAL MODEL REGISTRY & DEFAULTS
# ==============================================================================

MODELS_DIR="$HOME/projects/ai-models"
DEFAULT_PORT=8080
DEFAULT_CTX=32768
LOG_FILE="$HOME/llama-server.log"

# Map aliases to GGUF filenames
get_model_filename() {
  case "$1" in
    "qwen35")
      echo "Qwen3.6-35B-A3B-UD-Q4_K_M.gguf"
      ;;
    "phi-mini")
      echo "Phi-4-mini-instruct-Q4_K_M.gguf"
      ;;
    *)
      echo ""
      ;;
  esac
}
