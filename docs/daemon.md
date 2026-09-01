---
title: Automatic Delivery
description: Automatically save finished videos and send completion notifications.
version: 1.22.1
---

# Automatic Delivery

Run `reela daemon -h` and `reela subscribe -h` for current options.

## Start automatic delivery

Start it for the current session:

```bash
reela daemon start
```

Set it to start automatically when you sign in to your computer:

```bash
reela daemon install
```

Check or stop it:

```bash
reela daemon status
reela daemon stop
```

View recent logs:

```bash
reela daemon logs
reela daemon logs --tail 50
```

## Choose delivery methods

List the current methods:

```bash
reela subscribe list
reela subscribe status
```

Save finished videos to a folder:

```bash
reela subscribe add download --dir ~/Videos/reela
```

Send a completion email:

```bash
reela subscribe add email --address user@example.com
```

Run a custom script:

```bash
reela subscribe add script --path ~/bin/reela-callback.sh --timeout-seconds 300 --max-retries 3
```

Remove a method:

```bash
reela subscribe remove email
reela subscribe remove script
```

See the `script` guide listed by `reela -h` for a custom script example.

## Download without automatic delivery

```bash
reela tasks list
reela tasks get <task-id>
reela tasks download <task-id>
```
