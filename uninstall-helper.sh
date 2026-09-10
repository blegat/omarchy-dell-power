#!/bin/bash

set -euo pipefail

helper=/usr/local/bin/omarchy-dell-battery-charge

if [[ -e $helper ]]; then
  sudo rm -- "$helper"
  echo "Removed $helper"
else
  echo "$helper is not installed"
fi
