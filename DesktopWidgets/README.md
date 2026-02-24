# Simple Server Desktop Widgets

Floating macOS desktop widgets that monitor a Plex Media Server in real time. Runs as a menu bar app with three independent, draggable widgets.

## Widgets

- **Now Playing** — Active streams with title, user, progress, quality, and bandwidth
- **Bandwidth** — Real-time LAN/WAN throughput with a 60-point historical chart
- **System** — Host and Plex CPU/RAM usage with sparkline history and health status

## Requirements

- macOS 14.0+
- Xcode 15.0+
- [XcodeGen](https://github.com/yonaskolb/XcodeGen)

## Setup

1. Clone the repo
2. Open `PlexDesktopWidgets/PlexConfig.swift` and set your Plex server URL and token, or configure them in the Settings window after launch
3. Run the install script:

```bash
./install.sh
```

This generates the Xcode project, builds a Release binary, installs it to `/Applications`, and launches the app.

## How It Works

The app polls the Plex server every 2 seconds for session, bandwidth, and resource data. System-level CPU and RAM metrics are collected via native Mach kernel APIs. Widgets float above the desktop without stealing focus, and their positions are saved between launches.

## License

MIT
