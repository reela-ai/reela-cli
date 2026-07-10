---
title: Reela Shows
description: Download Shows as local workspaces and validate, add, update, or delete episode Markdown files.
version: 1.20.6
---

# Reela Shows

Use Show workspaces when you want to edit episode metadata and scripts as local files.

## List and download Shows

```bash
reela show list
reela show list --limit 20 --offset 0
reela show download <show-id>
reela show download <show-id> --out-dir ./my-show
```

Downloading creates `show.yaml`, `subjects.yaml`, and one Markdown file per episode under `episodes/`. An existing non-empty directory is rejected unless `--force` is supplied.

A forced refresh merges episode files by the `id` in frontmatter. Matching remote episodes overwrite their existing local path, new remote episodes get canonical filenames, and stale local episodes are retained with a warning. Unrelated and malformed local files are never deleted.

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

Every frontmatter key shown above is required. Filenames are cosmetic; `number` and IDs always come from frontmatter. Explicit clearing is supported with `title: ''`, `duration: null`, `subjects: []`, and an empty Markdown body.

## Validate and mutate episodes

```bash
reela show episode validate episodes/002-awakening-a8K3mP.md
reela show episode add episodes/002-awakening-a8K3mP.md
reela show episode update episodes/002-awakening-a8K3mP.md
reela show episode delete episodes/002-awakening-a8K3mP.md
reela show episode delete episodes/002-awakening-a8K3mP.md --yes
```

Validation is local-only. New episode files must use `id: null`; after a successful add, the CLI atomically writes the returned remote ID into that file. Update fully replaces all editable fields. Delete removes only the remote episode and retains the local file as a backup.
