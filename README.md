# Academic website — Eduardo Sampaio Pimenta

A bilingual, responsive, multipage academic website built with plain HTML, CSS and JavaScript. It can be hosted for free on GitHub Pages and does not require a build step.

The home page presents a lightweight looping SNOB simulation and alternates automatically between two photographs in `assets/`.

## Pages

- `index.html` — home
- `sobre.html` — about
- `pesquisa.html` — research
- `trabalhos.html` — five highlights and complete academic production
- `simulacoes.html` — simulation projects and source-code links
- `publicacoes.html` — compatibility redirect to `trabalhos.html`
- `curriculo.html` — academic CV
- `contato.html` — contact

## Preview locally

Open `index.html` directly in a browser, or run a small local server from this folder:

```bash
python3 -m http.server 8000
```

Then visit `http://localhost:8000`.

## Publish with GitHub Pages

1. Create a new repository on GitHub.
2. Upload all files in this folder to the repository root.
3. Go to **Settings → Pages**.
4. Under **Build and deployment**, select **Deploy from a branch**.
5. Choose the `main` branch and `/ (root)`, then save.

## Content to review

- Confirm exact dates and formal status of the postdoctoral period in Augsburg.
- Confirm whether `eduardo.sampaio@ufba.br` should remain the public contact email.
- Update the production list whenever the Lattes CV changes.
- Add an ORCID or GitHub link, if applicable.
- Add a downloadable PDF CV when available.

## Sources used for the first version

- Lattes CV supplied by Eduardo.
- UFBA graduate program public thesis records.
- University of Augsburg probability group page and seminar announcement.
- arXiv record `2408.06830`.
- arXiv record `2507.10528`.
- Bernoulli Journal forthcoming-papers page.
- Public Google Scholar profile.
