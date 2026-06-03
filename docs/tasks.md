---
title: Reela Tasks
description: List, inspect, wait for, and download generated video tasks from the Reela CLI.
version: 1.15.3
---

# Reela Tasks

Reference for direct Reela CLI task commands.

> For live command syntax, run `reela tasks -h` and `reela tasks <subcommand> -h`.

## List tasks

```bash
reela tasks list
```

Useful pagination and sorting options:

```bash
reela tasks list --limit 20 --offset 0 --sort created_at:desc
```

Task status is shown and filtered as a text label, such as `pending`, `processing`, `failed`, `completed`, `cancelled`, or `partial`.

```bash
reela tasks list --status completed
```

The CLI does not accept numeric task status codes.

## Show one task

```bash
reela tasks get <task_id>
```

This shows the task status, progress, and prompt. Use `--output json` for machine-readable output.

## Download task output

```bash
reela tasks download <task_id>
reela tasks download <task_id> --out-dir ~/Videos/reela
```

If `--out-dir` is omitted, the CLI uses `delivery.download` from config.

## Retry

```bash
reela tasks retry <task_id>
```

Retry is not available yet.
