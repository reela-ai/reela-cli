# Reela CLI

Create AI-powered videos from the terminal with [Reela](https://reela.com).

## Install

### With an AI agent

Tell your agent:

> Follow <https://github.com/reela-ai/reela-cli/blob/main/INSTALL.md> to install Reela CLI, then run `reela -h`.

### Linux / macOS

```sh
curl -fsSL https://raw.githubusercontent.com/reela-ai/reela-cli/main/install.sh | bash
```

Verify the installation:

```sh
reela --help
```

## Quick start

```sh
reela login
reela create "A 30-second product demo for my app" --visual ai-video --dry-run
reela tiers list
reela tasks list
```

Run a command with `-h` to see its current options:

```sh
reela create -h
reela tasks -h
```

Run `reela -h` to find the installed command guides.

## Common commands

| Command | Use |
| --- | --- |
| `login` | Sign in |
| `logout` | Sign out |
| `whoami` | Show the signed-in account |
| `create` | Create a video |
| `status` | Check account and delivery status |
| `tasks` | List, inspect, and download videos |
| `tiers` | List quality and cost options |
| `avatar` | List available avatars |
| `show` | Work with Shows and episodes |
| `config` | Change CLI settings and profiles |
| `daemon` | Manage automatic delivery |
| `subscribe` | Choose delivery methods |
| `update` | Update Reela CLI |

## Profiles

Use profiles when you need more than one Reela account or set of local preferences:

```sh
reela config profiles create work
reela --profile work login
reela config profiles use work
reela config profiles list
```

Use a profile for one command without changing the active profile:

```sh
reela --profile work whoami
```

For unattended use, provide an access token for the command:

```sh
REELA_ACCESS_TOKEN=<token> reela whoami
```

## License

Proprietary. See [reela.com](https://reela.com) for terms of service.
