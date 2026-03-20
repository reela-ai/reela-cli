---
name: reela-create-params
description: Detailed parameter reference for reela create command
version: 0.1.0
---

# Reela Create Parameters

## Required Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `<prompt>` or `--prompt-file` | string | — | Video content description (one required) |
| `--visual` | string[] | — | Visual type(s), can specify multiple |

## Optional Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `--duration` | number | 30 | Video length in seconds |
| `--layout` | enum | landscape | landscape / portrait / square |
| `--tier` | enum | pro | Quality tier (see reela-tiers skill) |
| `--avatar` | string[] | [] | Avatar ID(s) for digital human |
| `--collection` | string | — | Add to a collection |
| `--download` | string | — | One-time download dir override |
| `--dry-run` | bool | false | Validate without creating |
| `--idempotency-key` | string | — | Prevent duplicate creation |

## Visual Types

| Value | Description |
|-------|-------------|
| `ai-video` | AI-generated video from text |
| `avatar` | Trained digital human presenter |
| `original-clip` | User-uploaded video clip (visual only) |
| `original-sync` | User-uploaded video (preserve audio-visual sync) |
| `image-video` | Animate image to video |
| `web-animation` | Code-driven animation (Remotion) |

## Usage Examples

Basic: `reela create "A 30s intro video about AI" --visual ai-video`
With avatar: `reela create "Product demo" --visual avatar --avatar av_01 --duration 60`
Dry run: `reela create "Test" --visual ai-video --dry-run`
Portrait: `reela create "Short form content" --visual ai-video --layout portrait`
