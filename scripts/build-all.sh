#!/usr/bin/env bash

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
RESET='\033[0m'

# Navigate to project root
cd "$(dirname "$0")/.." || exit 1

echo -e "${CYAN}Building all slide decks...${RESET}"
echo ""

build_slide() {
  local FILE=$1

  # Extract frontmatter YAML (between first two ---)
  YAML=$(awk '/^---/{f=!f; next} f' "$FILE" | head -50)

  BASE=$(echo "$YAML" | awk -F': ' '/^base:/ {gsub(/^ +| +$/, "", $2); print $2}')
  OUT=$(echo "$YAML" | awk -F': ' '/^out:/ {gsub(/^ +| +$/, "", $2); print $2}')

  if [[ -n "$BASE" && -n "$OUT" ]]; then
    echo -e "${GREEN}Building${RESET} $FILE"
    echo "   ➤ base: $BASE"
    echo "   ➤ out : $OUT"

    # Build from project root with full path
    pnpm exec slidev build "$FILE" --base "$BASE" --out "$OUT"

    echo ""
  else
    echo -e "${YELLOW}Skipping${RESET} $FILE (missing base or out in frontmatter)"
  fi
}

# Build root slides
for FILE in ./*.md; do
  if [[ -f "$FILE" ]]; then
    build_slide "$FILE"
  fi
done

# Build lesson slides
for FILE in ./lessons/*/*.md; do
  if [[ -f "$FILE" ]]; then
    build_slide "$FILE"
  fi
done

# Create redirect index.html
mkdir -p dist
cat > dist/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta http-equiv="refresh" content="0; url=/00-index/">
  <title>Redirecting...</title>
</head>
<body>
  <p>Redirecting to <a href="/00-index/">slide decks</a>...</p>
</body>
</html>
EOF
echo -e "${GREEN}Created${RESET} dist/index.html (redirects to /00-index/)"

echo ""
echo -e "${CYAN}Build complete!${RESET}"
