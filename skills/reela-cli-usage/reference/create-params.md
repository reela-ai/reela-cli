# Reela Create — Supplementary Notes

> For the full parameter list, run `reela create -h`.

## Visual Combinations

Multiple visual types can be combined with commas: `--visual avatar,original-clip,ai-video`

| Scenario | `--visual` value | Additional flags |
|---|---|---|
| AI explainer | `ai-video` | — |
| Avatar talking-head | `avatar,ai-video` | `--avatar <id>` |
| Clip remix + AI filler | `original-clip,ai-video` | `--file video-source:...` |
| Avatar + clips | `avatar,original-clip,ai-video` | `--avatar <id>` + `--file video-source:...` |
| MV from user's song | `ai-video` | `--file background-music:...` |
| Synced video edit | `original-sync` | `--file video-audio:...` |
| Pure clips (no AI) | `original-clip` | `--file video-source:...` |
| Image animation | `image-video` | `--file original-image:...` |
| Image as style ref | `ai-video` | `--file reference-image:...` |

## Session & Collection Grouping

Videos created with the same `--session` name share a collection. The session-to-collection mapping is stored locally at `~/.config/reela/sessions.json`.

- Default session: `{hostname}-{username}-{YYYY-MM-DD}` (daily rotation)
