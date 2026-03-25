# Agent Workflow Guide

How to prepare inputs and assemble `reela create` commands.

## Input Preparation

Reela accepts structured inputs (prompt, files, flags). Your job is to bridge the gap between raw user content and these structured inputs.

**Two sources of input:**

| Source | What it gives you |
|---|---|
| **User's current request** | Files, prompt, instructions for this video |
| **Your pre-processing** | Scraped content, extracted text/images, transcribed lyrics |

### Raw Content → Reela Inputs

| Raw Input | Agent Pre-Processing | Reela Input |
|---|---|---|
| **URL / Website** | Scrape text + download images | Images → `--file reference-image:`, text → prompt |
| **PDF / Document** | Extract text + extract images | Images → `--file reference-image:`, text → prompt |
| **PPT** | Extract text + slides as images | Slides → `--file reference-image:`, text → prompt |
| **News article** | Fetch article + download photos | Photos → `--file reference-image:`, text → prompt |
| **Song (mp3)** | Embed lyrics in metadata (see below) | `--file background-music:` (MV creation) |
| **Video (footage)** | Download / receive | `--file video-source:` or `--file video-audio:` per video |
| **Image** | Download if remote | `--file reference-image:` or `--file original-image:` |

**All files must be local.** Reela accepts local file paths, not URLs. Download/extract all media first, verify files are complete, then pass local paths to `--file`.

## Video Production Model

A video is assembled from visual components + audio. You select which visual components to use via `--visual` (required), and optionally attach files via `--file`.

### Visual Components

| Component | `--visual` value | Activated by |
|---|---|---|
| AI Generation | `ai-video` | Default for AI-generated content |
| User Video Clip | `original-clip` | `--file video-source:` (audio muted) |
| Synced Video | `original-sync` | `--file video-audio:` (audio preserved) |
| Avatar | `avatar` | `--avatar <id>` |
| Image Animation | `image-video` | `--file original-image:` |
| Web Animation | `web-animation` | Code-driven charts/data (Remotion) |

Multiple visual types can be combined: `--visual avatar,original-clip,ai-video`

### Audio

Audio is AI-generated voiceover by default. The only user-provided audio option is music for MV creation:

| Scenario | How |
|---|---|
| AI voiceover (default) | No action needed |
| Avatar voice | Automatic when `--avatar` is used |
| MV (user's song) | `--file background-music:./song.mp3` |

### Common Combinations

| Scenario | Command pattern |
|---|---|
| AI explainer | `--visual ai-video` |
| Avatar talking-head | `--visual avatar,ai-video --avatar <id>` |
| Clip remix + AI filler | `--visual original-clip,ai-video --file video-source:...` |
| Avatar + clips | `--visual avatar,original-clip,ai-video --avatar <id> --file video-source:...` |
| MV from user's song | `--visual ai-video --file background-music:...` |
| Image reference + AI | `--visual ai-video --file reference-image:...` |
| Synced video edit | `--visual original-sync --file video-audio:...` |
| Pure clips (no AI) | `--visual original-clip --file video-source:...` |

## Decision Flow

### Step 1: Gather Minimum Information

Every `reela create` needs: **prompt + `--visual` + duration + layout**.

| Info | How to get it | Default |
|---|---|---|
| What is the video about? | User's message | — (must have) |
| Visual type(s) | Determine from files + intent | — (must specify) |
| How long? | User says "30s" / "1 min" | `30` |
| Orientation? | User says vertical/horizontal, or infer from context | `landscape` |

### Step 2: Classify Files

When the user provides files, decide the `--file` role:

**Video files — does the original audio matter?**

| Signal | Role | Result |
|---|---|---|
| Visual only (product demo, B-roll footage) | `video-source` | Audio muted, AI voiceover |
| Audio-visual sync matters (interview, concert, speech) | `video-audio` | Original audio preserved |
| Ambiguous? | Ask the user | |

**Image files — what role does this image play?**

| Signal | Role | Result |
|---|---|---|
| Style reference (default) | `reference-image` | Visual consistency anchor |
| "Animate this image" | `original-image` | Image-to-video (lower quality, use sparingly) |

Default to `reference-image` — better quality, more useful.

**Audio files — MV creation only**

| Signal | Role |
|---|---|
| User provides a song / music track | `background-music` |

Audio file attachments are exclusively for MV creation. See "MV: Lyrics Requirement" below.

### Step 3: Assemble Command

Use defaults for anything the user didn't specify. Only ask when truly ambiguous.

```bash
reela create "<prompt>" \
  --visual <types> \
  [--file ROLE:PATH ...] \
  [--avatar <id>] \
  [--duration <seconds>] \
  [--layout landscape|portrait|square] \
  [--tier <tier>] \
  [--dry-run]
```

Use `--dry-run` to validate before submitting.

## MV: Lyrics Requirement

Music tracks (`background-music`) **must include lyrics embedded in the audio file's metadata** (e.g., ID3 USLT/SYLT tags for mp3). Reela reads lyrics from the audio file for lip-sync and visual alignment.

**Workflow:**
1. Obtain lyrics (see fallback below)
2. Write lyrics into the mp3 file's ID3 metadata tags
3. Upload the enriched mp3 as `background-music`

**How to obtain lyrics — three-level fallback:**

| Priority | Method | When |
|---|---|---|
| 1 | Listen to the audio → transcribe lyrics | Default — works for any song |
| 2 | Recall lyrics from knowledge | Known/popular songs |
| 3 | Ask user for lyrics, explaining they're needed for lip-sync | Both above fail |

## Examples

### Pure AI generation

```bash
reela create "Quantum computing explained for beginners" --visual ai-video --duration 60
```

### Image reference + AI

```bash
reela create "Product introduction video" --visual ai-video \
  --file reference-image:./brand.jpg \
  --duration 30
```

### Avatar + product demo clips

```bash
reela create "New product walkthrough" \
  --visual avatar,original-clip,ai-video \
  --avatar av_01 \
  --file video-source:./demo1.mp4 \
  --file video-source:./demo2.mp4 \
  --duration 45 --layout portrait
```

### MV from user's song

Agent pre-processing: transcribe lyrics → embed in mp3 metadata.

```bash
reela create "City Pop MV" --visual ai-video \
  --file background-music:./song_with_lyrics.mp3 \
  --duration 180 --layout portrait
```

### Website URL → video

Agent pre-processing: scrape text + download images from URL.

```bash
reela create "Company promo video" --visual ai-video \
  --file reference-image:./hero.jpg \
  --file reference-image:./product.png \
  --duration 30
```

### PDF → video

Agent pre-processing: extract text + images from PDF.

```bash
reela create "Q3 earnings report highlights" --visual ai-video \
  --file reference-image:./chart.png \
  --file reference-image:./product.jpg \
  --duration 120
```
