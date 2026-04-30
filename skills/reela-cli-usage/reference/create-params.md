# Reela Create — Supplementary Notes

> For the full parameter list, run `reela create -h`.

## Visual Combinations

Multiple visual types are specified by repeating `--visual`:

```bash
--visual avatar --visual original-clip --visual ai-video
```

Do **not** comma-join visual values; `--visual avatar,ai-video` is invalid.

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
| Image as style ref | `--visual ai-video` | `--file reference-image:...` |

## Music Video / MV Mode

`--music-video` enables AI-generated music video / MV mode. It does **not** mean "add background music" to a normal video. Default: off.

- Use `--music-video` only when the user explicitly asks for an MV, music video, AI-generated song/music track, or a song-led video.
- Do **not** add `--music-video` just because a normal promo, explainer, product, or social video would benefit from background music.
- For ordinary background music, leave `--music-video` unset and describe the desired mood/style in the prompt if needed.
- If the user supplies a music file for MV creation, use `--file background-music:...` instead, and do **not** combine it with `--music-video`.

```bash
reela create "Create an AI-generated city-pop MV about a rainy neon street" --visual ai-video --music-video --duration 60
```

## Tier Selection

`reela create` requires a pipeline tier. Prefer using a tier label from `reela tiers list`:

```bash
reela tiers list
reela create "Product launch video" --tier "<tier label>" --visual ai-video --duration 30 --dry-run
```

If `--tier` is omitted, the CLI uses the default tier from the local tier cache. Run `reela config sync` if the cache is missing or stale.

## Session & Collection Grouping

Videos created with the same `--session` name share a collection.

- Default session: `{hostname}-{username}-{YYYY-MM-DD}` (daily rotation)
