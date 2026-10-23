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
- `languages.yml`: available languages and default language.
- `navigation.yml`: menu links and their translations.
- `ui.yml`: short interface labels used throughout the site.
- `theme.yml`: light/dark colors and automatic switching hours.

Translated fields use language codes such as `_en`, `_pt`, `_es`, or nested `en`, `pt`, `es` values. Add a translation for every language listed in `languages.yml`. Missing translations fall back to the default language. Preserve YAML indentation and keep text containing punctuation inside quotation marks.

## Adding another language

Copy one language block in `_data/languages.yml`, choose its code and then add that code to translated fields in the other `_data` files. Menu buttons are generated automatically; no JavaScript editing is required.

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

## Layout and typography

Edit `_data/design.yml` to change text alignment, fonts, font sizes, page width, content width, profile photo dimensions, spacing, media proportions, borders, rounded corners, gallery columns and header behavior. Keep CSS units such as `px` and `rem` in size values. The default `text_align` is `left`; use `justify` only if desired.
