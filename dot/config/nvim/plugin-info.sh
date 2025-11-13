#!/bin/sh
set -e

PLUGIN_DIR="$HOME/.local/share/nvim/lazy"
INFO_JSON="plugin-info.json"
GITHUB_TOKEN="${GITHUB_TOKEN:-}"

log() {
  echo "[plugin-info] $*" >&2
}

scan_plugin_urls() {
  log "Scanning plugin URLs in $PLUGIN_DIR..."
  find "$PLUGIN_DIR" -name config -type f -print0 | \
    xargs -0 grep url | \
    cut -d'=' -f2 | \
    sed 's/\.git//;s/^[[:space:]]*//' | \
    awk -F/ '{print $NF "|" $0}'
}

backup_or_create_cache() {
  if [ -f "$INFO_JSON" ]; then
    log "Found $INFO_JSON, backing up to ${INFO_JSON}.bak"
    cp "$INFO_JSON" "${INFO_JSON}.bak"
  else
    log "No $INFO_JSON found, creating new."
    echo "{}" > "$INFO_JSON"
  fi
}

fetch_plugin_description() {
  name="$1"
  url="$2"

  api_url=$(echo "$url" | awk -F/ '{print "https://api.github.com/repos/" $(NF-1) "/" $NF}')

  if [ -n "$GITHUB_TOKEN" ]; then
    descr=$(curl -s -H "Authorization: token $GITHUB_TOKEN" "$api_url" | jq -r .description)
  else
    descr=$(curl -s "$api_url" | jq -r .description)
  fi

  if [ "$descr" = "null" ] || [ -z "$descr" ]; then
    log "Failed to fetch description for $name ($url)"
    echo ""
  else
    log "Fetched description for $name"
    echo "$descr"
  fi
}

get_cached_description() {
  name="$1"
  jq -r --arg name "$name" '.[$name].description // empty' "$INFO_JSON"
}

update_plugin_info() {
  plugins="$1"
  tmp_json="$2"

  echo "{}" > "$tmp_json"

  for entry in $plugins; do
    name=$(echo "$entry" | cut -d'|' -f1)
    url=$(echo "$entry" | cut -d'|' -f2)
    descr=$(get_cached_description "$name")

    if [ -z "$descr" ] || [ "$descr" = "null" ]; then
      log "Fetching description for $name from GitHub..."
      descr=$(fetch_plugin_description "$name" "$url")
    else
      log "Using cached description for $name"
    fi

    jq --arg name "$name" --arg url "$url" --arg descr "$descr" \
      '. + {($name): {url: $url, description: $descr}}' "$tmp_json" > "${tmp_json}.new"
    mv "${tmp_json}.new" "$tmp_json"
  done
}

remove_uninstalled_plugins() {
  plugins="$1"
  tmp_json="$2"

  for name in $(jq -r 'keys[]' "$INFO_JSON"); do
    if echo "$plugins" | grep -q "^$name|"; then
      log "Keeping $name"
    else
      log "Removing $name (no longer installed)"
      jq "del(.\"$name\")" "$tmp_json" > "${tmp_json}.new" && mv "${tmp_json}.new" "$tmp_json"
    fi
  done
}

generate_markdown_table() {
  log "Generating markdown table..."
  echo "| Plugin | Description |"
  echo "| ------ | ----------- |"
  jq -r 'to_entries | sort_by(.key | ascii_downcase)[] | "| [" + .key + "](" + .value.url + ") | " + (.value.description // "") + " |"' "$INFO_JSON"
}

main() {
  plugins=$(scan_plugin_urls)
  backup_or_create_cache

  tmp_json=$(mktemp)
  update_plugin_info "$plugins" "$tmp_json"
  remove_uninstalled_plugins "$plugins" "$tmp_json"

  mv "$tmp_json" "$INFO_JSON"
  log "Updated $INFO_JSON"

  generate_markdown_table

  # Clean up backup after successful completion
  if [ -f "${INFO_JSON}.bak" ]; then
    rm "${INFO_JSON}.bak"
    log "Removed backup file ${INFO_JSON}.bak"
  fi

  log "Done."
}

main
