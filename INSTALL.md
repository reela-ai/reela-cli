# Install Reela CLI

## 1. Install

```sh
curl -fsSL https://raw.githubusercontent.com/reela-ai/reela-cli/main/install.sh | bash
```

## 2. Verify

```sh
reela --help
```

If the command is not found, add Reela CLI to your current shell path and try again:

```sh
export PATH="$HOME/.local/bin:$PATH"
reela --help
```

## 3. Sign in

```sh
reela login
```

Follow the on-screen instructions, then check the signed-in account:

```sh
reela whoami
```

## 4. Learn the commands

```sh
reela -h
reela create -h
```

`reela -h` also lists the installed guides for create, delivery, configuration, tasks, Shows, and custom scripts.

## Update

```sh
reela update
```

You can also run the install command again to install the latest version.
