---
name: reela-cli-usage
description: Reela CLI command reference for AI agents. Always load this skill before using any `reela` command.
version: 0.1.0
---

# Reela CLI Usage

Reela is an AI video creation platform that turns text, images, video clips, and music into finished videos. The `reela` CLI lets you create videos, manage tasks, and configure delivery — all from the terminal.

**You are the operator.** When the user wants to create a video, run `reela` commands yourself rather than instructing the user to run them. Handle the full workflow: prepare inputs, assemble the command, execute it, and report the result.

## Install / Update

If `reela` is not installed or you need to update, follow the install guide:

> https://github.com/reelanything/reela-cli/blob/main/INSTALL.md

## Authentication

- `reela login` — OAuth Device Flow login (outputs JSON stages)
- `reela logout` — Remove stored credentials
- `reela whoami` — Display current user info (JSON)

## Video Creation

- `reela create <prompt> [flags]` — Create a new video task
- `reela create --prompt-file <path> [flags]` — Create from prompt file
- Key flags: `--duration`, `--layout`, `--tier`, `--visual`, `--avatar`, `--file`, `--session`, `--dry-run`, `--idempotency-key`

## Task Management

- `reela tasks list [--status <n>] [--limit <n>] [--offset <n>] [--sort <field:dir>]` — List tasks (sort default: `created_at:desc`)
- `reela tasks get <id>` — Get task details
- `reela tasks download <id> [-o <path>]` — ⚠️ Not yet implemented
- `reela tasks retry <id>` — ⚠️ Not yet implemented

## Status & Config

- `reela status` — Global status (auth, daemon, delivery, quota)
- `reela config set <key> <value>` — Set config value
- `reela config get <key>` — Get config value
- `reela config list` — List all config
- `reela config profiles list` — List all profiles
- `reela config profiles use <name>` — Set the active profile

## Global Flags

`--profile <name>`, `--api-base <url>`, `--output json|table|plain`, `--no-color`, `--verbose`

## Environment Variables

`REELA_PROFILE`, `REELA_API_BASE`, `REELA_OUTPUT`, `REELA_COLLECTION_ID`, `RUST_LOG` (daemon log level)

## File System Locations

| Path                            | Purpose                     |
| ------------------------------- | --------------------------- |
| `~/.reela/config.toml`          | CLI configuration           |
| `~/.reela/credentials.json`     | Stored OAuth credentials    |
| `~/.reela/daemon.pid`           | Daemon PID file             |
| `~/.reela/daemon.log`           | Daemon log file             |
| `~/.config/reela/sessions.json` | Session-to-collection index |
| `~/Videos/reela/`               | Default download directory  |

## Exit Codes

| Code | Meaning         |
| ---- | --------------- |
| 0    | Success         |
| 1    | General error   |
| 2    | Auth failure    |
| 3    | Bad request     |
| 4    | Not found       |
| 5    | Quota exhausted |
| 6    | Timeout         |

## Task Status Codes

| Code | Label      |
| ---- | ---------- |
| 0    | cancelled  |
| 1    | pending    |
| 2    | processing |
| 10   | failed     |
| 26   | partial    |
| 130  | completed  |

## Reference

Detailed documentation is available in the `reference/` directory:

| File                                                   | Description                                                                                                                       |
| ------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------- |
| [create-params.md](./reference/create-params.md)       | Full parameter reference for `reela create`, including required/optional params, visual types, and usage examples                 |
| [file-attachments.md](./reference/file-attachments.md) | File attachment guide: how to upload images, videos, and music as source material via the `--file` flag                           |
| [agent-workflow.md](./reference/agent-workflow.md)     | Agent workflow guide: input preparation, file classification decisions, video production model, and end-to-end examples           |
| [tiers.md](./reference/tiers.md)                       | Video quality tier comparison: resolution, speed, credit cost, and recommended use cases                                          |
| [daemon.md](./reference/daemon.md)                     | Daemon & subscribe: auto-download/email delivery on task completion, `reela subscribe` / `reela daemon` commands, config keys, auto-start setup |
