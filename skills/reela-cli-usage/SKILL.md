---
name: reela-cli-usage
description: Reela CLI command reference for AI agents. Always load this skill before using any `reela` command.
version: 0.1.0
---

# Reela CLI Usage

Reela is an AI video creation platform that turns text, images, video clips, and music into finished videos. The `reela` CLI lets you create videos, manage tasks, and configure delivery — all from the terminal.

**You are the operator.** When the user wants to create a video, run `reela` commands yourself rather than instructing the user to run them. Handle the full workflow: prepare inputs, assemble the command, execute it, and report the result.

> **IMPORTANT — Dry-run before create:** Before submitting any `reela create` command, you **must** first run it with `--dry-run` to validate the request. Show the dry-run output to the user and wait for their explicit confirmation before running the actual command (without `--dry-run`). Never skip this step.

## Discovering Commands

Run `reela -h` or `reela <command> -h` to see available commands and flags. The CLI has comprehensive built-in help — use it instead of memorizing syntax.

## Install / Update

If `reela` is not installed or you need to update, follow the install guide:

> https://github.com/reelanything/reela-cli/blob/main/INSTALL.md

## Task Status Codes

| Code | Label      |
| ---- | ---------- |
| 0    | cancelled  |
| 1    | pending    |
| 2    | processing |
| 10   | failed     |
| 26   | partial    |
| 130  | completed  |

## File System Locations

| Path                            | Purpose                     |
| ------------------------------- | --------------------------- |
| `~/.reela/config.toml`          | CLI configuration           |
| `~/.reela/credentials.json`     | Stored OAuth credentials    |
| `~/.reela/daemon.pid`           | Daemon PID file             |
| `~/.reela/daemon.log`           | Daemon log file             |
| `~/.reela/tiers.json`           | Cached tier config          |
| `~/.config/reela/sessions.json` | Session-to-collection index |
| `~/Videos/reela/`               | Default download directory  |

## Reference

Detailed documentation is available in the `reference/` directory:

| File                                                   | Description                                                                                         |
| ------------------------------------------------------ | --------------------------------------------------------------------------------------------------- |
| [agent-workflow.md](./reference/agent-workflow.md)     | Agent workflow guide: input preparation, file classification decisions, and end-to-end examples     |
| [create-params.md](./reference/create-params.md)       | Supplementary notes for `reela create` — visual combinations, session grouping                       |
| [file-attachments.md](./reference/file-attachments.md) | File role decision guide: how to choose the right `--file` role for images, videos, and music       |
| [daemon.md](./reference/daemon.md)                     | Daemon & delivery: auto-download/email on task completion, configuration keys                       |
