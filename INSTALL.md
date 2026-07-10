# Install Reela CLI

> **For AI Agents**: Follow this guide step-by-step. Run each command, verify the output, then proceed to the next step.

## Step 1 — Install reela-cli

```sh
curl -fsSL https://raw.githubusercontent.com/reela-ai/reela-cli/main/install.sh | bash
```

After installation, verify it works:

```sh
reela --help
```

If `reela` is not found, add `~/.local/bin` to your PATH:

```sh
export PATH="$HOME/.local/bin:$PATH"
```

## Step 2 — Discover local CLI docs

Direct CLI command docs are installed locally to `~/.reela/docs`. Discover exact paths at runtime:

```sh
reela docs
```

Expected files include:

```txt
~/.reela/docs/create.md
~/.reela/docs/daemon.md
~/.reela/docs/config.md
~/.reela/docs/tasks.md
~/.reela/docs/show.md
```

Agents should run `reela docs` before using Reela CLI so they can read only the docs needed for the current task. Agent workflow, posture, and use cases live in the optional Reela skills.

## Step 3 — Login

Run the login command to authenticate:

```sh
reela login
```

This uses OAuth Device Flow. Follow the on-screen instructions — open the URL in your browser and enter the code to authorize.

After login, verify your identity:

```sh
reela whoami
```

## How to Update

To update reela-cli to the latest version, re-run the install script:

```sh
curl -fsSL https://raw.githubusercontent.com/reela-ai/reela-cli/main/install.sh | bash
```

CLI docs are versioned with each release and installed to `~/.reela/docs`. After updating, run `reela docs` to discover the current local docs paths.

## Step 4 — Done!

Setup is complete. Tell the user that Reela CLI is ready and they can now ask you to create videos.

> **Important**: When using `reela` to create videos, run `reela docs` for local direct CLI reference. Reela skills are optional enhancements for agent workflow.
