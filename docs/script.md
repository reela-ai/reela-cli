---
title: Custom Delivery Scripts
description: Build local delivery callback scripts, understand payloads, retries, timeouts, and safety practices.
version: 1.17.3
---

# Custom Delivery Scripts

Reela CLI can run your own local script when a video task completes or fails. Use this to connect Reela with your own workflow, such as moving files, sending a local notification, updating a spreadsheet, or triggering another tool.

> For live command syntax, run `reela subscribe -h` and `reela subscribe add -h`.

## 1. Create a script file

Create a file such as `~/bin/reela-callback.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail

payload="$(cat)"

json_get() {
  python3 -c '
import json, sys
path = sys.argv[1].split(".")
default = sys.argv[2]
data = json.load(sys.stdin)
for key in path:
    if not isinstance(data, dict) or data.get(key) is None:
        print(default)
        sys.exit(0)
    data = data[key]
print(data)
' "$1" "$2"
}

event="$(printf '%s' "$payload" | json_get event '')"
task_id="$(printf '%s' "$payload" | json_get task_id '')"
title="$(printf '%s' "$payload" | json_get title 'Untitled')"

case "$event" in
  task.completed)
    filename="$(printf '%s' "$payload" | json_get download.filename 'video.mp4')"
    echo "Reela task completed: $task_id - $title ($filename)"
    ;;
  task.failed)
    echo "Reela task failed: $task_id - $title" >&2
    ;;
  *)
    echo "Ignoring Reela event: $event"
    ;;
esac
```

Make it executable:

```bash
chmod +x ~/bin/reela-callback.sh
```

The examples parse JSON without requiring extra packages. If your environment uses different tooling, adapt the parsing helper to tools that are already available.

## 2. Enable the script delivery method

```bash
reela subscribe add script --path ~/bin/reela-callback.sh --timeout-seconds 300 --max-retries 3
```

The daemon must be running for delivery scripts to run. `reela subscribe add` starts it automatically when possible. You can also manage it manually:

```bash
reela daemon start
reela subscribe status
```

## 3. Payload your script receives

Reela sends one JSON object to the script through standard input. The fields are intended for user automation and may be read directly by your script.

Completed task example:

```json
{
  "event": "task.completed",
  "task_id": "12345",
  "status": "completed",
  "status_label": "completed",
  "title": "Product demo video",
  "description": "A short product demo",
  "download": {
    "filename": "product-demo.mp4",
    "download_url": "https://..."
  }
}
```

Failed task example:

```json
{
  "event": "task.failed",
  "task_id": "12345",
  "status": "failed",
  "status_label": "failed",
  "title": "Product demo video",
  "description": "A short product demo",
  "download": null
}
```

Useful fields:

| Field                     | Description                                         |
| ------------------------- | --------------------------------------------------- |
| `event`                   | `task.completed` or `task.failed`.                  |
| `task_id`                 | Reela task ID.                                      |
| `status` / `status_label` | Human-readable task status.                         |
| `title`                   | Task title when available.                          |
| `description`             | Task description when available.                    |
| `download.filename`       | Suggested output filename for completed tasks.      |
| `download.download_url`   | Temporary private download URL for completed tasks. |

`download` can be `null`, so scripts should handle missing download information.

## Optional: download the result in your script

If you want the script itself to download the output, use the temporary `download.download_url` only for the current task:

```bash
url="$(printf '%s' "$payload" | json_get download.download_url '')"
filename="$(printf '%s' "$payload" | json_get download.filename 'video.mp4')"

if [ -n "$url" ]; then
  curl -fL "$url" -o "$filename"
fi
```

## Update or disable the script

Change the script path, timeout, or retry limit:

```bash
reela config set delivery.script.path ~/bin/reela-callback.sh
reela config set delivery.script.timeout_seconds 300
reela config set delivery.script.max_retries 5
```

Disable script delivery:

```bash
reela subscribe remove script
```

## Safety guidelines

- Treat `download.download_url` as private. Do not print it to public logs or share it.
- Keep the script on your local machine and only use scripts you trust.
- Validate file paths before moving or deleting files.
- Return exit code `0` for success. A non-zero exit code marks the script run as failed.
- Failed delivery is retried up to `delivery.max_retries` times by default (`3`). Use `--max-retries` or `delivery.script.max_retries` to control script retries.
- Avoid setting retries too high: a script that keeps failing can hold the queue until its retry limit is reached.
- Keep scripts short and reliable; use `--timeout-seconds` to avoid hanging delivery.
