#!/bin/bash

LINK_FILE_URL="https://raw.githubusercontent.com/dev-dhrubo-teamx/movieslist-plxbd/main/movie_links.txt"
DOWNLOAD_DIR="$HOME/movies"

mkdir -p "$DOWNLOAD_DIR"
cd "$DOWNLOAD_DIR" || exit 1

curl -fsSL "$LINK_FILE_URL" | while IFS= read -r url; do
    [[ -z "$url" || "$url" =~ ^# ]] && continue

    filename=$(basename "${url%%\?*}")

    if [[ -f "$filename" ]]; then
        echo "⏭️  Skipped: $filename"
    else
        echo "⬇️  Downloading: $filename"
        wget -c "$url"
    fi
done
