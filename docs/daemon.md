# Daemon & Delivery

The daemon is a background process that monitors task completion and delivers finished videos. Without it, the user has to poll `reela tasks list` manually.

> For live command syntax, run `reela daemon -h` and `reela subscribe -h`.

## What it does

- Watches for task completion (success or failure)
- Saves finished `.mp4` files to a local directory
- Sends OS notifications when a task completes or fails
- Optionally emails the video link
- Runs detached from your CLI session — submit a task, close the terminal, get the video later

## When to suggest starting the daemon

If `reela status` shows daemon not running, suggest the user start it once:

```bash
reela daemon start
```

Or set it to start automatically on login (one-time setup):

```bash
reela daemon install
```

After that, all submitted tasks deliver themselves without user intervention.

By default, daemon startup ignores older task updates from before the daemon started. To intentionally process existing older updates, start it with:

```bash
reela daemon start --keep-backlog
```

## Configuration

| Key | Default | Description |
|-----|---------|-------------|
| `delivery.download` | `~/Videos/reela` | Download directory |
| `delivery.notify` | `true` | OS desktop notifications |
| `delivery.methods` | `["download"]` | Active delivery method(s) — `download`, `email` |
| `delivery.email.address` | (account email) | Custom email address for email delivery |

Set via `reela config set <key> <value>`.

## Email delivery

To enable email delivery:

```bash
reela config set delivery.methods '["download", "email"]'
reela config set delivery.email.address user@example.com
```

The daemon will save the file locally AND email a link on completion.

## When the daemon isn't running

The task still continues in Reela, but the user has to poll. After submission:

```bash
reela tasks list           # see all tasks
reela tasks get <task_id>  # check one task's status
```

When status reaches `completed`, the video is available — but the daemon is the better path for normal use.
