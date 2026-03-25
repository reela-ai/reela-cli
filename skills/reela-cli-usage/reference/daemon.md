# Daemon

The daemon is a background process that monitors task completion and delivers finished videos to the user's machine.

## What It Does

- Watches for completed (or failed) video tasks
- **Download delivery:** Saves finished `.mp4` files to a local directory and sends an OS notification
- **Email delivery:** Triggers an email with the video link and sends an OS notification
- On failure: sends an OS notification alerting the user

## Managing Delivery Methods

Use `reela subscribe` to control what happens when a video finishes:

- `reela subscribe add download [--dir <path>]` — Enable auto-download (daemon starts automatically)
- `reela subscribe add email [--address <email>]` — Enable email delivery (daemon starts automatically)
- `reela subscribe remove <method>` — Disable a method (daemon stops if none remain)
- `reela subscribe list` — Show active delivery methods
- `reela subscribe status` — Show daemon status and active methods

## Daemon Commands

- `reela daemon start` — Start the daemon in background
- `reela daemon stop` — Stop the daemon
- `reela daemon status` — Check if running
- `reela daemon install` — Auto-start on boot (macOS LaunchAgent / Linux systemd user unit)
- `reela daemon uninstall` — Remove auto-start
- `reela daemon logs [--tail <n>]` — View recent logs (default: 20)

## Configuration

| Key | Default | Description |
|-----|---------|-------------|
| `delivery.download` | `~/Videos/reela` | Download directory |
| `delivery.notify` | `true` | Enable/disable OS notifications |
| `delivery.methods` | `["download"]` | Active delivery method(s) |
| `delivery.email.address` | (account email) | Custom email for email delivery |
