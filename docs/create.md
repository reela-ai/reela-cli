# Reela Create — Flag Reference

> For the live parameter list with current defaults, always run `reela create -h`.

## Visual Types

`--visual` selects the visual source/type used by `reela create`.

Supported values:

- **`ai-video`** — generate AI video visuals.
- **`avatar`** — include an avatar track. Requires `--avatar <id>`.
- **`original-clip`** — use uploaded video clips with original audio muted.
- **`original-sync`** — use uploaded video clips with original audio preserved/synchronized.
- **`image-video`** — animate a single uploaded image.

Repeat `--visual` to combine multiple visual types.

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

`--music-video` enables AI-generated MV mode. In this mode, Reela writes/generates the song and produces the video around it. Default: off.

For a user-provided song file, pass it as `--file background-music:...` instead of using `--music-video`. Do not combine `--file background-music:...` with `--music-video`.

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

- `--duration <seconds>` — output duration in seconds. Default: `30`.
- `--layout landscape|portrait|square` — output aspect/layout. Default: `portrait`.

## Quality and Cost Tiers

`--tier <tier>` selects the quality/cost tier for the task.

To see the current available tiers and user-facing descriptions, run:

```bash
reela tiers list
```

If `--tier` is omitted, the CLI uses the default tier when available.
