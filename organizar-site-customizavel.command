#!/bin/bash
set -euo pipefail

show_message() {
  /usr/bin/osascript -e "display dialog \"$1\" buttons {\"OK\"} default button \"OK\"" >/dev/null 2>&1 || true
}

if [[ $# -ge 1 && -d "$1" ]]; then
  SITE_DIR="$1"
else
  SITE_DIR="$(/usr/bin/osascript <<'APPLESCRIPT'
try
  POSIX path of (choose folder with prompt "Escolha a pasta do site acadêmico")
on error
  return ""
end try
APPLESCRIPT
)"
fi

if [[ -z "${SITE_DIR:-}" ]]; then exit 0; fi
SITE_DIR="$(cd "$SITE_DIR" && pwd -P)"

for file in index.html styles.css script.js; do
  if [[ ! -f "$SITE_DIR/$file" ]]; then
    show_message "Não encontrei $file. Nenhum arquivo foi alterado."
    exit 1
  fi
done

if [[ -f "$SITE_DIR/_data/profile.yml" ]]; then
  show_message "O site já está organizado pelo sistema de arquivos editáveis. Nenhum arquivo foi alterado."
  exit 0
fi

TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="$(dirname "$SITE_DIR")/$(basename "$SITE_DIR")-backup-customizacao-$TIMESTAMP-$$"
mkdir -p "$BACKUP_DIR/_includes" "$BACKUP_DIR/_data"
cp "$SITE_DIR/index.html" "$BACKUP_DIR/index.html"
cp "$SITE_DIR/styles.css" "$BACKUP_DIR/styles.css"
cp "$SITE_DIR/script.js" "$BACKUP_DIR/script.js"
for file in research.html research-group.html publications.html simulations.html contact.html profile.html education.html; do
  [[ -f "$SITE_DIR/_includes/$file" ]] && cp "$SITE_DIR/_includes/$file" "$BACKUP_DIR/_includes/$file"
done

mkdir -p "$SITE_DIR/_data" "$SITE_DIR/_includes"

cat > "$SITE_DIR/_data/profile.yml" <<'YAML'
# HOW TO USE
# Edit your name, role, biography, quotation and academic links here.
# Keep both English (_en) and Portuguese (_pt) versions up to date.
# To add a biography paragraph or link, copy one complete list item and edit it.
# Keep the indentation exactly as shown. Text containing ':' should stay quoted.

name: "Eduardo Sampaio Pimenta"
role_en: "Mathematician working in probability theory"
role_pt: "Matemático que trabalha com teoria da probabilidade"
role_es: "Matemático que trabaja en teoría de la probabilidad"
photo_caption_en: "Mathematician · Probability"
photo_caption_pt: "Matemático · Probabilidade"
photo_caption_es: "Matemático · Probabilidad"

bio:
  - en: "I am a Brazilian mathematician interested in stochastic processes, scaling limits and random walks. I completed my PhD in Mathematics at the Federal University of Bahia (UFBA) in 2025 and most recently carried out postdoctoral research at the University of Augsburg. I have been a postdoctoral researcher at the Federal University of Minas Gerais (UFMG) since October 2026."
    pt: "Sou um matemático brasileiro interessado em processos estocásticos, limites de escala e passeios aleatórios. Concluí o doutorado em Matemática na Universidade Federal da Bahia (UFBA) em 2025 e, mais recentemente, realizei pesquisa de pós-doutorado na Universidade de Augsburg. Sou pesquisador de pós-doutorado na Universidade Federal de Minas Gerais (UFMG) desde outubro de 2026."
    es: "Soy un matemático brasileño interesado en procesos estocásticos, límites de escala y paseos aleatorios. Completé mi doctorado en Matemáticas en la Universidad Federal de Bahía (UFBA) en 2025 y posteriormente realicé una investigación posdoctoral en la Universidad de Augsburgo. Soy investigador posdoctoral en la Universidad Federal de Minas Gerais (UFMG) desde octubre de 2026."
  - en: "My work studies how discrete random systems converge to continuous processes and how boundary mechanisms affect their limiting behavior."
    pt: "Meu trabalho estuda como sistemas aleatórios discretos convergem para processos contínuos e como mecanismos de fronteira afetam seu comportamento limite."
    es: "Mi trabajo estudia cómo los sistemas aleatorios discretos convergen a procesos continuos y cómo los mecanismos de frontera afectan su comportamiento límite."

quote:
  text: "Ever tried. Ever failed. No matter. Try again. Fail again. Fail better."
  author: "Samuel Beckett"
  source: "Worstward Ho"

links:
  - label: "Lattes"
    url: "https://lattes.cnpq.br/6512284414514021"
  - label: "ORCID"
    url: "https://orcid.org/0009-0004-1060-2280"
  - label: "Google Scholar"
    url: "https://scholar.google.com/citations?hl=en&user=SJJP-ngAAAAJ"
  - label: "CV (PDF)"
    url: "cv/cv.pdf"
  - label: "Email"
    url: "mailto:sampaieduardo@gmail.com"
YAML

cat > "$SITE_DIR/_data/education.yml" <<'YAML'
# HOW TO USE
# Each block below is one degree or academic position.
# Copy a complete block to add another item. Newest items should come first.
# Keep both English (_en) and Portuguese (_pt) versions up to date.
# Keep the indentation exactly as shown.

- period: "2026–present"
  title_en: "Postdoctoral researcher"
  title_pt: "Pesquisador de pós-doutorado"
  title_es: "Investigador posdoctoral"
  institution_en: "Federal University of Minas Gerais (UFMG)"
  institution_pt: "Universidade Federal de Minas Gerais (UFMG)"
  institution_es: "Universidad Federal de Minas Gerais (UFMG)"

- period: "2025–2026"
  title_en: "Postdoctoral research"
  title_pt: "Pesquisa de pós-doutorado"
  title_es: "Investigación posdoctoral"
  institution_en: "University of Augsburg"
  institution_pt: "Universidade de Augsburg"
  institution_es: "Universidad de Augsburgo"

- period: "2021–2025"
  title_en: "PhD in Mathematics"
  title_pt: "Doutorado em Matemática"
  title_es: "Doctorado en Matemáticas"
  institution_en: "Federal University of Bahia (UFBA)"
  institution_pt: "Universidade Federal da Bahia (UFBA)"
  institution_es: "Universidad Federal de Bahía (UFBA)"

- period: "2019–2021"
  title_en: "MSc in Mathematics"
  title_pt: "Mestrado em Matemática"
  title_es: "Máster en Matemáticas"
  institution_en: "Federal University of Bahia (UFBA)"
  institution_pt: "Universidade Federal da Bahia (UFBA)"
  institution_es: "Universidad Federal de Bahía (UFBA)"

- period: "2010–2017"
  title_en: "BSc in Mathematics"
  title_pt: "Bacharelado em Matemática"
  title_es: "Grado en Matemáticas"
  institution_en: "Federal University of Minas Gerais (UFMG)"
  institution_pt: "Universidade Federal de Minas Gerais (UFMG)"
  institution_es: "Universidad Federal de Minas Gerais (UFMG)"
YAML

cat > "$SITE_DIR/_data/research.yml" <<'YAML'
# HOW TO USE
# Edit the introductory paragraph and research topics in this file.
# Each topic needs an English (en) and Portuguese (pt) version.
# Copy one complete topic block to add another topic.
# Keep the indentation exactly as shown.

intro_en: "My main interests are in probability theory and stochastic processes, especially the following topics:"
intro_pt: "Meus principais interesses estão em teoria da probabilidade e processos estocásticos, especialmente nos seguintes temas:"
intro_es: "Mis principales intereses se encuentran en la teoría de la probabilidad y los procesos estocásticos, especialmente en los siguientes temas:"

topics:
  - en: "scaling limits and invariance principles;"
    pt: "limites de escala e princípios de invariância;"
    es: "límites de escala y principios de invariancia;"
  - en: "random walks with boundary mechanisms;"
    pt: "passeios aleatórios com mecanismos de fronteira;"
    es: "paseos aleatorios con mecanismos de frontera;"
  - en: "Feller processes and generator methods;"
    pt: "processos de Feller e métodos baseados em geradores;"
    es: "procesos de Feller y métodos basados en generadores;"
  - en: "dynamic percolation and evolving random environments;"
    pt: "percolação dinâmica e ambientes aleatórios em evolução;"
    es: "percolación dinámica y entornos aleatorios en evolución;"
  - en: "limit theorems."
    pt: "teoremas de limite."
    es: "teoremas límite."
YAML

cat > "$SITE_DIR/_data/affiliations.yml" <<'YAML'
# HOW TO USE
# Each block represents one research group or academic affiliation.
# Copy a complete block to add another affiliation.
# Provide its name, URL and descriptions in both languages.
# Keep the indentation exactly as shown.

- name: "PROFE"
  url: "http://dgp.cnpq.br/dgp/espelholinha/790496658105085770869"
  description_en: "Research Group in Probability and Statistical Physics. Member of the Interacting Particle Systems research line."
  description_pt: "Grupo de Pesquisa em Probabilidade e Física Estatística. Integrante da linha de pesquisa Sistemas de Partículas Interagentes."
  description_es: "Grupo de Investigación en Probabilidad y Física Estadística. Miembro de la línea de investigación Sistemas de Partículas Interactuantes."

- name: "Probability Theory and Applications"
  url: "https://www.uni-augsburg.de/en/fakultaet/mntf/math/prof/sto/"
  description_en: "University of Augsburg. Visiting scientist, 2025–2026."
  description_pt: "Universidade de Augsburg. Pesquisador visitante, 2025–2026."
  description_es: "Universidad de Augsburgo. Investigador visitante, 2025–2026."
YAML

cat > "$SITE_DIR/_data/publications.yml" <<'YAML'
# HOW TO USE
# Each top-level block is one publication or preprint.
# Copy a complete publication block to add a new work.
# An author URL is optional. Use `self: true` to highlight the site owner's name.
# Keep note_en and note_pt synchronized and preserve the indentation.

- title: "A Functional Central Limit Theorem for the General Brownian Motion on the Half-Line"
  authors:
    - name: "D. Erhard"
      url: "http://lattes.cnpq.br/4167887647318550"
    - name: "T. Franco"
      url: "https://tertu.xyz/"
    - name: "M. Jara"
      url: "http://lattes.cnpq.br/7496571533341165"
    - name: "E. Pimenta"
      self: true
  note_en: "Accepted, forthcoming in Bernoulli."
  note_pt: "Aceito para publicação na revista Bernoulli."
  note_es: "Aceptado para publicación en la revista Bernoulli."
  link_label: "Journal page"
  link_url: "https://www.bernoullisociety.org/index.php/publications/bernoulli-journal/bernoulli-journal-papers"

- title: "Scaling Limit of Boundary Random Walks: A Martingale Problem Approach"
  authors:
    - name: "J. C. Arroyave"
    - name: "E. Barros"
      url: "https://sites.google.com/view/eldon-barros"
    - name: "E. Pimenta"
      self: true
  note_en: "Preprint, submitted to ALEA, 2025."
  note_pt: "Preprint, submetido à ALEA, 2025."
  note_es: "Preprint, enviado a ALEA, 2025."
  link_label: "arXiv"
  link_url: "https://arxiv.org/abs/2507.10528"
YAML

cat > "$SITE_DIR/_data/simulations.yml" <<'YAML'
# HOW TO USE
# Edit the section description, repository link and video poster here.
# Simulation videos themselves go in assets/simulacoes/ as MP4 or WEBM files.
# Videos are discovered automatically after commit and push.
# Keep both English (_en) and Portuguese (_pt) labels up to date.

description_en: "A rotating selection of numerical experiments related to my research. The order changes whenever the page is opened."
description_pt: "Uma seleção rotativa de experimentos numéricos relacionados à minha pesquisa. A ordem muda sempre que a página é aberta."
description_es: "Una selección rotativa de experimentos numéricos relacionados con mi investigación. El orden cambia cada vez que se abre la página."
repository_label_en: "Simulation code on GitHub"
repository_label_pt: "Códigos das simulações no GitHub"
repository_label_es: "Código de las simulaciones en GitHub"
repository_url: "https://github.com/edusamp3/Simulations"
poster: "assets/snob-3d-poster.jpg"
YAML

cat > "$SITE_DIR/_data/contact.yml" <<'YAML'
# HOW TO USE
# Replace the address below with the public contact email for the site.
# The mailto link is generated automatically.

email: "sampaieduardo@gmail.com"
YAML

cat > "$SITE_DIR/_data/languages.yml" <<'YAML'
# HOW TO USE
# default is the language used on a visitor's first access.
# To add another language, copy one complete block and choose a short code.
# Then add that code to every translated field in the other _data files.
# Missing translations automatically fall back to the default language.

default: "en"
available:
  - code: "en"
    label: "EN"
    html_lang: "en"
  - code: "pt"
    label: "PT"
    html_lang: "pt-BR"
  - code: "es"
    label: "ES"
    html_lang: "es"
YAML

cat > "$SITE_DIR/_data/navigation.yml" <<'YAML'
# HOW TO USE
# Each block is one navigation link. Edit href to change its destination.
# labels must contain one entry for every language in languages.yml.
# Copy a complete block to add another menu item.

- href: "index.html#about"
  labels:
    en: "About"
    pt: "Sobre"
    es: "Sobre mí"
- href: "index.html#research"
  labels:
    en: "Research"
    pt: "Pesquisa"
    es: "Investigación"
- href: "index.html#education"
  labels:
    en: "Education"
    pt: "Formação"
    es: "Formación"
- href: "index.html#research-affiliations"
  labels:
    en: "Affiliations"
    pt: "Afiliações"
    es: "Afiliaciones"
- href: "index.html#publications"
  labels:
    en: "Publications"
    pt: "Publicações"
    es: "Publicaciones"
- href: "events.html#events"
  labels:
    en: "Events"
    pt: "Eventos"
    es: "Eventos"
- href: "events.html#simulations"
  labels:
    en: "Simulations"
    pt: "Simulações"
    es: "Simulaciones"
YAML

cat > "$SITE_DIR/_data/ui.yml" <<'YAML'
# HOW TO USE
# These are short interface labels used by templates and JavaScript.
# Add a translation for every language listed in languages.yml.

sections:
  research: { en: "Research", pt: "Pesquisa", es: "Investigación" }
  education: { en: "Education and experience", pt: "Formação e experiência", es: "Formación y experiencia" }
  affiliations: { en: "Research affiliations", pt: "Afiliações de pesquisa", es: "Afiliaciones de investigación" }
  publications: { en: "Publications and preprints", pt: "Publicações e preprints", es: "Publicaciones y preprints" }
  simulations: { en: "Simulations", pt: "Simulações", es: "Simulaciones" }
  contact: { en: "Contact", pt: "Contato", es: "Contacto" }
  events: { en: "Events", pt: "Eventos", es: "Eventos" }
  upcoming: { en: "Upcoming", pt: "Próximos", es: "Próximos" }
  past_events: { en: "Past events", pt: "Eventos anteriores", es: "Eventos anteriores" }
labels:
  skip: { en: "Skip to content", pt: "Ir para o conteúdo", es: "Ir al contenido" }
  records: { en: "Complete and current records:", pt: "Registros completos e atualizados:", es: "Registros completos y actualizados:" }
  pause: { en: "Pause", pt: "Pausar", es: "Pausar" }
  play: { en: "Play", pt: "Reproduzir", es: "Reproducir" }
  next: { en: "Next", pt: "Próxima", es: "Siguiente" }
  photos: { en: "Photos", pt: "Fotos", es: "Fotos" }
  event_page: { en: "Event page", pt: "Página do evento", es: "Página del evento" }
  program: { en: "Program", pt: "Programação", es: "Programa" }
YAML

cat > "$SITE_DIR/_data/theme.yml" <<'YAML'
# HOW TO USE
# Set mode to "auto", "light" or "dark".
# In auto mode, the visitor's local time selects the theme.
# light_start and dark_start use the 24-hour clock.
# Change the hexadecimal colors below to customize both palettes.
# Keep color values inside quotation marks.

# Available modes: auto, light or dark.
mode: "auto"

# Auto mode uses the visitor's local time.
light_start: 7
dark_start: 19

light:
  paper: "#faf8f2"
  ink: "#252525"
  muted: "#686868"
  line: "#dedbd2"
  link: "#315f73"
  link_hover: "#173b4b"
  soft: "#f0eee7"
  header: "rgba(255, 255, 255, 0.96)"

dark:
  paper: "#17191a"
  ink: "#ece9e1"
  muted: "#aaa79f"
  line: "#343738"
  link: "#86b8c7"
  link_hover: "#b8dce6"
  soft: "#222526"
  header: "rgba(23, 25, 26, 0.96)"
YAML

cat > "$SITE_DIR/_includes/profile.html" <<'HTML'
<!-- TEMPLATE: Edit personal content in _data/profile.yml, not in this file. -->
<section class="profile" id="top" aria-labelledby="page-title">
  <aside class="profile-sidebar">
    <figure class="portrait" role="img" aria-label="{{ site.data.profile.name }}">
      <img class="portrait-layer is-active" src="assets/fotos/01-eduardo-pimenta-retrato.jpg" alt="" aria-hidden="true" decoding="async" />
      <img class="portrait-layer" alt="" aria-hidden="true" decoding="async" />
    </figure>
    <p class="photo-caption" data-en="{{ site.data.profile.photo_caption_en | escape }}" data-pt="{{ site.data.profile.photo_caption_pt | escape }}">{{ site.data.profile.photo_caption_en }}</p>
  </aside>
  <div class="profile-copy" id="about">
    <h1 id="page-title">{{ site.data.profile.name }}</h1>
    <p class="role" data-en="{{ site.data.profile.role_en | escape }}" data-pt="{{ site.data.profile.role_pt | escape }}">{{ site.data.profile.role_en }}</p>
    {% for paragraph in site.data.profile.bio %}
      <p data-en="{{ paragraph.en | escape }}" data-pt="{{ paragraph.pt | escape }}">{{ paragraph.en }}</p>
    {% endfor %}
    {% if site.data.profile.quote.text != "" %}
      <blockquote class="personal-quote">
        <p>“{{ site.data.profile.quote.text }}”</p>
        <cite>— {{ site.data.profile.quote.author }}{% if site.data.profile.quote.source != "" %}, <em>{{ site.data.profile.quote.source }}</em>{% endif %}</cite>
      </blockquote>
    {% endif %}
    <ul class="profile-links" aria-label="Academic profiles">
      {% for link in site.data.profile.links %}<li><a href="{{ link.url }}"{% unless link.url contains 'mailto:' or link.url contains 'cv/' %} target="_blank" rel="noreferrer"{% endunless %}>{{ link.label }}</a></li>{% endfor %}
    </ul>
  </div>
</section>
HTML

cat > "$SITE_DIR/_includes/research.html" <<'HTML'
<!-- TEMPLATE: Edit research content in _data/research.yml, not in this file. -->
<section class="content-section" id="research" aria-labelledby="research-title">
  <h2 id="research-title" data-en="Research" data-pt="Pesquisa">Research</h2>
  <div class="section-body">
    <p data-en="{{ site.data.research.intro_en | escape }}" data-pt="{{ site.data.research.intro_pt | escape }}">{{ site.data.research.intro_en }}</p>
    <ul class="plain-list">
      {% for topic in site.data.research.topics %}<li data-en="{{ topic.en | escape }}" data-pt="{{ topic.pt | escape }}">{{ topic.en }}</li>{% endfor %}
    </ul>
  </div>
</section>
HTML

cat > "$SITE_DIR/_includes/education.html" <<'HTML'
<!-- TEMPLATE: Edit education and experience in _data/education.yml. -->
<section class="content-section" id="education" aria-labelledby="education-title">
  <h2 id="education-title" data-en="Education and experience" data-pt="Formação e experiência">Education and experience</h2>
  <div class="section-body"><ul class="plain-list education-list">
    {% for item in site.data.education %}
      <li><strong data-en="{{ item.title_en | escape }}" data-pt="{{ item.title_pt | escape }}">{{ item.title_en }}</strong>, <span data-en="{{ item.institution_en | escape }}" data-pt="{{ item.institution_pt | escape }}">{{ item.institution_en }}</span> <span class="education-period">({{ item.period }})</span>.</li>
    {% endfor %}
  </ul></div>
</section>
HTML

cat > "$SITE_DIR/_includes/research-group.html" <<'HTML'
<!-- TEMPLATE: Edit groups and affiliations in _data/affiliations.yml. -->
<section class="content-section" id="research-affiliations" aria-labelledby="research-affiliations-title">
  <h2 id="research-affiliations-title" data-en="Research affiliations" data-pt="Afiliações de pesquisa">Research affiliations</h2>
  <div class="section-body"><ul class="plain-list">
    {% for group in site.data.affiliations %}
      <li><a href="{{ group.url }}" target="_blank" rel="noopener noreferrer"><strong>{{ group.name }}</strong></a><span data-en=" — {{ group.description_en | escape }}" data-pt=" — {{ group.description_pt | escape }}"> — {{ group.description_en }}</span></li>
    {% endfor %}
  </ul></div>
</section>
HTML

cat > "$SITE_DIR/_includes/publications.html" <<'HTML'
<!-- TEMPLATE: Edit publications in _data/publications.yml, not in this file. -->
<section class="content-section" id="publications" aria-labelledby="publications-title">
  <h2 id="publications-title" data-en="Publications and preprints" data-pt="Publicações e preprints">Publications and preprints</h2>
  <div class="section-body"><ol class="publication-list">
    {% for publication in site.data.publications %}
      <li>
        <p class="publication-title">{{ publication.title }}</p>
        <p>{% for author in publication.authors %}{% if author.self %}<strong>{{ author.name }}</strong>{% elsif author.url %}<a href="{{ author.url }}" target="_blank" rel="noopener noreferrer">{{ author.name }}</a>{% else %}{{ author.name }}{% endif %}{% unless forloop.last %}{% if forloop.rindex == 2 %} and {% else %}, {% endif %}{% endunless %}{% endfor %}.</p>
        <p class="publication-note"><span data-en="{{ publication.note_en | escape }}" data-pt="{{ publication.note_pt | escape }}">{{ publication.note_en }}</span> <a href="{{ publication.link_url }}" target="_blank" rel="noopener noreferrer">{{ publication.link_label }}</a></p>
      </li>
    {% endfor %}
  </ol><p class="more-link"><span data-en="Complete and current records:" data-pt="Registros completos e atualizados:">Complete and current records:</span> <a href="https://lattes.cnpq.br/6512284414514021" target="_blank" rel="noreferrer">Lattes</a> <span aria-hidden="true">·</span> <a href="https://scholar.google.com/citations?hl=en&amp;user=SJJP-ngAAAAJ" target="_blank" rel="noreferrer">Google Scholar</a></p></div>
</section>
HTML

cat > "$SITE_DIR/_includes/simulations.html" <<'HTML'
<!-- TEMPLATE: Edit section text in _data/simulations.yml; add videos to assets/simulacoes/. -->
<section class="content-section" id="simulations" aria-labelledby="simulations-title">
  <h2 id="simulations-title" data-en="Simulations" data-pt="Simulações">Simulations</h2>
  <div class="section-body simulation-copy">
    <p data-en="{{ site.data.simulations.description_en | escape }}" data-pt="{{ site.data.simulations.description_pt | escape }}">{{ site.data.simulations.description_en }}</p>
    <p><a href="{{ site.data.simulations.repository_url }}" target="_blank" rel="noreferrer" data-en="{{ site.data.simulations.repository_label_en | escape }}" data-pt="{{ site.data.simulations.repository_label_pt | escape }}">{{ site.data.simulations.repository_label_en }}</a></p>
  </div>
  <figure class="simulation-player"><video id="simulation-video" muted autoplay playsinline preload="metadata" poster="{{ site.data.simulations.poster }}" aria-label="Stochastic process simulation"></video><figcaption class="simulation-meta"><span id="simulation-name">Loading simulation…</span><span class="simulation-controls"><button id="simulation-toggle" type="button" data-state="playing" data-en="Pause" data-pt="Pausar">Pause</button><span aria-hidden="true"> · </span><button id="simulation-next" type="button" data-en="Next" data-pt="Próxima">Next</button><span id="simulation-count" aria-live="polite"></span></span></figcaption></figure>
</section>
HTML

cat > "$SITE_DIR/_includes/contact.html" <<'HTML'
<!-- TEMPLATE: Edit the public email address in _data/contact.yml. -->
<section class="content-section contact-section" id="contact" aria-labelledby="contact-title"><h2 id="contact-title" data-en="Contact" data-pt="Contato">Contact</h2><div class="section-body"><p><a href="mailto:{{ site.data.contact.email }}">{{ site.data.contact.email }}</a></p></div></section>
HTML

cat > "$SITE_DIR/_includes/events.html" <<'HTML'
<!-- TEMPLATE: Edit events and translations in _data/events.yml. -->
<section class="content-section" id="events" aria-labelledby="events-title">
  <h2 id="events-title" data-i18n{% for language in site.data.languages.available %} data-{{ language.code }}="{{ site.data.ui.sections.events[language.code] | default: site.data.ui.sections.events[site.data.languages.default] | escape }}"{% endfor %}>{{ site.data.ui.sections.events[site.data.languages.default] }}</h2>
  <div class="section-body events-body">
    {% assign upcoming_events = site.data.events | where: "status", "upcoming" %}
    {% if upcoming_events.size > 0 %}<h3 class="events-group-title" data-i18n{% for language in site.data.languages.available %} data-{{ language.code }}="{{ site.data.ui.sections.upcoming[language.code] | default: site.data.ui.sections.upcoming[site.data.languages.default] | escape }}"{% endfor %}>{{ site.data.ui.sections.upcoming[site.data.languages.default] }}</h3><ol class="event-list">{% for event in upcoming_events %}{% include event-entry.html event=event %}{% endfor %}</ol>{% endif %}
    {% assign past_events = site.data.events | where: "status", "past" %}
    {% if past_events.size > 0 %}<h3 class="events-group-title" data-i18n{% for language in site.data.languages.available %} data-{{ language.code }}="{{ site.data.ui.sections.past_events[language.code] | default: site.data.ui.sections.past_events[site.data.languages.default] | escape }}"{% endfor %}>{{ site.data.ui.sections.past_events[site.data.languages.default] }}</h3><ol class="event-list">{% for event in past_events %}{% include event-entry.html event=event %}{% endfor %}</ol>{% endif %}
  </div>
</section>
HTML

cat > "$SITE_DIR/_includes/event-entry.html" <<'HTML'
<!-- TEMPLATE: Event data and translations come from _data/events.yml. -->
<li class="event-entry" data-event-photo-key="{{ include.event.photo_key }}">
  <div class="event-year">{{ include.event.year }}</div>
  <div class="event-information">
    <p class="event-name">{{ include.event.name }}</p>
    <p class="event-location"><span data-i18n{% for language in site.data.languages.available %}{% capture key %}location_{{ language.code }}{% endcapture %} data-{{ language.code }}="{{ include.event[key] | default: include.event.location_en | escape }}"{% endfor %}>{{ include.event.location_en }}</span></p>
    <p class="event-role"><span data-i18n{% for language in site.data.languages.available %}{% capture key %}role_{{ language.code }}{% endcapture %} data-{{ language.code }}="{{ include.event[key] | default: include.event.role_en | escape }}"{% endfor %}>{{ include.event.role_en }}</span>{% if include.event.title != "" %}: <em>{{ include.event.title }}</em>{% endif %}.</p>
    {% if include.event.event_url != "" or include.event.program_url != "" %}<p class="event-links">{% if include.event.event_url != "" %}<a href="{{ include.event.event_url }}" target="_blank" rel="noopener noreferrer" data-i18n{% for language in site.data.languages.available %} data-{{ language.code }}="{{ site.data.ui.labels.event_page[language.code] | default: site.data.ui.labels.event_page[site.data.languages.default] | escape }}"{% endfor %}>{{ site.data.ui.labels.event_page[site.data.languages.default] }}</a>{% endif %}{% if include.event.program_url != "" %}<a href="{{ include.event.program_url }}" target="_blank" rel="noopener noreferrer" data-i18n{% for language in site.data.languages.available %} data-{{ language.code }}="{{ site.data.ui.labels.program[language.code] | default: site.data.ui.labels.program[site.data.languages.default] | escape }}"{% endfor %}>{{ site.data.ui.labels.program[site.data.languages.default] }}</a>{% endif %}</p>{% endif %}
  </div>
</li>
HTML

cat > "$SITE_DIR/_includes/navigation.html" <<'HTML'
<!-- GENERATED MENU: Edit links and translations in _data/navigation.yml. -->
<nav class="site-nav" aria-label="Primary navigation">
  {% for item in site.data.navigation %}
    <a href="{{ item.href }}" data-i18n{% for language in site.data.languages.available %} data-{{ language.code }}="{{ item.labels[language.code] | default: item.labels[site.data.languages.default] | escape }}"{% endfor %}>{{ item.labels[site.data.languages.default] }}</a>
  {% endfor %}
</nav>
HTML

cat > "$SITE_DIR/_includes/language-switch.html" <<'HTML'
<!-- GENERATED SWITCH: Add or remove languages in _data/languages.yml. -->
<div class="language-switch" aria-label="Language">
  {% for language in site.data.languages.available %}
    <button type="button" data-language="{{ language.code }}" aria-pressed="{% if language.code == site.data.languages.default %}true{% else %}false{% endif %}">{{ language.label }}</button>{% unless forloop.last %}<span aria-hidden="true">/</span>{% endunless %}
  {% endfor %}
</div>
HTML

cat > "$SITE_DIR/_includes/profile.html" <<'HTML'
<!-- TEMPLATE: Edit personal content and translations in _data/profile.yml. -->
<section class="profile" id="top" aria-labelledby="page-title">
  <aside class="profile-sidebar">
    <figure class="portrait" role="img" aria-label="{{ site.data.profile.name }}">
      <img class="portrait-layer is-active" src="assets/fotos/01-eduardo-pimenta-retrato.jpg" alt="" aria-hidden="true" decoding="async" />
      <img class="portrait-layer" alt="" aria-hidden="true" decoding="async" />
    </figure>
    <p class="photo-caption" data-i18n{% for language in site.data.languages.available %}{% capture key %}photo_caption_{{ language.code }}{% endcapture %} data-{{ language.code }}="{{ site.data.profile[key] | default: site.data.profile.photo_caption_en | escape }}"{% endfor %}>{{ site.data.profile.photo_caption_en }}</p>
  </aside>
  <div class="profile-copy" id="about">
    <h1 id="page-title">{{ site.data.profile.name }}</h1>
    <p class="role" data-i18n{% for language in site.data.languages.available %}{% capture key %}role_{{ language.code }}{% endcapture %} data-{{ language.code }}="{{ site.data.profile[key] | default: site.data.profile.role_en | escape }}"{% endfor %}>{{ site.data.profile.role_en }}</p>
    {% for paragraph in site.data.profile.bio %}<p data-i18n{% for language in site.data.languages.available %} data-{{ language.code }}="{{ paragraph[language.code] | default: paragraph[site.data.languages.default] | escape }}"{% endfor %}>{{ paragraph[site.data.languages.default] }}</p>{% endfor %}
    {% if site.data.profile.quote.text != "" %}<blockquote class="personal-quote"><p>“{{ site.data.profile.quote.text }}”</p><cite>— {{ site.data.profile.quote.author }}{% if site.data.profile.quote.source != "" %}, <em>{{ site.data.profile.quote.source }}</em>{% endif %}</cite></blockquote>{% endif %}
    <ul class="profile-links" aria-label="Academic profiles">{% for link in site.data.profile.links %}<li><a href="{{ link.url }}"{% unless link.url contains 'mailto:' or link.url contains 'cv/' %} target="_blank" rel="noreferrer"{% endunless %}>{{ link.label }}</a></li>{% endfor %}</ul>
  </div>
</section>
HTML

cat > "$SITE_DIR/_includes/research.html" <<'HTML'
<!-- TEMPLATE: Edit research content and translations in _data/research.yml. -->
<section class="content-section" id="research" aria-labelledby="research-title">
  <h2 id="research-title" data-i18n{% for language in site.data.languages.available %} data-{{ language.code }}="{{ site.data.ui.sections.research[language.code] | default: site.data.ui.sections.research[site.data.languages.default] | escape }}"{% endfor %}>{{ site.data.ui.sections.research[site.data.languages.default] }}</h2>
  <div class="section-body">
    <p data-i18n{% for language in site.data.languages.available %}{% capture key %}intro_{{ language.code }}{% endcapture %} data-{{ language.code }}="{{ site.data.research[key] | default: site.data.research.intro_en | escape }}"{% endfor %}>{{ site.data.research.intro_en }}</p>
    <ul class="plain-list">{% for topic in site.data.research.topics %}<li data-i18n{% for language in site.data.languages.available %} data-{{ language.code }}="{{ topic[language.code] | default: topic[site.data.languages.default] | escape }}"{% endfor %}>{{ topic[site.data.languages.default] }}</li>{% endfor %}</ul>
  </div>
</section>
HTML

cat > "$SITE_DIR/_includes/education.html" <<'HTML'
<!-- TEMPLATE: Edit education, experience and translations in _data/education.yml. -->
<section class="content-section" id="education" aria-labelledby="education-title">
  <h2 id="education-title" data-i18n{% for language in site.data.languages.available %} data-{{ language.code }}="{{ site.data.ui.sections.education[language.code] | default: site.data.ui.sections.education[site.data.languages.default] | escape }}"{% endfor %}>{{ site.data.ui.sections.education[site.data.languages.default] }}</h2>
  <div class="section-body"><ul class="plain-list education-list">{% for item in site.data.education %}<li><strong data-i18n{% for language in site.data.languages.available %}{% capture key %}title_{{ language.code }}{% endcapture %} data-{{ language.code }}="{{ item[key] | default: item.title_en | escape }}"{% endfor %}>{{ item.title_en }}</strong>, <span data-i18n{% for language in site.data.languages.available %}{% capture key %}institution_{{ language.code }}{% endcapture %} data-{{ language.code }}="{{ item[key] | default: item.institution_en | escape }}"{% endfor %}>{{ item.institution_en }}</span> <span class="education-period">({{ item.period }})</span>.</li>{% endfor %}</ul></div>
</section>
HTML

cat > "$SITE_DIR/_includes/research-group.html" <<'HTML'
<!-- TEMPLATE: Edit groups, affiliations and translations in _data/affiliations.yml. -->
<section class="content-section" id="research-affiliations" aria-labelledby="research-affiliations-title">
  <h2 id="research-affiliations-title" data-i18n{% for language in site.data.languages.available %} data-{{ language.code }}="{{ site.data.ui.sections.affiliations[language.code] | default: site.data.ui.sections.affiliations[site.data.languages.default] | escape }}"{% endfor %}>{{ site.data.ui.sections.affiliations[site.data.languages.default] }}</h2>
  <div class="section-body"><ul class="plain-list">{% for group in site.data.affiliations %}<li><a href="{{ group.url }}" target="_blank" rel="noopener noreferrer"><strong>{{ group.name }}</strong></a><span data-i18n{% for language in site.data.languages.available %}{% capture key %}description_{{ language.code }}{% endcapture %} data-{{ language.code }}=" — {{ group[key] | default: group.description_en | escape }}"{% endfor %}> — {{ group.description_en }}</span></li>{% endfor %}</ul></div>
</section>
HTML

cat > "$SITE_DIR/_includes/publications.html" <<'HTML'
<!-- TEMPLATE: Edit publications and translations in _data/publications.yml. -->
<section class="content-section" id="publications" aria-labelledby="publications-title">
  <h2 id="publications-title" data-i18n{% for language in site.data.languages.available %} data-{{ language.code }}="{{ site.data.ui.sections.publications[language.code] | default: site.data.ui.sections.publications[site.data.languages.default] | escape }}"{% endfor %}>{{ site.data.ui.sections.publications[site.data.languages.default] }}</h2>
  <div class="section-body"><ol class="publication-list">{% for publication in site.data.publications %}<li><p class="publication-title">{{ publication.title }}</p><p>{% for author in publication.authors %}{% if author.self %}<strong>{{ author.name }}</strong>{% elsif author.url %}<a href="{{ author.url }}" target="_blank" rel="noopener noreferrer">{{ author.name }}</a>{% else %}{{ author.name }}{% endif %}{% unless forloop.last %}{% if forloop.rindex == 2 %} and {% else %}, {% endif %}{% endunless %}{% endfor %}.</p><p class="publication-note"><span data-i18n{% for language in site.data.languages.available %}{% capture key %}note_{{ language.code }}{% endcapture %} data-{{ language.code }}="{{ publication[key] | default: publication.note_en | escape }}"{% endfor %}>{{ publication.note_en }}</span> <a href="{{ publication.link_url }}" target="_blank" rel="noopener noreferrer">{{ publication.link_label }}</a></p></li>{% endfor %}</ol><p class="more-link"><span data-i18n{% for language in site.data.languages.available %} data-{{ language.code }}="{{ site.data.ui.labels.records[language.code] | default: site.data.ui.labels.records[site.data.languages.default] | escape }}"{% endfor %}>{{ site.data.ui.labels.records[site.data.languages.default] }}</span> <a href="https://lattes.cnpq.br/6512284414514021" target="_blank" rel="noreferrer">Lattes</a> <span aria-hidden="true">·</span> <a href="https://scholar.google.com/citations?hl=en&amp;user=SJJP-ngAAAAJ" target="_blank" rel="noreferrer">Google Scholar</a></p></div>
</section>
HTML

cat > "$SITE_DIR/_includes/simulations.html" <<'HTML'
<!-- TEMPLATE: Edit section text in _data/simulations.yml; add videos to assets/simulacoes/. -->
<section class="content-section" id="simulations" aria-labelledby="simulations-title">
  <h2 id="simulations-title" data-i18n{% for language in site.data.languages.available %} data-{{ language.code }}="{{ site.data.ui.sections.simulations[language.code] | default: site.data.ui.sections.simulations[site.data.languages.default] | escape }}"{% endfor %}>{{ site.data.ui.sections.simulations[site.data.languages.default] }}</h2>
  <div class="section-body simulation-copy"><p data-i18n{% for language in site.data.languages.available %}{% capture key %}description_{{ language.code }}{% endcapture %} data-{{ language.code }}="{{ site.data.simulations[key] | default: site.data.simulations.description_en | escape }}"{% endfor %}>{{ site.data.simulations.description_en }}</p><p><a href="{{ site.data.simulations.repository_url }}" target="_blank" rel="noreferrer" data-i18n{% for language in site.data.languages.available %}{% capture key %}repository_label_{{ language.code }}{% endcapture %} data-{{ language.code }}="{{ site.data.simulations[key] | default: site.data.simulations.repository_label_en | escape }}"{% endfor %}>{{ site.data.simulations.repository_label_en }}</a></p></div>
  <figure class="simulation-player"><video id="simulation-video" muted autoplay playsinline preload="metadata" poster="{{ site.data.simulations.poster }}" aria-label="Stochastic process simulation"></video><figcaption class="simulation-meta"><span id="simulation-name">Loading simulation…</span><span class="simulation-controls"><button id="simulation-toggle" type="button" data-state="playing" data-i18n{% for language in site.data.languages.available %} data-{{ language.code }}="{{ site.data.ui.labels.pause[language.code] | default: site.data.ui.labels.pause[site.data.languages.default] | escape }}"{% endfor %}>{{ site.data.ui.labels.pause[site.data.languages.default] }}</button><span aria-hidden="true"> · </span><button id="simulation-next" type="button" data-i18n{% for language in site.data.languages.available %} data-{{ language.code }}="{{ site.data.ui.labels.next[language.code] | default: site.data.ui.labels.next[site.data.languages.default] | escape }}"{% endfor %}>{{ site.data.ui.labels.next[site.data.languages.default] }}</button><span id="simulation-count" aria-live="polite"></span></span></figcaption></figure>
</section>
HTML

cat > "$SITE_DIR/_includes/contact.html" <<'HTML'
<!-- TEMPLATE: Edit the public email address in _data/contact.yml. -->
<section class="content-section contact-section" id="contact" aria-labelledby="contact-title"><h2 id="contact-title" data-i18n{% for language in site.data.languages.available %} data-{{ language.code }}="{{ site.data.ui.sections.contact[language.code] | default: site.data.ui.sections.contact[site.data.languages.default] | escape }}"{% endfor %}>{{ site.data.ui.sections.contact[site.data.languages.default] }}</h2><div class="section-body"><p><a href="mailto:{{ site.data.contact.email }}">{{ site.data.contact.email }}</a></p></div></section>
HTML

cat > "$SITE_DIR/theme.css" <<'CSS'
---
---
/* Generated from _data/theme.yml. Edit colors there, not in this file. */
:root {
  color-scheme: light;
  --paper: {{ site.data.theme.light.paper }};
  --ink: {{ site.data.theme.light.ink }};
  --muted: {{ site.data.theme.light.muted }};
  --line: {{ site.data.theme.light.line }};
  --link: {{ site.data.theme.light.link }};
  --link-hover: {{ site.data.theme.light.link_hover }};
  --soft: {{ site.data.theme.light.soft }};
  --site-header-background: {{ site.data.theme.light.header }};
}

:root[data-theme="dark"] {
  color-scheme: dark;
  --paper: {{ site.data.theme.dark.paper }};
  --ink: {{ site.data.theme.dark.ink }};
  --muted: {{ site.data.theme.dark.muted }};
  --line: {{ site.data.theme.dark.line }};
  --link: {{ site.data.theme.dark.link }};
  --link-hover: {{ site.data.theme.dark.link_hover }};
  --soft: {{ site.data.theme.dark.soft }};
  --site-header-background: {{ site.data.theme.dark.header }};
}

.site-header { background: var(--site-header-background); }
body, .site-header, a, button { transition: background-color 180ms ease, color 180ms ease, border-color 180ms ease; }
CSS

cat > "$SITE_DIR/theme.js" <<'JS'
---
---
// Theme settings come from _data/theme.yml. Edit the data file, not this script.
(() => {
  const mode = {{ site.data.theme.mode | jsonify }};
  const lightStart = Number({{ site.data.theme.light_start | default: 7 }});
  const darkStart = Number({{ site.data.theme.dark_start | default: 19 }});
  const applyTheme = () => {
    const hour = new Date().getHours();
    const automatic = hour >= lightStart && hour < darkStart ? 'light' : 'dark';
    document.documentElement.dataset.theme = mode === 'auto' ? automatic : mode;
  };
  applyTheme();
  window.setInterval(applyTheme, 300000);
})();
JS

cat > "$SITE_DIR/CUSTOMIZE.md" <<'MARKDOWN'
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
MARKDOWN

cat > "$SITE_DIR/_data/README.md" <<'MARKDOWN'
# Editable site content

This folder contains the site's personal and academic information. Each YAML file begins with its own instructions. Keep the indentation unchanged and update every language listed in `languages.yml`.

`events.yml` controls events and their `photo_key` values. Images, videos and documents belong in `assets`, not in this folder.
MARKDOWN

cat > "$SITE_DIR/_includes/README.md" <<'MARKDOWN'
# Page templates

These files turn the information from `_data` into website sections. For ordinary content changes, edit the corresponding YAML file in `_data` instead. Each template starts with a comment identifying its data file.
MARKDOWN

cat > "$SITE_DIR/assets/README.md" <<'MARKDOWN'
# Media files

- `fotos/`: personal photos; all supported images are rotated automatically.
- `simulacoes/`: MP4 and WEBM simulation videos; detected automatically.
- `eventos/`: event photos; filenames must begin with the event's `photo_key`, such as `clapem-2026-1.jpg`.

After adding media, commit the files and push them to GitHub. No installer needs to be run again.
MARKDOWN

/usr/bin/python3 - "$SITE_DIR" <<'PYTHON'
from pathlib import Path
import re
import sys

root = Path(sys.argv[1])
index_path = root / "index.html"
index = index_path.read_text(encoding="utf-8")

events_path = root / "_data" / "events.yml"
if events_path.exists():
    events = events_path.read_text(encoding="utf-8")
    events_help = '''# HOW TO USE
# Each block below represents one event. Copy a complete block to add another.
# Use status: "upcoming" before the event and status: "past" afterwards.
# photo_key connects local images from assets/eventos/ to this event.
# Example filenames: clapem-2026-1.jpg and clapem-2026-2.webp.
# Leave URL fields as empty quotation marks when no link is available.
# Add one translated field for every language listed in languages.yml.
# Keep the indentation exactly as shown.

'''
    if not events.startswith('# HOW TO USE'):
        events_path.write_text(events_help + events, encoding="utf-8")

profile_pattern = re.compile(r'<section class="profile".*?</section>', re.DOTALL)
if not profile_pattern.search(index):
    raise SystemExit("Não encontrei a seção profile no index.html.")
index = profile_pattern.sub('{% include profile.html %}', index, count=1)

if '{% include education.html %}' not in index:
    index = index.replace('{% include research.html %}', '{% include research.html %}\n\n      {% include education.html %}', 1)

if 'href="#education"' not in index:
    research_link = next((line for line in index.splitlines() if 'href="#research"' in line), None)
    if research_link:
        indent = research_link[:len(research_link)-len(research_link.lstrip())]
        education_link = f'{indent}<a href="#education" data-en="Education" data-pt="Formação">Education</a>'
        index = index.replace(research_link, research_link + '\n' + education_link, 1)

index_path.write_text(index, encoding="utf-8")

for page in root.glob('*.html'):
    text = page.read_text(encoding="utf-8")
    text = re.sub(
        r'<nav class="site-nav".*?</nav>',
        '{% include navigation.html %}',
        text,
        flags=re.DOTALL,
    )
    text = re.sub(
        r'<div class="language-switch".*?</div>',
        '{% include language-switch.html %}',
        text,
        flags=re.DOTALL,
    )
    if 'href="theme.css"' not in text and 'href="styles.css"' in text:
        text = text.replace('<link rel="stylesheet" href="styles.css" />', '<link rel="stylesheet" href="styles.css" />\n    <link rel="stylesheet" href="theme.css" />', 1)
    if 'window.siteLanguages' not in text and 'src="script.js"' in text:
        config = '<script>window.siteLanguages = {{ site.data.languages | jsonify }}; window.siteUI = {{ site.data.ui | jsonify }};</script>\n    '
        text = text.replace('<script src="script.js" defer></script>', config + '<script src="script.js" defer></script>', 1)
    if 'src="theme.js"' not in text and 'src="script.js"' in text:
        text = text.replace('<script src="script.js" defer></script>', '<script src="theme.js"></script>\n    <script src="script.js" defer></script>', 1)
    text = text.replace('data-en="← Back to events" data-pt="← Voltar aos eventos"', 'data-i18n data-en="← Back to events" data-pt="← Voltar aos eventos" data-es="← Volver a los eventos"')
    text = text.replace('data-en="Event photos" data-pt="Fotos do evento"', 'data-i18n data-en="Event photos" data-pt="Fotos do evento" data-es="Fotos del evento"')
    text = text.replace('data-en="Loading photos…" data-pt="Carregando fotos…"', 'data-i18n data-en="Loading photos…" data-pt="Carregando fotos…" data-es="Cargando fotos…"')
    text = text.replace('data-en="Skip to content" data-pt="Ir para o conteúdo"', 'data-i18n data-en="Skip to content" data-pt="Ir para o conteúdo" data-es="Ir al contenido"')
    page.write_text(text, encoding="utf-8")

script_path = root / 'script.js'
script = script_path.read_text(encoding='utf-8')
script = re.sub(
    r'const languages = \["en", "pt"\];\nconst languageButtons = document\.querySelectorAll\("\[data-language\]"\);\nconst translatableElements = document\.querySelectorAll\("\[data-en\]\[data-pt\]"\);',
    '''const languageConfiguration = window.siteLanguages || {\n  default: "en",\n  available: [{ code: "en", html_lang: "en" }],\n};\nconst languages = languageConfiguration.available.map((language) => language.code);\nconst defaultLanguage = languages.includes(languageConfiguration.default)\n  ? languageConfiguration.default\n  : languages[0];\nconst languageButtons = document.querySelectorAll("[data-language]");''',
    script,
    count=1,
)
script = script.replace('if (!languages.includes(currentLanguage)) currentLanguage = "en";', 'if (!languages.includes(currentLanguage)) currentLanguage = defaultLanguage;')
script = re.sub(
    r'function simulationToggleText\(\) \{.*?\n\}',
    '''function simulationToggleText() {\n  if (!simulationToggle) return;\n  const isPaused = simulationVideo?.paused ?? true;\n  const key = isPaused ? "play" : "pause";\n  const labels = window.siteUI?.labels?.[key] || {};\n  simulationToggle.textContent = labels[currentLanguage] || labels[defaultLanguage] || key;\n  simulationToggle.dataset.state = isPaused ? "paused" : "playing";\n}''',
    script,
    count=1,
    flags=re.DOTALL,
)
script = re.sub(
    r'function setLanguage\(language\) \{.*?\n\}',
    '''function setLanguage(language) {\n  currentLanguage = languages.includes(language) ? language : defaultLanguage;\n  const languageDetails = languageConfiguration.available.find(\n    (item) => item.code === currentLanguage,\n  );\n  document.documentElement.lang = languageDetails?.html_lang || currentLanguage;\n  document.querySelectorAll("[data-i18n]").forEach((element) => {\n    const translated = element.dataset[currentLanguage] ?? element.dataset[defaultLanguage];\n    if (translated !== undefined) element.textContent = translated;\n  });\n  languageButtons.forEach((button) => {\n    button.setAttribute("aria-pressed", String(button.dataset.language === currentLanguage));\n  });\n  localStorage.setItem("esp-language", currentLanguage);\n  simulationToggleText();\n}''',
    script,
    count=1,
    flags=re.DOTALL,
)
script = re.sub(
    r'''    link\.dataset\.en = 'Photos';.*?    links\.appendChild\(link\);''',
    '''    link.dataset.i18n = '';\n    const photoLabels = window.siteUI?.labels?.photos || { en: 'Photos' };\n    languageConfiguration.available.forEach((language) => {\n      link.dataset[language.code] = photoLabels[language.code] || photoLabels[defaultLanguage];\n    });\n    link.textContent = link.dataset[currentLanguage] || link.dataset[defaultLanguage];\n    links.appendChild(link);''',
    script,
    count=1,
    flags=re.DOTALL,
)
script = script.replace("      status.dataset.pt = 'Nenhuma foto foi encontrada para este evento.';", "      status.dataset.pt = 'Nenhuma foto foi encontrada para este evento.';\n      status.dataset.es = 'No se encontraron fotos para este evento.';")
script = script.replace("      status.textContent = document.documentElement.lang.startsWith('pt')\n        ? status.dataset.pt\n        : status.dataset.en;", "      status.dataset.i18n = '';\n      status.textContent = status.dataset[currentLanguage] || status.dataset[defaultLanguage];")
script_path.write_text(script, encoding='utf-8')

styles_path = root / 'styles.css'
styles = styles_path.read_text(encoding='utf-8')
styles = styles.replace('background: rgba(255, 255, 255, 0.96);', 'background: var(--site-header-background, rgba(255, 255, 255, 0.96));')
if '/* Data-driven education */' not in styles:
    styles += '\n\n/* Data-driven education */\n.education-period { color: var(--muted); white-space: nowrap; }\n'
styles_path.write_text(styles, encoding='utf-8')
PYTHON

echo
echo "Site reorganizado com sucesso."
echo "Cópia de segurança: $BACKUP_DIR"
echo "Conteúdo editável: _data/"
echo "Guia: CUSTOMIZE.md"
echo "Tema automático configurado pelo horário local do visitante."
echo
show_message "Site reorganizado. O conteúdo agora fica em _data e o tema muda automaticamente conforme o horário local."

read -r -p "Pressione Enter para fechar..." _
SELF_PATH="$(cd "$(dirname "$0")" && pwd -P)/$(basename "$0")"
[[ -f "$SELF_PATH" ]] && rm -- "$SELF_PATH"
