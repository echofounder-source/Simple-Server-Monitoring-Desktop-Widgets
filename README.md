# Desktop Widgets for P Media Server

A lightweight macOS menu bar app that puts your P Media Server status right on your desktop. See what's playing, who's watching, and how your system is holding up — all at a glance, no need to open a browser.

![macOS 14.0+](https://img.shields.io/badge/macOS-14.0%2B-blue) ![Swift 5.9](https://img.shields.io/badge/Swift-5.9-orange)

---

## What Does It Do?

Once it's running, you get a small floating widget on your desktop that shows:

- **Now Playing** — title, user, stream quality, and progress for each active session on your server
- **Bandwidth** — real-time total throughput across all streams
- **System Info** — quick look at CPU and memory usage on the machine running the widget

The widget auto-sizes itself based on how many streams are active — one stream keeps it compact, multiple streams expand it just enough. No scrolling, no clutter.

It sits on a single desktop (not mirrored across Spaces), stays behind your windows, and gets out of your way when you don't need it.

## Before You Start

You'll need a few things:

1. **A Mac** running macOS 14 (Sonoma) or later
2. **Xcode 15** or newer — free from the Mac App Store
3. **XcodeGen** — a small tool that generates the Xcode project file from a simple config. Install it by opening Terminal and running:

```bash
brew install xcodegen
```

If you don't have Homebrew yet, grab it first from [brew.sh](https://brew.sh).

4. **Your P Media Server details:**
   - The server URL (something like `http://192.168.1.100:32400`)
   - Your authentication token (you can find this by signing into your server's web app, opening any media item's XML page, and grabbing the `X-Plex-Token` value from the URL)

## Building It

Open Terminal, navigate to where you downloaded/cloned the project, and run:

```bash
cd PlexDesktopWidgets
xcodegen generate
```

This creates the `.xcodeproj` file. Now open it:

```bash
open PlexDesktopWidgets.xcodeproj
```

In Xcode:

1. Select your Mac as the build target (top toolbar, next to the play button)
2. Hit **⌘R** (or click the Play button) to build and run

That's it — the widget should appear on your desktop and a small icon will show up in your menu bar.

## First-Time Setup

When the app launches for the first time, right-click (or Control-click) the menu bar icon and choose **Preferences**. Enter your server URL and authentication token, then click Save. The widget will start polling your server and showing live data within a few seconds.

## Running It at Login

If you want the widget to start automatically when you log in:

1. Open **System Settings → General → Login Items**
2. Click the **+** button
3. Navigate to your Applications folder (or wherever you put the built app) and select it

## Installing the Built App

After building in Xcode, you can find the compiled `.app` in Xcode's build output:

```
~/Library/Developer/Xcode/DerivedData/PlexDesktopWidgets-<something>/Build/Products/Debug/
```

Just drag that `.app` file into your **Applications** folder — or anywhere you like, really. It runs from wherever you put it.

## Troubleshooting

**Widget doesn't appear?**
Make sure your server URL is correct and includes the port number. The most common issue is a missing `http://` prefix or wrong port.

**Shows "No Active Streams" all the time?**
Double-check your authentication token. If it's expired or incorrect, the app can't see your sessions. Try generating a fresh token from your server's web interface.

**Widget shows on all desktops?**
The app is designed to pin to a single desktop. If it's showing everywhere, try right-clicking the dock icon (if visible) → Options → and make sure "Assign to This Desktop" is selected.

**High CPU usage?**
The widget polls your server every 8 seconds. If your server is remote or slow to respond, you might see brief spikes. This is normal and shouldn't cause sustained load.

## License

This project is licensed under the [GNU General Public License v3.0](LICENSE). You're free to use, modify, and distribute it — just make sure any derivative work stays open source under the same license.

© 2025–2026 Jason Barton / TikabooLabs
