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

# Ordered list of known model aliases — the single source of truth
KNOWN_MODELS=(
  "qwen35"
  "phi-mini"
)

# List all registered model aliases by calling get_model_filename() at runtime
list_models() {
  for alias in "${KNOWN_MODELS[@]}"; do
    FILE_TMP=$(get_model_filename "$alias")
    if [ -n "$FILE_TMP" ]; then
      printf "  %-12s → %s\n" "$alias" "$FILE_TMP"
    fi
  done
}
