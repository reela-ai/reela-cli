# Reela Create — Flag Reference

> For the live parameter list with current defaults, always run `reela create -h`.

## Visual Types — Director Roles

Each visual type plays a creative role. Picking the right combination is choosing which roles tell the story.

- **`ai-video`** — your generative camera. Free imagination, no anchor. Use for stories Reela invents from scratch or visualizes from a reference image.
- **`avatar`** — your on-screen narrator. Pins identity and voice. Use when the user wants "someone speaking on camera." Always pair with `--avatar <id>` and typically with `--visual ai-video` for surrounding shots.
- **`original-clip`** — the user's footage as B-roll. Audio is muted; AI voiceover or AI-generated cuts fill the soundtrack. Use for product demos, screen recordings, silent footage.
- **`original-sync`** — the user's footage with original audio preserved. Use when audio-visual sync matters: interviews, performances, talking-heads from the user's own camera.
- **`image-video`** — animates a single user-provided image. Lower quality than `ai-video` + `reference-image`. Use only when the user explicitly says "animate this image."

You assemble the cast by repeating `--visual` for each role needed.

## Visual Combinations

Multiple visual types must be specified by repeating `--visual`:

```bash
--visual avatar --visual original-clip --visual ai-video
```

Comma-joined values are invalid (`--visual avatar,ai-video` will not work).

| Scenario | Visual flags | Additional flags |
|---|---|---|
| AI explainer | `--visual ai-video` | — |
| Avatar talking-head | `--visual avatar --visual ai-video` | `--avatar <id>` |
| Clip remix + AI filler | `--visual original-clip --visual ai-video` | `--file video-source:...` |
| Avatar + clips | `--visual avatar --visual original-clip --visual ai-video` | `--avatar <id>` + `--file video-source:...` |
| MV from user's song | `--visual ai-video` | `--file background-music:...` |
| AI-generated MV / music video | `--visual ai-video` | `--music-video` |
| Synced video edit | `--visual original-sync` | `--file video-audio:...` |
| Pure clips (no AI) | `--visual original-clip` | `--file video-source:...` |
| Image animation | `--visual image-video` | `--file original-image:...` |
| Image as style reference | `--visual ai-video` | `--file reference-image:...` |

## Music Video / MV Mode

`--music-video` is the **AI-generated MV** switch. Reela writes a song, composes the music, and produces the music video around it. Default: off.

When to use:
- User explicitly asks for an MV, music video, AI-generated song, lyric video, or song-led video.

When NOT to use:
- A normal promo / explainer / product / social video that "would benefit from background music." For that, leave `--music-video` off and mention the desired music mood in the prompt.
- The user provided their own song file. Use `--file background-music:...` instead. Do **not** combine `--file background-music:` with `--music-video`.

```bash
# AI-generated MV (Reela writes the song)
reela create "AI-generated city-pop MV about a rainy neon street" \
  --visual ai-video \
  --music-video --duration 60 --dry-run

# User-provided song MV (NOT --music-video)
reela create "City pop MV with neon visuals" \
  --visual ai-video \
  --file background-music:./song_with_lyrics.mp3 \
  --duration 180 --layout portrait --dry-run
```

## Session & Collection Grouping

Videos created with the same `--session` name share a collection.

- Default session: `{hostname}-{username}-{YYYY-MM-DD}` (daily rotation)
- Use `--session` explicitly when the user wants several videos grouped (e.g., a multi-shot series).

## Duration and Layout

- `--duration <seconds>` — explicit user statement ("30 seconds", "1 分钟") drives the value. Default `30` if unspecified.
- `--layout landscape|portrait|square` — default is **portrait** (most short-form social video lives there). Switch to **landscape** only on an explicit signal:
  - User says "横屏" / "landscape" / "16:9" / "desktop" / "web embed".
  - User names a landscape-dominant platform: YouTube long-form, LinkedIn, training video, web hero, conference recording.
  - Explicit portrait signals confirm portrait: TikTok / 抖音 / Instagram Reels / YouTube Shorts / 小红书 / 竖屏 / "for phone".
  - When the platform / format is genuinely ambiguous (no signal either way), include layout in your one clarifying question rather than defaulting.
