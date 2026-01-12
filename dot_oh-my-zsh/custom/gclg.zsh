# Custom shell functions

# Clone git repos into ~/src/<host>/<org>/<repo> structure
gclg() {
  local url="$1"
  local host org repo target

  if [[ -z "$url" ]]; then
    echo "Usage: gclg <git-url>"
    return 1
  fi

  # Remove trailing .git if present
  url="${url%.git}"

  # Parse SSH URL: git@github.com:org/repo
  if [[ "$url" == git@* ]]; then
    local rest="${url#git@}"
    host="${rest%%:*}"
    local urlpath="${rest#*:}"
    org="${urlpath%%/*}"
    repo="${urlpath#*/}"
  # Parse HTTPS URL: https://github.com/org/repo
  elif [[ "$url" == https://* ]] || [[ "$url" == http://* ]]; then
    local rest="${url#*://}"
    host="${rest%%/*}"
    local urlpath="${rest#*/}"
    org="${urlpath%%/*}"
    repo="${urlpath#*/}"
  else
    echo "Error: Could not parse URL: $url"
    return 1
  fi

  target="$HOME/src/$host/$org/$repo"

  if [[ -d "$target" ]]; then
    echo "Directory already exists: $target"
    cd "$target"
    return 0
  fi

  mkdir -p "${target%/*}"
  git clone "$url" "$target" && cd "$target"
}
