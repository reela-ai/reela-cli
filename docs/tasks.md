# Reela Tasks

Reference for direct Reela CLI task commands.

> For live command syntax, run `reela tasks -h` and `reela tasks <subcommand> -h`.

## List tasks

```bash
reela tasks list
```

Useful filters:

```bash
reela tasks list --limit 20 --offset 0 --sort created_at:desc
reela tasks list --status 130
```

Status codes:

| Code | Meaning |
| --- | --- |
| `0` | cancelled |
| `1` | pending |
| `2` | processing |
| `10` | failed |
| `130` | completed |

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
