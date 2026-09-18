---
title: Reela Tasks
description: List, inspect, and download generated videos.
version: 1.23.0
---

# Reela Tasks

Run `reela tasks -h` or `reela tasks <subcommand> -h` for current options.

## List videos in the active collection

```bash
reela collection list
reela collection list --session "Spring product launch"
reela collection list --output json
reela collection list --output table
```

Lists video IDs, status, full titles, descriptions, and download URLs, newest first.
Download URLs are available for completed videos and expire after one hour.
Missing metadata is shown as `-` in text output and `null` in JSON.

Collection selection follows `create`: a non-blank `REELA_COLLECTION_ID` takes
priority over `--session`; otherwise the session is looked up in the current
profile. Without `--session`, the default is `reela-YYYY-MM-DD` using the local
date, not the most recently used session. Use `--profile` to select another profile.

This command never creates a collection. A missing active collection produces an
error with guidance; an existing empty collection returns an empty video list.
Run `reela collection list -h` for options.

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

Shows ID, status, progress, and prompt, plus the complete saved creation parameters:

- `content`: prompt and video configuration (`spec`), including duration, layout,
  pipeline tier/visual/music settings, and avatars.
- `reference`: reference inputs, including uploaded file metadata and webpage metadata.

Text output prints both objects as formatted JSON. With `--output json`, they are
returned as `content` and `reference` alongside `id`, `status`, `progress`, and
`prompt`. Missing objects are `null`.

These are the server's saved values, not the original CLI arguments: layout and
visual values use internal identifiers, and uploaded inputs contain stored
metadata rather than local file paths. The output is not a replayable `create`
request.

## Download a finished video

```bash
reela tasks download <task-id>
reela tasks download <task-id> --out-dir ~/Videos/reela
```

If no output directory is given, Reela uses the configured download directory.
