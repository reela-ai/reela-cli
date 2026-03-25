# Reela Create Parameters

## Required Parameters

| Parameter                     | Type     | Default | Description                              |
| ----------------------------- | -------- | ------- | ---------------------------------------- |
| `<prompt>` or `--prompt-file` | string   | —       | Video content description (one required) |
| `--visual`                    | string[] | —       | Visual type(s), can specify multiple     |

## Optional Parameters

| Parameter           | Type     | Default   | Description                          |
| ------------------- | -------- | --------- | ------------------------------------ |
| `--duration`        | number   | 30        | Video length in seconds              |
| `--layout`          | enum     | landscape | landscape / portrait / square        |
| `--tier`            | enum     | pro       | Quality tier (see reela-tiers skill) |
| `--avatar`          | string[] | []        | Avatar ID(s) for digital human       |
| `--file`            | string[] | []        | Attach file with role (ROLE:PATH)    |
| `--download`        | string   | —         | One-time download dir override       |
| `--dry-run`         | bool     | false     | Validate without creating            |
| `--session`         | string   | auto      | Session name for collection grouping (default: {hostname}-{username}-{YYYY-MM-DD}) |
| `--idempotency-key` | string   | —         | Prevent duplicate creation           |

## Visual Types

| Value           | Description                                      |
| --------------- | ------------------------------------------------ |
| `ai-video`      | AI-generated video from text                     |
| `avatar`        | Trained digital human presenter                  |
| `original-clip` | User-uploaded video clip (visual only)           |
| `original-sync` | User-uploaded video (preserve audio-visual sync) |
| `image-video`   | Animate image to video                           |
| `web-animation` | Code-driven animation (Remotion)                 |

## File Attachment Roles

The `--file` flag attaches media files with a specific role. Format: `--file ROLE:PATH`

| Role              | Description                               | Formats        |
| ----------------- | ----------------------------------------- | -------------- |
| `video-source`    | Video clip (visual only, audio muted)     | mp4, mov, webm |
| `video-audio`     | Video (preserve audio-visual sync)        | mp4, mov       |
| `reference-image` | Reference image (style/composition guide) | jpg, png, webp |
| `original-image`  | Source image (for image-to-video)         | jpg, png, webp |
| `background-music` | Background music track                   | mp3, wav, aac  |

## Session & Collection Grouping

Videos created with the same `--session` name share a collection. The session-to-collection mapping is stored locally at `~/.config/reela/sessions.json`.

- Default session: `{hostname}-{username}-{YYYY-MM-DD}` (daily rotation)
- Override: `REELA_COLLECTION_ID` env var bypasses session logic entirely

## Usage Examples

Basic: `reela create "A 30s intro video about AI" --visual ai-video`
With avatar: `reela create "Product demo" --visual avatar --avatar av_01 --duration 60`
Dry run: `reela create "Test" --visual ai-video --dry-run`
Portrait: `reela create "Short form content" --visual ai-video --layout portrait`
With file: `reela create "Animate this photo" --visual image-video --file original-image:./photo.jpg`
With session: `reela create "Product demo" --visual ai-video --session my-campaign`
With music: `reela create "Product demo" --visual avatar --file background-music:./bgm.mp3`
