---
title: Custom Delivery Scripts
description: Run a local script when a video finishes or fails.
version: 1.22.2
---

# Custom Delivery Scripts

Run `reela subscribe -h` and `reela subscribe add -h` for current options.

## 1. Create a script

Create `~/bin/reela-callback.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail

payload="$(cat)"

event="$(printf '%s' "$payload" | python3 -c '
import json, sys
print(json.load(sys.stdin).get("event", ""))
')"

task_id="$(printf '%s' "$payload" | python3 -c '
import json, sys
print(json.load(sys.stdin).get("task_id", ""))
')"

case "$event" in
  task.completed)
    echo "Reela task completed: $task_id"
    ;;
  task.failed)
    echo "Reela task failed: $task_id" >&2
    ;;
esac
```

Make it executable:

```bash
chmod +x ~/bin/reela-callback.sh
```

## 2. Enable it

```bash
reela subscribe add script \
  --path ~/bin/reela-callback.sh \
  --timeout-seconds 300 \
  --max-retries 3
```

Check the setup:

```bash
reela subscribe status
```

## Script input

The script reads one JSON object from standard input. Use these fields as needed:

| Field | Value |
| --- | --- |
| `event` | `task.completed` or `task.failed` |
| `task_id` | Task ID |
| `status` | Task status |
| `title` | Task title, when available |
| `description` | Task description, when available |
| `download.filename` | Suggested filename, when available |
| `download.download_url` | Download URL, when available |

Example:

```json
{
  "event": "task.completed",
  "task_id": "12345",
  "status": "completed",
  "title": "Product demo video",
  "download": {
    "filename": "product-demo.mp4",
    "download_url": "https://..."
  }
}
```

`download` may be `null`. Check that a download URL exists before using it.

## Change or disable the script

```bash
reela config set delivery.script.path ~/bin/reela-callback.sh
reela config set delivery.script.timeout_seconds 300
reela config set delivery.script.max_retries 3
reela subscribe remove script
```

Keep download URLs private, use only trusted scripts, and return exit code `0` when the script succeeds.
