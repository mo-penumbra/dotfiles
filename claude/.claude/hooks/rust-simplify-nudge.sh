#!/bin/bash
FILE=$(jq -r '.tool_input.file_path // empty')
[[ "$FILE" == *.rs ]] && echo "Rust file edited — consider /simplify if the change is non-trivial."
exit 0
