---
name: reela-tiers
description: Quality tier comparison for video creation
version: 0.1.0
---

# Reela Quality Tiers

Tiers control video quality, rendering speed, and credit cost. Higher tiers produce better visuals but cost more credits and take longer.

## Available Tiers

| Tier | Quality | Speed | Credits/min | Best For |
|------|---------|-------|-------------|----------|
| photo | Basic stills | Fast | 1 | Quick previews |
| nano | Low | Fast | 2 | Drafts, testing |
| lite | Medium-Low | Fast | 3 | Quick iterations |
| plus | Medium | Moderate | 5 | Standard content |
| pro | High | Moderate | 8 | Production content |
| max | Very High | Slow | 12 | Premium content |
| promax | Premium | Slow | 16 | High-end production |
| ultra | Ultra | Very Slow | 24 | Cinema quality |
| ultramax | Maximum | Very Slow | 32 | Maximum quality |
| cinematic | Cinematic | Slowest | 40 | Film production |
| master | Master | Slowest | 48 | Studio production |
| studio | Studio | Slowest | 64 | Professional studios |

## Recommendations

- **Testing/Drafts**: Use `nano` or `lite` (save credits during iteration)
- **Standard production**: Use `pro` (best quality/cost balance)
- **Premium output**: Use `max` or `promax`
- **Always use `--dry-run` first** to check credit cost before committing
