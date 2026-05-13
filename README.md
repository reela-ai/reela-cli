# Reela CLI

Command-line interface for [Reela](https://reela.com) — create AI-powered videos from your terminal.

## Installation

### Install with AI Agent

Tell your agent:

> Follow <https://github.com/reela-ai/reela-cli/blob/main/INSTALL.md> to install Reela CLI, then install the Reela skills from <https://github.com/reela-ai/skills>.

### Manual Install (Linux / macOS)

```sh
curl -fsSL https://raw.githubusercontent.com/reela-ai/reela-cli/main/install.sh | bash
```

### Install skills

```sh
npx skills add https://github.com/reela-ai/skills -g
```

## Quick Start

```sh
# Log in to your Reela account
reela login

# Create a video
reela create -p "A 30-second product demo for my app"

# Check video status
reela status

# View all tasks
reela tasks
```

## Commands

| Command  | Description                          |
| -------- | ------------------------------------ |
| `login`  | Authenticate with your Reela account |
| `logout` | Remove stored credentials            |
| `whoami` | Show current authenticated user      |
| `create` | Create a new video                   |
| `status` | Check status of recent tasks         |
| `tasks`  | List all tasks                       |
| `config` | Manage CLI configuration             |

## Configuration

Configuration is stored in `~/.reela/`. Profiles isolate API base URL, credentials, caches, session-to-collection mappings, and daemon runtime files under `~/.reela/profiles/<name>/`. Delivery settings remain global.

```sh
reela config profiles list
reela config profiles create <profile-name>
reela --profile <profile-name> login
reela config profiles use <profile-name>
reela config profiles show
```

Use `--profile <name>` or `REELA_PROFILE=<name>` for one-off commands, or `reela config profiles use <name>` to set the active profile.

## License

Proprietary. See [reela.com](https://reela.com) for terms of service.
