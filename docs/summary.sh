#!/bin/bash

# Đường dẫn đến thư mục root của project
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. && pwd)"
OUTPUT_FILE="$ROOT_DIR/code_summary.txt"

echo "📁 Project Directory Tree (filtered):" > "$OUTPUT_FILE"
tree -I '__pycache__|*.npz|*.png|*.pdf' "$ROOT_DIR" >> "$OUTPUT_FILE"

echo -e "\n\n📄 README.md:\n" >> "$OUTPUT_FILE"
cat "$ROOT_DIR/README.md" >> "$OUTPUT_FILE"

echo -e "\n\n📄 requirements.txt:\n" >> "$OUTPUT_FILE"
cat "$ROOT_DIR/requirements.txt" >> "$OUTPUT_FILE"

echo -e "\n\n📄 test.py:\n" >> "$OUTPUT_FILE"
cat "$ROOT_DIR/test.py" >> "$OUTPUT_FILE"

echo -e "\n\n📄 tutorial.ipynb (as raw text):\n" >> "$OUTPUT_FILE"
jq . "$ROOT_DIR/tutorial.ipynb" >> "$OUTPUT_FILE" 2>/dev/null || echo "(Unable to parse .ipynb file)" >> "$OUTPUT_FILE"

echo -e "\n\n📄 parametric_dr/*.py files:\n" >> "$OUTPUT_FILE"
for file in "$ROOT_DIR"/parametric_dr/*.py; do
    echo -e "\n--- File: $(basename "$file") ---\n" >> "$OUTPUT_FILE"
    cat "$file" >> "$OUTPUT_FILE"
done

echo -e "\n\n📄 document/*.pdf (not extracted, only listed):\n" >> "$OUTPUT_FILE"
ls "$ROOT_DIR"/document/*.pdf >> "$OUTPUT_FILE" 2>/dev/null || echo "(No PDF found)" >> "$OUTPUT_FILE"

echo -e "\n✅ Summary file generated at: $OUTPUT_FILE"
