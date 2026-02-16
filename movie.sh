#!/bin/bash

# ===== CONFIG =====
DOWNLOAD_DIR="$HOME/movies"
LINK_FILE="$HOME/movie_links.txt"

# ==================

mkdir -p "$DOWNLOAD_DIR"
cd "$DOWNLOAD_DIR" || exit 1

while IFS= read -r url; do
    # skip empty line or comment
    [[ -z "$url" || "$url" =~ ^# ]] && continue

    # filename extract (wget dry-run style)
    filename=$(basename "${url%%\?*}")

    if [[ -f "$filename" ]]; then
        echo "⏭️  Skipped (already exists): $filename"
    else
        echo "⬇️  Downloading: $filename"
        wget -c "$url"
    fi

done < "$LINK_FILE"
