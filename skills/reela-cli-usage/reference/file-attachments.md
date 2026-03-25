# File Attachments

Attach your own media (images, videos, music) as source material for video creation using the `--file` flag.

## Syntax

`reela create "prompt" --file ROLE:PATH [--file ROLE:PATH ...]`

## Roles

| Role              | Description                               | Formats        |
| ----------------- | ----------------------------------------- | -------------- |
| `video-source`    | Video clip (visual only, audio muted)     | mp4, mov       |
| `video-audio`     | Video (preserve audio-visual sync)        | mp4, mov       |
| `reference-image` | Reference image (style/composition guide) | jpg, png, webp |
| `original-image`  | Source image (for image-to-video)         | jpg, png, webp |
| `background-music` | Music track for MV creation               | mp3, wav       |

## How to Choose a Role

### Video Files

| Signal | Role | Result |
|--------|------|--------|
| Visual only, original audio doesn't matter (product demo, B-roll) | `video-source` | Audio muted, AI voiceover |
| Audio-visual sync matters (interview, concert, speech) | `video-audio` | Original audio preserved |
| Ambiguous? | Ask the user | |

### Image Files

| Signal | Role | Result |
|--------|------|--------|
| Style / composition reference (default) | `reference-image` | Visual consistency anchor |
| "Animate this image" | `original-image` | Image-to-video (lower quality, use sparingly) |

Default to `reference-image` — better quality, more useful. Only use `original-image` if the user explicitly wants to animate a specific image.

### Audio Files — MV Creation Only

| Signal | Role | Result |
|--------|------|--------|
| User provides a song for MV creation | `background-music` | Reela generates visuals to match the music |

Audio attachments are exclusively for MV creation.

## MV: Lyrics Requirement

Music tracks (`background-music`) **must include lyrics embedded in the audio file's metadata** (ID3 USLT/SYLT tags for mp3). Reela reads lyrics from the audio file for lip-sync and visual alignment.

**Workflow:**
1. Obtain lyrics (three-level fallback: transcribe audio → recall from knowledge → ask user)
2. Write lyrics into the mp3 file's ID3 metadata tags
3. Attach the enriched mp3 as `background-music`

Without embedded lyrics, Reela cannot do lip-sync or align visuals to song content.

## Examples

Image to video: `reela create "Animate this photo" --visual image-video --file original-image:./photo.jpg`
With reference: `reela create "Video in this style" --visual ai-video --file reference-image:./style.png`
MV from song: `reela create "City Pop MV" --visual ai-video --file background-music:./song.mp3 --layout portrait --duration 180`
Multiple files: `reela create "Edit this" --visual original-clip --file video-source:./clip1.mp4 --file video-source:./clip2.mp4`
