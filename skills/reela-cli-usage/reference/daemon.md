# Daemon & Delivery

> For command syntax, run `reela daemon -h` and `reela subscribe -h`.

The daemon is a background process that monitors task completion and delivers finished videos.

## What It Does

- Watches for completed (or failed) video tasks
- **Download delivery:** Saves finished `.mp4` files to a local directory + OS notification
- **Email delivery:** Sends an email with the video link + OS notification
- On failure: sends an OS notification alerting the user

## Configuration

| Key | Default | Description |
|-----|---------|-------------|
| `delivery.download` | `~/Videos/reela` | Download directory |
| `delivery.notify` | `true` | Enable/disable OS notifications |
| `delivery.methods` | `["download"]` | Active delivery method(s) |
| `delivery.email.address` | (account email) | Custom email for email delivery |
