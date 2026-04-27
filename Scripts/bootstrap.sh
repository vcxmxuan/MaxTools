#!/usr/bin/env bash
set -euo pipefail

swift package resolve
swift test
