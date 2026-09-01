---
title: Reela Config
description: Manage profiles, downloads, notifications, and delivery settings.
version: 1.22.1
---

# Reela Config

Run `reela config -h` or `reela config <subcommand> -h` for current options.

## View and change settings

```bash
reela config list
reela config get <key>
reela config set <key> <value>
```

## Common settings

| Setting | Use | Example |
| --- | --- | --- |
| `delivery.download` | Choose the download folder | `~/Videos/reela` |
| `delivery.notify` | Turn desktop notifications on or off | `true` |
| `delivery.max_retries` | Choose how many times delivery is retried | `3` |
| `delivery.script.path` | Choose a custom delivery script | `~/bin/reela-callback.sh` |
| `delivery.script.timeout_seconds` | Set the script time limit | `300` |
| `delivery.script.max_retries` | Choose how many times the script is retried | `3` |

Examples:

```bash
reela config set delivery.download ~/Videos/reela
reela config set delivery.notify true
reela config set delivery.max_retries 3
```

See the `script` guide listed by `reela -h` to use a custom delivery script.

## Profiles

```bash
reela config profiles list
reela config profiles create work
reela config profiles use work
reela config profiles show
reela config profiles show work
reela config profiles delete work
```

Use a profile for one command without changing the active profile:

```bash
reela --profile work whoami
reela --profile work config set delivery.download ~/Videos/reela-work
```

## Access token

For unattended commands, provide an access token in the command environment:

```bash
REELA_ACCESS_TOKEN=<token> reela whoami
```

Remove the environment variable when you no longer want to use it.
