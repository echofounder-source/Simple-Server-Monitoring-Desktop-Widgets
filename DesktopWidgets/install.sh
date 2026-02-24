#!/bin/bash
set -e

echo "=== Plex Desktop Widgets Build & Install ==="

BUNDLE_ID="com.jasonbarton.PlexDesktopWidgets"

# Step 1: Kill only the desktop widgets app by bundle ID
echo "[1/6] Killing Plex Desktop Widgets (bundle: $BUNDLE_ID)..."
osascript -e "tell application id \"$BUNDLE_ID\" to quit" 2>/dev/null || true
sleep 1
# Force kill if still running
PID=$(pgrep -f "$BUNDLE_ID" 2>/dev/null || true)
if [ -n "$PID" ]; then
    kill -9 $PID 2>/dev/null || true
    sleep 0.5
fi

# Step 2: Remove old installed app
echo "[2/6] Removing old app from /Applications..."
rm -rf "/Applications/Plex Desktop Widgets.app"

# Step 3: Clean old build artifacts
echo "[3/6] Cleaning old builds..."
rm -rf ~/Library/Developer/Xcode/DerivedData/PlexDesktopWidgets-*

# Step 4: Generate Xcode project
echo "[4/6] Generating Xcode project..."
cd "$(dirname "$0")"
xcodegen generate

# Step 5: Build
echo "[5/6] Building (Release)..."
xcodebuild -scheme PlexDesktopWidgets -configuration Release build 2>&1 | tail -3

# Step 6: Install & Launch
echo "[6/6] Installing to /Applications..."
APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData/PlexDesktopWidgets-* -name "Plex Desktop Widgets.app" -type d 2>/dev/null | head -1)
if [ -z "$APP_PATH" ]; then
    echo "ERROR: Build failed — Plex Desktop Widgets.app not found"
    exit 1
fi
cp -R "$APP_PATH" /Applications/
echo "Installed from: $APP_PATH"

echo ""
echo "=== Done! Launching Plex Desktop Widgets... ==="
open "/Applications/Plex Desktop Widgets.app"
