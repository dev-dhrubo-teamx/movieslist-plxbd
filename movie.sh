#!/bin/bash

LINK_FILE_URL="https://raw.githubusercontent.com/dev-dhrubo-teamx/movieslist-plxbd/main/movie_links.txt"
BASE_DIR="$(pwd)"

mkdir -p "$BASE_DIR"
cd "$BASE_DIR" || exit 1

curl -fsSL "$LINK_FILE_URL" | while IFS= read -r url; do
    [[ -z "$url" || "$url" =~ ^# ]] && continue

    echo "⬇️  Processing: $url"

    # let wget decide filename safely (UTF-8 safe)
    wget -c --content-disposition --trust-server-names "$url"

done
