# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [Unreleased]

### Added

- First-class CLI profile management: `reela config profiles list/show/create/delete/use`.
- Profile-specific credentials, tier cache, feature-flag cache, session mappings, and daemon PID/log files under `~/.reela/profiles/<name>/`.
- Legacy compatibility that lazily copies existing `~/.reela/credentials.json`, `tiers.json`, and `feature-flags.json` into the default profile without deleting legacy files.

### Changed

- Delivery settings remain global while API/auth/cache/session/daemon state follows the effective profile.

## [0.1.0]

### Added

- Initial release
- `login` / `logout` / `whoami` — authentication via OAuth Device Flow
- `create` — create videos with prompt, avatar, and collection options
- `status` — check status of recent tasks
- `tasks` — list all tasks with filtering
- `config` — manage CLI profiles and settings
- Desktop notifications for completed/failed tasks
- Multi-profile support with TOML configuration
