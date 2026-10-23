# How to customize this site

Personal content is stored in `_data`. In normal use, you do not need to edit HTML.

- `profile.yml`: name, biography, quotation and academic links.
- `education.yml`: education and academic experience.
- `research.yml`: research introduction and topics.
- `affiliations.yml`: research groups and affiliations.
- `publications.yml`: papers, authors, status and links.
- `simulations.yml`: simulation text, repository and poster.
- `events.yml`: events, presentations and photo identifiers.
- `contact.yml`: public email address.
- `theme.yml`: light/dark colors and automatic switching hours.

Bilingual fields end in `_en` and `_pt`, or use `en` and `pt`. Always update both versions. Preserve YAML indentation and keep text containing punctuation inside quotation marks.

## Personal photos

Add images to `assets/fotos/`. The site automatically discovers and rotates them.

## Simulation videos

Add MP4 or WEBM files to `assets/simulacoes/`. They are discovered automatically after commit and push.

## Event photos

Add images to `assets/eventos/`. Begin each filename with the `photo_key` from `_data/events.yml`, followed by `-1`, `-2`, and so on. Example: `clapem-2026-1.jpg`.

## Colors and dark mode

Edit `_data/theme.yml`. Set `mode` to `auto`, `light` or `dark`. Auto mode uses each visitor's local time and the configured `light_start` and `dark_start` hours.

## Templates

Files in `_includes` control layout. Each template begins with a comment pointing to the corresponding `_data` file. Edit templates only when changing structure rather than content.
