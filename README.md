# Academic website — Eduardo Sampaio Pimenta

A deliberately simple, bilingual, single-page academic website. It uses plain HTML, CSS and JavaScript and is ready for GitHub Pages.

## Files

- `index.html` — all site content and the automatic media manifest
- `_includes/research.html` — research section
- `_includes/publications.html` — publications and preprints
- `_includes/simulations.html` — simulation section and video player
- `_includes/contact.html` — contact section
- `styles.css` — visual design
- `script.js` — language switch, photo rotation and random video playlist
- `assets/fotos/` — photographs shown in rotation
- `assets/simulacoes/` — simulation videos shown in random order
- `cv/cv.tex` — editable LaTeX source for the CV
- `cv/cv.pdf` — PDF linked from the website

## Add a simulation

1. Compress the video for the web (MP4/H.264 is the safest format).
2. Give it a short filename without spaces, for example `05-passeio-aleatorio-2d.mp4`.
3. Put it in `assets/simulacoes/`.
4. Commit and push with GitHub Desktop.

GitHub Pages finds every MP4 or WebM in that folder automatically. The site shuffles the playlist whenever the page is opened and avoids repeating the same video between two rounds. Do not add another copy of the same video outside this folder.

## Edit a section

The website is still a single page, but its main sections live in separate files under `_includes/`. Edit only the corresponding file. The lines such as `{% include research.html %}` in `index.html` assemble everything automatically when GitHub Pages publishes the site.

## Add a photograph

Put a JPG, JPEG, PNG, WebP or AVIF file in `assets/fotos/`, then commit and push. Photographs are also discovered automatically and shown in a changing order.

## Update the CV

Edit `cv/cv.tex`, then generate the PDF from the `cv` folder:

```bash
pdflatex cv.tex
pdflatex cv.tex
```

Commit both `cv.tex` and `cv.pdf`. The website always links to `cv/cv.pdf`, so the address never changes.

## Preview locally

The quickest preview is to open `index.html`; it uses the three bundled videos and two bundled photos as a fallback. To test automatic folder discovery exactly as GitHub Pages does, run Jekyll locally.

## Publish

Copy these files into the root of `edusamp3.github.io`, commit and push. GitHub Pages processes `index.html` and builds the media lists automatically.

The old files `sobre.html`, `pesquisa.html`, `trabalhos.html`, `simulacoes.html`, `curriculo.html`, `contato.html` and `publicacoes.html` are no longer used. They may be deleted after the new `index.html` is working online.

## Profile links still to confirm

- ORCID: add only after confirming Eduardo's identifier.
- Public email: currently `eduardo.sampaio@ufba.br`.
