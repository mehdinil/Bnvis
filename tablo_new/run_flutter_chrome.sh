#!/usr/bin/env bash
# Auto-run Flutter app on Chrome with checks and logs
set -euo pipefail

PROJECT_ROOT="${1:-$(pwd)}"
LOG_DIR="$PROJECT_ROOT/logs"
mkdir -p "$LOG_DIR"
TS="$(date +'%Y%m%d_%H%M%S')"
LOG_FILE="$LOG_DIR/flutter_run_chrome_$TS.log"

echo "==> Project root: $PROJECT_ROOT"
echo "==> Log file: $LOG_FILE"
echo

need() { command -v "$1" >/dev/null 2>&1 || { echo "Error: '$1' not found in PATH." | tee -a "$LOG_FILE"; exit 1; }; }

echo "==> Checking required tools..." | tee -a "$LOG_FILE"
need flutter
echo "   - flutter: OK" | tee -a "$LOG_FILE"

set +e
if command -v google-chrome >/dev/null 2>&1; then
  echo "   - google-chrome: OK" | tee -a "$LOG_FILE"
elif command -v chromium >/dev/null 2>&1; then
  export CHROME_EXECUTABLE="$(command -v chromium)"
  echo "   - chromium found: $CHROME_EXECUTABLE" | tee -a "$LOG_FILE"
elif [[ -x "/usr/bin/google-chrome" ]]; then
  export CHROME_EXECUTABLE="/usr/bin/google-chrome"
  echo "   - google-chrome at $CHROME_EXECUTABLE" | tee -a "$LOG_FILE"
elif [[ -x "/snap/bin/chromium" ]]; then
  export CHROME_EXECUTABLE="/snap/bin/chromium"
  echo "   - chromium at $CHROME_EXECUTABLE" | tee -a "$LOG_FILE"
elif [[ -x "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ]]; then
  export CHROME_EXECUTABLE="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
  echo "   - macOS Chrome at $CHROME_EXECUTABLE" | tee -a "$LOG_FILE"
else
  echo "   - Chrome not directly found; Flutter may still find it if installed." | tee -a "$LOG_FILE"
fi
set -e

if [[ ! -f "$PROJECT_ROOT/pubspec.yaml" ]]; then
  echo "Error: pubspec.yaml not found in $PROJECT_ROOT" | tee -a "$LOG_FILE"
  exit 1
fi

echo | tee -a "$LOG_FILE"
echo "==> Enabling Flutter web support..." | tee -a "$LOG_FILE"
flutter config --enable-web | tee -a "$LOG_FILE"

echo | tee -a "$LOG_FILE"
echo "==> Flutter doctor (for info)..." | tee -a "$LOG_FILE"
set +e
flutter doctor -v | tee -a "$LOG_FILE"
set -e

echo | tee -a "$LOG_FILE"
echo "==> Fetching dependencies (flutter pub get)..." | tee -a "$LOG_FILE"
(
  cd "$PROJECT_ROOT"
  flutter pub get
) | tee -a "$LOG_FILE"

echo | tee -a "$LOG_FILE"
echo "==> Checking devices..." | tee -a "$LOG_FILE"
set +e
DEVICES_OUTPUT="$(flutter devices)"
echo "$DEVICES_OUTPUT" | tee -a "$LOG_FILE"
if ! echo "$DEVICES_OUTPUT" | grep -qi "Chrome"; then
  echo "Error: Chrome device not detected by Flutter." | tee -a "$LOG_FILE"
  echo "Tips:" | tee -a "$LOG_FILE"
  echo "  - Ensure Google Chrome or Chromium is installed." | tee -a "$LOG_FILE"
  echo "  - macOS: CHROME_EXECUTABLE=/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome" | tee -a "$LOG_FILE"
  echo "  - Linux: CHROME_EXECUTABLE=/usr/bin/google-chrome (or chromium)" | tee -a "$LOG_FILE"
  echo "  - Re-run this script after installing/fixing Chrome." | tee -a "$LOG_FILE"
  exit 1
fi
set -e

echo | tee -a "$LOG_FILE"
echo "==> Running on Chrome (hot-reload enabled). Press 'r' to hot-reload, 'q' to quit." | tee -a "$LOG_FILE"
(
  cd "$PROJECT_ROOT"
  flutter run -d chrome -v
) 2>&1 | tee -a "$LOG_FILE"
