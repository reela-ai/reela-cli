# Install Reela CLI & Skills

> **For AI Agents**: Follow this guide step-by-step. Run each command, verify the output, then proceed to the next step.

## Step 1 — Install reela-cli

```sh
curl -fsSL https://raw.githubusercontent.com/reelanything/reela-cli/main/install.sh | bash
```

After installation, verify it works:

```sh
reela --help
```

If `reela` is not found, add `~/.local/bin` to your PATH:

```sh
export PATH="$HOME/.local/bin:$PATH"
```

## Step 2 — Install reela skills

The skill at `https://github.com/reelanything/reela-cli` is required for using `reela-cli`. Install it to your local skills directory.

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
curl -fsSL https://raw.githubusercontent.com/reelanything/reela-cli/main/install.sh | bash
```

After updating the binary, ask the user if they would also like to update the `reela-cli-usage` skill (recommended). If yes, re-install the skill from the repo to your local skills directory.

## Step 4 — Done!

Setup is complete. Tell the user that Reela CLI is ready and they can now ask you to create videos.

> **Important**: When using `reela` to create videos, always load the `reela-cli-usage` skill first.
