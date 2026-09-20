# Reela CLI

Create AI-powered videos from the terminal with [Reela](https://reela.com).

## Install

Linux / macOS:

```sh
curl -fsSL https://raw.githubusercontent.com/reela-ai/reela-cli/main/install.sh | bash
```

For guided setup or installation with an AI agent, follow [INSTALL.md](./INSTALL.md).

## Quick start

```sh
reela login
reela create "A product demo for my app" --visual ai-video --dry-run
reela tasks list
reela tasks download <task-id>
```

Review the estimated cost, then remove `--dry-run` to submit the video.

## Help

```sh
reela -h
reela create -h
reela show episode -h
```

Built-in help provides command options, examples, and input formats. Add `-h` at any command level.

Run `reela update` to get the latest version.

## License

Proprietary. See [reela.com](https://reela.com) for terms of service.
