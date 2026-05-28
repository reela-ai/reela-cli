# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Added

- First-class CLI profile management: `reela config profiles list/show/create/delete/use`.
- Profile-specific account state and local settings under `~/.reela/profiles/<name>/`.
- Legacy compatibility for users upgrading from earlier CLI versions.
- Local CLI docs installed to `~/.reela/docs` and discoverable with `reela docs --json`.

### Changed

- Delivery settings remain global while account-specific CLI state follows the effective profile.

## [0.1.0]

### Added

- Initial release
- `login` / `logout` / `whoami` — authentication via OAuth Device Flow
- `create` — create videos with prompt, avatar, and collection options
- `status` — check status of recent tasks
- `tasks` — list all tasks with filtering
- `config` — manage CLI profiles and settings
- Desktop notifications for completed/failed tasks
- Multi-profile support
