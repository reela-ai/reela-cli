# File Attachments — Role Decision Guide

> For syntax and available roles, run `reela create -h`.

## How to Choose a Role

### Video Files — Does the Original Audio Matter?

| Signal | Role | Result |
|--------|------|--------|
| Visual only, original audio doesn't matter (product demo, B-roll) | `video-source` | Audio muted, AI voiceover |
| Audio-visual sync matters (interview, concert, speech) | `video-audio` | Original audio preserved |
| Ambiguous? | Ask the user | |

### Image Files — What Role Does This Image Play?

| Signal | Role | Result |
|--------|------|--------|
| Style / composition reference (default) | `reference-image` | Visual consistency anchor |
| "Animate this image" | `original-image` | Image-to-video (lower quality, use sparingly) |

Default to `reference-image` — better quality, more useful. Only use `original-image` if the user explicitly wants to animate a specific image.

### Audio Files — MV Creation Only

Audio attachments are exclusively for MV creation (`background-music` role).

## MV: Lyrics Requirement

Music tracks (`background-music`) **must include lyrics embedded in the audio file's metadata** (ID3 USLT/SYLT tags for mp3). Reela reads lyrics from the audio file for lip-sync and visual alignment.

**Workflow:**
1. Obtain lyrics (three-level fallback: transcribe audio → recall from knowledge → ask user)
2. Write lyrics into the mp3 file's ID3 metadata tags
3. Attach the enriched mp3 as `background-music`

Without embedded lyrics, Reela cannot do lip-sync or align visuals to song content.
