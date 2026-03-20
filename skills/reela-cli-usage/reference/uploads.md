---
name: reela-uploads
description: Guide for uploading media assets with reela create
version: 0.1.0
---

> **Warning: Planned Feature — Not yet available.** The `--upload` flag is not yet implemented in the CLI. This document describes the intended behavior for a future release.

# Reela Upload Guide

Upload your own media (images, videos, music) as source material for video creation.

## Upload Syntax

`reela create "prompt" --upload <path>:<as> [--upload <path>:<as> ...]`

## Upload Types (the `<as>` value)

| Value | Internal | Description | Formats |
|-------|----------|-------------|---------|
| `clip` | OVS | Video clip (visual only, audio muted) | mp4, mov, webm |
| `sync` | OVA | Video (preserve audio-visual sync) | mp4, mov |
| `ref` | ORI | Reference image (style/composition guide) | jpg, png, webp |
| `source` | OI | Source image (for image-to-video) | jpg, png, webp |
| `music` | OA_MUSIC | Background music track | mp3, wav, aac |

## Examples

Image to video: `reela create "Animate this photo" --visual image-video --upload ./photo.jpg:source`
With reference: `reela create "Video in this style" --visual ai-video --upload ./style.png:ref`
With music: `reela create "Product demo" --visual avatar --upload ./bgm.mp3:music`
Multiple uploads: `reela create "Edit this" --visual original-clip --upload ./clip1.mp4:clip --upload ./clip2.mp4:clip`
