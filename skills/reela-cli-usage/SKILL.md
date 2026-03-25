---
name: reela-cli-usage
description: Reela CLI command reference for AI agents. Always load this skill before using any `reela` command.
version: 0.1.0
---

# Reela CLI Usage

## Install / Update

If `reela` is not installed or you need to update, follow the install guide:

> https://github.com/reelanything/reela-cli/blob/main/INSTALL.md

Quick reference for the `reela` command-line tool.

## Authentication

- `reela login` — OAuth Device Flow login (outputs JSON stages)
- `reela logout` — Remove stored credentials
- `reela whoami` — Display current user info (JSON)

## Video Creation

- `reela create <prompt> [flags]` — Create a new video task
- `reela create --prompt-file <path> [flags]` — Create from prompt file
- Key flags: `--duration`, `--layout`, `--tier`, `--visual`, `--avatar`, `--file`, `--session`, `--dry-run`, `--idempotency-key`

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

`REELA_PROFILE`, `REELA_API_BASE`, `REELA_OUTPUT`, `REELA_COLLECTION_ID`

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

## Update

To update reela-cli and this skill, fetch the install guide for instructions:

https://raw.githubusercontent.com/reelanything/reela-cli/main/INSTALL.md

## Reference

Detailed documentation is available in the `reference/` directory:

| File                                             | Description                                                                          |
| ------------------------------------------------ | ------------------------------------------------------------------------------------ |
| [create-params.md](./reference/create-params.md) | `reela create` 命令的完整参数说明，包括必选/可选参数、Visual 类型枚举和用法示例      |
| [file-attachments.md](./reference/file-attachments.md) | 文件附件指南，说明如何通过 `--file` 标志上传图片、视频、音乐作为素材 |
| [tiers.md](./reference/tiers.md)                 | 视频质量等级对比表，包含各等级的画质、速度、积分消耗及推荐场景                       |
