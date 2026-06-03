---
title: Daemon & Delivery
description: Run the background daemon, subscribe to task updates, and deliver completed videos automatically.
version: 1.15.3
---

# Daemon & Delivery

The daemon is a background process that monitors task completion and delivers finished videos. Without it, the user has to poll `reela tasks list` manually.

> For live command syntax, run `reela daemon -h` and `reela subscribe -h`.

## What it does

- Watches for task completion (success or failure)
- Saves finished `.mp4` files to a local directory
- Sends OS notifications when a task completes or fails
- Optionally emails the video link
- Optionally runs your custom local script when a task completes or fails
- Runs detached from your CLI session — submit a task, close the terminal, get the video later

## Start the daemon

Start the daemon with:

```bash
reela daemon start
```

Or set it to start automatically on login (one-time setup):

```bash
reela daemon install
```

After that, submitted tasks are delivered automatically.

By default, daemon startup ignores older task updates from before the daemon started. To intentionally process existing older updates, start it with:

```bash
reela daemon start --keep-backlog
```

## Configuration

| Key | Default | Description |
|-----|---------|-------------|
| `delivery.download` | `~/Videos/reela` | Download directory |
| `delivery.notify` | `true` | OS desktop notifications |
| `delivery.methods` | `["download"]` | Active delivery method(s) — `download`, `email`, `script` |
| `delivery.max_retries` | `3` | Maximum daemon delivery attempts before giving up and removing a stuck queue message |
| `delivery.email.address` | (account email) | Custom email address for email delivery |
| `delivery.script.path` | (empty) | Custom local script to run on completion/failure |
| `delivery.script.timeout_seconds` | `300` | Script timeout in seconds |
| `delivery.script.max_retries` | `delivery.max_retries` | Maximum script delivery attempts when only the script hook fails |

Set via `reela config set <key> <value>`.

## Email delivery

To enable email delivery:

```bash
reela config set delivery.methods '["download", "email"]'
reela config set delivery.email.address user@example.com
```

The daemon will save the file locally AND email a link on completion.

## Custom script delivery

To run your own local script when a task completes or fails:

```bash
reela subscribe add script --path ~/bin/reela-callback.sh --timeout-seconds 300 --max-retries 3
```

For script creation, payload format, and safety guidelines, see `script.md` from `reela docs`.

## Manual polling without the daemon

Tasks still continue in Reela when the daemon is not running. Check task status manually with:

```bash
reela tasks list           # see all tasks
reela tasks get <task_id>  # check one task's status
```

When status reaches `completed`, download the output with `reela tasks download <task_id>`.
