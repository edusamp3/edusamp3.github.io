# Academic website — Eduardo Sampaio Pimenta

A bilingual, responsive academic website built with plain HTML, CSS and JavaScript. It can be hosted for free on GitHub Pages and does not require a build step.

## Preview locally

Open `index.html` directly in a browser, or run a small local server from this folder:

```bash
python3 -m http.server 8000
```

Then visit `http://localhost:8000`.

## Add the portrait later

1. Save the photo as `assets/profile.jpg`.
2. In `index.html`, replace the content inside `.portrait-frame` with:

```html
<img src="assets/profile.jpg" alt="Eduardo Sampaio Pimenta" />
```

3. Add this rule to `styles.css`:

```css
.portrait-frame img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
```

## Publish with GitHub Pages

1. Create a new repository on GitHub.
2. Upload all files in this folder to the repository root.
3. Go to **Settings → Pages**.
4. Under **Build and deployment**, select **Deploy from a branch**.
5. Choose the `main` branch and `/ (root)`, then save.

## Content to review

- Confirm exact dates and formal status of the postdoctoral period in Augsburg.
- Confirm whether `eduardo.sampaio@ufba.br` should remain the public contact email.
- Add or revise publications after reviewing the complete Lattes record.
- Add an ORCID or GitHub link, if applicable.
- Add a downloadable PDF CV when available.

## Sources used for the first version

- Lattes CV supplied by Eduardo.
- UFBA graduate program public thesis records.
- University of Augsburg probability group page and seminar announcement.
- arXiv record `2408.06830`.
- Public Google Scholar profile.

