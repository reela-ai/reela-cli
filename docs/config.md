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
| `delivery.script.path` | Optional delivery hook script path. |
| `delivery.script.timeout_seconds` | Timeout for the delivery hook script. Default: `300`. |

Examples:

```bash
reela config set delivery.download ~/Videos/reela
reela config set delivery.notify true
reela config set delivery.script.path ./on-reela-complete.sh
reela config set delivery.script.timeout_seconds 300
```

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
