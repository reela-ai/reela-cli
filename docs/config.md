---
title: Reela Config
description: Configure CLI profiles, API endpoints, delivery methods, download paths, and local settings.
version: 1.15.3
---

# Reela Config

Reference for direct Reela CLI configuration commands.

> For live command syntax, run `reela config -h` and `reela config <subcommand> -h`.

## Config storage

Configuration is stored under `~/.reela/`.

- `~/.reela/` stores local CLI configuration.
- Profiles let you keep separate Reela accounts and local settings under `~/.reela/profiles/<name>/`.
- Delivery settings are shared across profiles.

## Common commands

```bash
reela config list
reela config get <key>
reela config set <key> <value>
reela config sync
```

`reela config sync` refreshes local CLI settings from Reela. Run it if the CLI reports that local configuration is stale or missing.

## Supported config keys

| Key | Description |
| --- | --- |
| `delivery.download` | Directory used by daemon delivery and `reela tasks download` when no `--out-dir` is provided. Default: `~/Videos/reela`. |
| `delivery.notify` | Enable OS desktop notifications. Use `true` or `false`. |
| `delivery.max_retries` | Maximum daemon delivery attempts before giving up and removing a stuck queue message. Default: `3`. |
| `delivery.script.path` | Optional custom local delivery script path. |
| `delivery.script.timeout_seconds` | Timeout for the custom delivery script. Default: `300`. |
| `delivery.script.max_retries` | Maximum script delivery attempts when only the script hook fails. Defaults to `delivery.max_retries`. |

Examples:

```bash
reela config set delivery.download ~/Videos/reela
reela config set delivery.notify true
reela config set delivery.max_retries 3
reela config set delivery.script.path ./on-reela-complete.sh
reela config set delivery.script.timeout_seconds 300
reela config set delivery.script.max_retries 5
```

For instructions on creating a custom delivery script, see `script.md` from `reela docs`.

## Profiles

Use profiles to switch between Reela accounts or separate local workspaces.

```bash
reela config profiles list
reela config profiles create <profile-name>
reela config profiles use <profile-name>
reela config profiles show [profile-name]
reela config profiles delete <profile-name>
```

Use `--profile <name>` or `REELA_PROFILE=<name>` for one-off commands without changing the active profile.
