---
title: Reela Tasks
description: List, inspect, and download generated videos.
version: 1.22.1
---

# Reela Tasks

Run `reela tasks -h` or `reela tasks <subcommand> -h` for current options.

## List tasks

```bash
reela tasks list
reela tasks list --status completed
reela tasks list --limit 20 --offset 0 --sort created_at:desc
```

Available status filters include `pending`, `processing`, `failed`, `completed`, `cancelled`, and `partial`.

## Show one task

```bash
reela tasks get <task-id>
reela --output json tasks get <task-id>
```

## Download a finished video

```bash
reela tasks download <task-id>
reela tasks download <task-id> --out-dir ~/Videos/reela
```

If no output directory is given, Reela uses the configured download directory.
