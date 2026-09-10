#!/bin/bash

set -euo pipefail

plugin_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

sudo install -m 755 -o root -g root \
  "$plugin_dir/dell-battery-charge" \
  /usr/local/bin/omarchy-dell-battery-charge

echo "Installed /usr/local/bin/omarchy-dell-battery-charge"
