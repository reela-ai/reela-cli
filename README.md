# Reela CLI

Command-line interface for [Reela](https://reela.com) — create AI-powered videos from your terminal.

## Installation

### Install with AI Agent

Tell your agent:

> Follow <https://github.com/reela-ai/reela-cli/blob/main/INSTALL.md> to install Reela CLI. After installation, run `reela docs` to discover local CLI docs paths; for agent workflow and examples, use the Reela skills.

### Manual Install (Linux / macOS)

```sh
curl -fsSL https://raw.githubusercontent.com/reela-ai/reela-cli/main/install.sh | bash
```

### CLI docs

Direct CLI command docs are installed locally to `~/.reela/docs` by the install script and by `reela update`. Agents and users can discover exact local paths at runtime:

```sh
reela docs
```

The public repository also keeps a copy under `docs/`. Agent workflow and use cases live in the optional Reela skills.

## Quick Start

```sh
# Log in to your Reela account
reela login

# Create a video
reela create -p "A 30-second product demo for my app"

# See current quality/cost tiers
reela tiers list

# Check video status
reela status

# View all tasks
reela tasks
```

## Commands

| Command  | Description                          |
| -------- | ------------------------------------ |
| `login`  | Authenticate with your Reela account |
| `logout` | Sign out from this device            |
| `whoami` | Show current authenticated user      |
| `create` | Create a new video                   |
| `status` | Check status of recent tasks         |
| `tasks`  | List all tasks                       |
| `tiers`  | List current quality/cost tiers      |
| `show`   | Manage Show episode workspaces       |
| `config` | Manage CLI configuration             |
| `docs`   | Print local CLI documentation paths  |

## Configuration

Configuration is stored in `~/.reela/`. Profiles let you keep separate Reela accounts and local settings under `~/.reela/profiles/<name>/`. Delivery settings are shared across profiles.

```sh
reela config profiles list
reela config profiles create <profile-name>
reela --profile <profile-name> login
reela config profiles use <profile-name>
reela config profiles show
```

Use `--profile <name>` or `REELA_PROFILE=<name>` for one-off commands, or `reela config profiles use <name>` to set the active profile.

### Environment authentication

Set `REELA_ACCESS_TOKEN` to authenticate non-interactively:

```sh
REELA_ACCESS_TOKEN=<jwt> reela whoami
```

The CLI sends its value unchanged as `Authorization: Bearer <token>`. This token takes priority over the effective profile's `credentials.json`, is never written to disk, and is not removed by `reela logout`. Unset the environment variable to stop using it.

## License

Proprietary. See [reela.com](https://reela.com) for terms of service.
