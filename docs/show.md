---
title: Reela Shows
description: Download Shows, replace subject images, and manage episode files.
version: 1.23.0
---

# Reela Shows

## List and download Shows

```bash
reela show list
reela show list --limit 20 --offset 0
reela show download <show-id>
reela show download <show-id> --out-dir ./my-show
reela show download <show-id> --subjects
reela show download <show-id> --out-dir ./my-show --force
```

A downloaded Show contains `show.yaml`, `subjects.yaml`, and episode Markdown files in `episodes/`.

Add `--subjects` to also download each subject's current original image to `subjects/<subject-id>.<ext>`. Subjects without an image are skipped with a warning. Without this flag, no images are downloaded. To refresh an existing workspace, use `--subjects --force`; this also refreshes the Show and episode files. If an image's format changes, the old file with a different extension is retained.

## Replace a subject image

Find the subject ID in `subjects.yaml` or an episode's `subjects` field:

```bash
reela show subject replace-image <subject-id> --file ./new-image.png
```

Use a static JPEG, PNG, or WebP image, up to 20 MiB and 40 megapixels. Replacement preserves image history and does not regenerate existing videos. Episode Markdown continues to reference only subject IDs.

## Episode file format

```markdown
---
format: reela.episode/v1
id: null
show_id: 4zP8example
number: 2
title: Awakening
duration: 120
subjects:
  - 6AbCexample
---

Full script...
```

Keep every frontmatter field. Use `id: null` for a new episode. To clear optional content, use `title: ''`, `duration: null`, `subjects: []`, or an empty Markdown body.

## Check and change episodes

```bash
reela show episode validate episodes/002-awakening.md
reela show episode add episodes/002-awakening.md
reela show episode update episodes/002-awakening.md
reela show episode delete episodes/002-awakening.md
reela show episode delete episodes/002-awakening.md --yes
```

Validate a file before adding or updating it. After adding an episode, keep the updated local file. Deleting an episode does not delete its local file.
