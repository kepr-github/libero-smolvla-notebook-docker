#!/usr/bin/env bash
set -euo pipefail

mkdir -p runs

mapfile -t notebooks < <(find . -maxdepth 1 -type f -name "*.ipynb" -printf "%P\n" | sort)

if [[ "${#notebooks[@]}" -eq 0 ]]; then
  echo "Notebook not found: place the assignment .ipynb in the repository root" >&2
  exit 2
fi

if [[ "${#notebooks[@]}" -gt 1 ]]; then
  echo "Multiple notebooks found in the repository root:" >&2
  printf '  %s\n' "${notebooks[@]}" >&2
  exit 2
fi

notebook="${notebooks[0]}"

echo "Executing ${notebook}"

jupyter nbconvert \
  --to notebook \
  --execute \
  --ExecutePreprocessor.timeout=-1 \
  --ExecutePreprocessor.kernel_name=python3 \
  --output-dir runs \
  --output advanced_executed \
  "${notebook}"
