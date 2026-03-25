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
| `--download`        | string   | —         | ⚠️ Post-MVP, accepted but not yet wired |
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
| `video-source`    | Video clip (visual only, audio muted)     | mp4, mov       |
| `video-audio`     | Video (preserve audio-visual sync)        | mp4, mov       |
| `reference-image` | Reference image (style/composition guide) | jpg, png, webp |
| `original-image`  | Source image (for image-to-video)         | jpg, png, webp |
| `background-music` | Music track for MV creation               | mp3, wav       |

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

## Common Scenarios

AI explainer:
`reela create "Quantum computing explained" --visual ai-video --duration 60`

Avatar + product demo clips:
`reela create "New product walkthrough" --visual avatar,original-clip,ai-video --avatar av_01 --file video-source:./demo.mp4 --duration 45 --layout portrait`

MV from user's song:
`reela create "City Pop MV" --visual ai-video --file background-music:./song.mp3 --duration 180 --layout portrait`

Image as style reference:
`reela create "Product introduction" --visual ai-video --file reference-image:./brand.jpg --duration 30`

Image animation:
`reela create "Animate this photo" --visual image-video --file original-image:./photo.jpg`

Synced video edit:
`reela create "Interview highlights" --visual original-sync --file video-audio:./interview.mp4 --duration 60`

Pure clips compilation (no AI visuals):
`reela create "Footage compilation" --visual original-clip --file video-source:./clip1.mp4 --file video-source:./clip2.mp4 --duration 30`
