---
name: reela-cli-usage
description: Reela CLI command reference for AI agents
version: 0.1.0
---

# Reela CLI Usage

Quick reference for the `reela` command-line tool.

## Authentication
- `reela login` — OAuth Device Flow login (outputs JSON stages)
- `reela logout` — Remove stored credentials
- `reela whoami` — Display current user info (JSON)

## Video Creation
- `reela create <prompt> [flags]` — Create a new video task
- `reela create --prompt-file <path> [flags]` — Create from prompt file
- Key flags: `--duration`, `--layout`, `--tier`, `--visual`, `--avatar`, `--dry-run`, `--idempotency-key`

## Task Management
- `reela tasks list [--status <n>] [--limit <n>] [--offset <n>]` — List tasks
- `reela tasks get <id>` — Get task details
- `reela tasks download <id> [-o <path>]` — Download completed video
- `reela tasks retry <id>` — Retry a failed task

## Status & Config
- `reela status` — Global status (auth, daemon, delivery, quota)
- `reela config set <key> <value>` — Set config value
- `reela config get <key>` — Get config value
- `reela config list` — List all config

## Daemon
- `reela daemon start [--foreground]` — Start background daemon
- `reela daemon stop` — Stop daemon
- `reela daemon status` — Check daemon status
- `reela daemon install` — Install as system service
- `reela daemon uninstall` — Uninstall the system service
- `reela daemon logs --tail <n>` — View recent logs

## Global Flags
`--profile <name>`, `--api-base <url>`, `--output json|table|plain`, `--no-color`, `--verbose`

## Environment Variables
`REELA_PROFILE`, `REELA_API_BASE`, `REELA_OUTPUT`

## Exit Codes
| Code | Meaning |
|------|---------|
| 0 | Success |
| 1 | General error |
| 2 | Auth failure |
| 3 | Bad request |
| 4 | Not found |
| 5 | Quota exhausted |
| 6 | Timeout |

## Reference

Detailed documentation is available in the `reference/` directory:

| File | Description |
|------|-------------|
| [create-params.md](./reference/create-params.md) | `reela create` 命令的完整参数说明，包括必选/可选参数、Visual 类型枚举和用法示例 |
| [uploads.md](./reference/uploads.md) | 媒体上传指南，说明如何通过 `--upload` 标志上传图片、视频、音乐作为素材（计划中功能） |
| [tiers.md](./reference/tiers.md) | 视频质量等级对比表，包含各等级的画质、速度、积分消耗及推荐场景 |
