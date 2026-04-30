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
| **Song (mp3)** | Embed lyrics in metadata (see file-attachments.md) | `--file background-music:` (MV creation) |
| **Video (footage)** | Download / receive | `--file video-source:` or `--file video-audio:` per video |
| **Image** | Download if remote | `--file reference-image:` or `--file original-image:` |

**All files must be local.** Reela accepts local file paths, not URLs. Download/extract all media first, verify files are complete, then pass local paths to `--file`.

## Decision Flow

### Step 1: Gather Minimum Information

Every `reela create` needs: **prompt + `--visual` + tier + duration + layout**.

| Info | How to get it | Default |
|---|---|---|
| What is the video about? | User's message | — (must have) |
| Visual type(s) | Determine from files + intent | — (must specify) |
| Pipeline tier | Use a label from `reela tiers list`; if omitted, CLI uses cached default tier | Cached default tier |
| How long? | User says "30s" / "1 min" | `30` |
| Orientation? | User says vertical/horizontal, or infer from context | `landscape` |

If the available tiers or default tier are unknown, run `reela config sync` or `reela tiers list` before assembling the create command.

### Step 2: Classify Files

When the user provides files, decide the `--file` role. See [file-attachments.md](./file-attachments.md) for the decision guide.

### Step 3: Assemble Command

Use defaults for anything the user didn't specify. Only ask when truly ambiguous. See [create-params.md](./create-params.md) for visual combinations and tier selection.

**Music-video guardrail:** Only add `--music-video` when the user explicitly requests an MV, music video, AI-generated song/music track, or song-led video. Do not use it for ordinary background music; instead, leave the flag unset and mention the desired music mood/style in the prompt.

### Step 4: Dry-Run → Confirm → Submit

**Never submit a task directly.** Always follow this sequence:

1. **Dry-run first:** Run the assembled command with `--dry-run` appended.
2. **Show result:** Present the dry-run output to the user (parameters, estimated cost, validation errors).
3. **Wait for confirmation:** Ask the user to confirm before proceeding.
4. **Submit:** Only after the user confirms, re-run the same command without `--dry-run`.

## End-to-End Examples

### Website URL → video

Agent pre-processing: scrape text + download images from URL.

```bash
reela create "Company promo video" --tier "<tier label>" --visual ai-video \
  --file reference-image:./hero.jpg \
  --file reference-image:./product.png \
  --duration 30 --dry-run
```

### PDF → video

Agent pre-processing: extract text + images from PDF.

```bash
reela create "Q3 earnings report highlights" --tier "<tier label>" --visual ai-video \
  --file reference-image:./chart.png \
  --file reference-image:./product.jpg \
  --duration 120 --dry-run
```

### MV from user's song

Agent pre-processing: transcribe lyrics → embed in mp3 metadata.

```bash
reela create "City Pop MV" --tier "<tier label>" --visual ai-video \
  --file background-music:./song_with_lyrics.mp3 \
  --duration 180 --layout portrait --dry-run
```

### AI-generated MV / music video

Use `--music-video` only because the request is explicitly for an AI-generated MV/music video.

```bash
reela create "Create an AI-generated synthwave music video about a night drive" --tier "<tier label>" --visual ai-video \
  --music-video --duration 60 --layout portrait --dry-run
```
