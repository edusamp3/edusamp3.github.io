const languageConfiguration = window.siteLanguages || {
  default: "en",
  available: [{ code: "en", html_lang: "en" }],
};
const languages = languageConfiguration.available.map((language) => language.code);
const defaultLanguage = languages.includes(languageConfiguration.default)
  ? languageConfiguration.default
  : languages[0];
const languageButtons = document.querySelectorAll("[data-language]");
const reducedMotion = window.matchMedia("(prefers-reduced-motion: reduce)");

let currentLanguage = localStorage.getItem("esp-language");
if (!languages.includes(currentLanguage)) currentLanguage = defaultLanguage;

function unique(items) {
  return [...new Set((items || []).filter(Boolean))];
}

function shuffle(items) {
  const result = [...items];
  for (let index = result.length - 1; index > 0; index -= 1) {
    const randomIndex = Math.floor(Math.random() * (index + 1));
    [result[index], result[randomIndex]] = [result[randomIndex], result[index]];
  }
  return result;
}

function mediaLabel(path) {
  const filename = decodeURIComponent(path.split("/").pop() || "");
  return filename
    .replace(/\.[^.]+$/, "")
    .replace(/^\d+[\s_-]*/, "")
    .replace(/[-_]+/g, " ")
    .replace(/\b\w/g, (letter) => letter.toUpperCase());
}

const simulationVideo = document.getElementById("simulation-video");
const simulationName = document.getElementById("simulation-name");
const simulationCount = document.getElementById("simulation-count");
const simulationToggle = document.getElementById("simulation-toggle");
const simulationNext = document.getElementById("simulation-next");
const videos = unique(window.siteMedia?.videos);
let videoOrder = shuffle(videos);
let videoIndex = 0;

function simulationToggleText() {
  if (!simulationToggle) return;
  const isPaused = simulationVideo?.paused ?? true;
  const key = isPaused ? "play" : "pause";
  const labels = window.siteUI?.labels?.[key] || {};
  simulationToggle.textContent = labels[currentLanguage] || labels[defaultLanguage] || key;
  simulationToggle.dataset.state = isPaused ? "paused" : "playing";
}

function loadVideo(index, autoplay = true) {
  if (!simulationVideo || videoOrder.length === 0) return;
  videoIndex = (index + videoOrder.length) % videoOrder.length;
  const source = videoOrder[videoIndex];
  simulationVideo.src = source;
  simulationVideo.load();
  simulationName.textContent = mediaLabel(source);
  simulationCount.textContent = `${videoIndex + 1} / ${videoOrder.length}`;

  if (autoplay && !reducedMotion.matches) {
    simulationVideo.play().catch(simulationToggleText);
  } else {
    simulationVideo.pause();
  }
  simulationToggleText();
}

function nextVideo() {
  if (videoOrder.length < 2) {
    if (simulationVideo) {
      simulationVideo.currentTime = 0;
      simulationVideo.play().catch(simulationToggleText);
    }
    return;
  }

  const previous = videoOrder[videoIndex];
  videoIndex += 1;
  if (videoIndex >= videoOrder.length) {
    videoOrder = shuffle(videos);
    videoIndex = 0;
    if (videoOrder[0] === previous) {
      const swapIndex = 1 + Math.floor(Math.random() * (videoOrder.length - 1));
      [videoOrder[0], videoOrder[swapIndex]] = [videoOrder[swapIndex], videoOrder[0]];
    }
  }
  loadVideo(videoIndex);
}

if (simulationVideo && videos.length > 0) {
  if (videos.length === 1) simulationVideo.loop = true;
  simulationVideo.addEventListener("ended", nextVideo);
  simulationVideo.addEventListener("play", simulationToggleText);
  simulationVideo.addEventListener("pause", simulationToggleText);
  simulationNext?.addEventListener("click", nextVideo);
  simulationToggle?.addEventListener("click", () => {
    if (simulationVideo.paused) {
      simulationVideo.play().catch(simulationToggleText);
    } else {
      simulationVideo.pause();
    }
  });
  loadVideo(0, !reducedMotion.matches);
} else if (simulationVideo) {
  simulationVideo.closest(".simulation-player")?.setAttribute("hidden", "");
}

const portraitLayers = [...document.querySelectorAll(".portrait-layer")];
const photos = shuffle(unique(window.siteMedia?.photos));
let photoIndex = 0;
let activeLayer = 0;

if (portraitLayers.length > 0 && photos.length > 0) {
  portraitLayers[0].src = photos[0];
  portraitLayers[0].classList.add("is-active");

  if (portraitLayers.length > 1 && photos.length > 1 && !reducedMotion.matches) {
    window.setInterval(() => {
      photoIndex = (photoIndex + 1) % photos.length;
      const nextLayer = activeLayer === 0 ? 1 : 0;
      portraitLayers[nextLayer].src = photos[photoIndex];
      portraitLayers[nextLayer].classList.add("is-active");
      portraitLayers[activeLayer].classList.remove("is-active");
      activeLayer = nextLayer;
    }, 6000);
  }
}

function setLanguage(language) {
  currentLanguage = languages.includes(language) ? language : defaultLanguage;
  const languageDetails = languageConfiguration.available.find(
    (item) => item.code === currentLanguage,
  );
  document.documentElement.lang = languageDetails?.html_lang || currentLanguage;
  document.querySelectorAll("[data-i18n]").forEach((element) => {
    const translated = element.dataset[currentLanguage] ?? element.dataset[defaultLanguage];
    if (translated !== undefined) element.textContent = translated;
  });
  languageButtons.forEach((button) => {
    button.setAttribute("aria-pressed", String(button.dataset.language === currentLanguage));
  });
  localStorage.setItem("esp-language", currentLanguage);
  simulationToggleText();
}

languageButtons.forEach((button) => {
  button.addEventListener("click", () => setLanguage(button.dataset.language));
});

document.getElementById("current-year").textContent = new Date().getFullYear();
setLanguage(currentLanguage);


// Automatic event photo links and separate gallery page
(async () => {
  const repositoryEndpoint =
    'https://api.github.com/repos/edusamp3/edusamp3.github.io/contents/assets/eventos';
  const supportedExtensions = /\.(avif|gif|jpe?g|png|webp)$/i;
  const normalize = (value) => value.toLowerCase().replace(/[^a-z0-9-]/g, '');
  const matchesKey = (file, key) => {
    const stem = normalize(file.name.replace(/\.[^.]+$/, ''));
    return stem === key || stem.startsWith(`${key}-`);
  };

  let files;
  try {
    const response = await fetch(repositoryEndpoint, {
      headers: { Accept: 'application/vnd.github+json' },
    });
    if (!response.ok) return;
    files = (await response.json())
      .filter((file) => file.type === 'file' && supportedExtensions.test(file.name));
  } catch (error) {
    console.warn('Event photos could not be loaded.', error);
    return;
  }

  const entries = [...document.querySelectorAll('[data-event-photo-key]')];
  entries.forEach((entry) => {
    const key = normalize(entry.dataset.eventPhotoKey || '');
    if (!key || !files.some((file) => matchesKey(file, key))) return;

    let links = entry.querySelector('.event-links');
    if (!links) {
      links = document.createElement('p');
      links.className = 'event-links';
      entry.querySelector('.event-information')?.appendChild(links);
    }

    const eventName = entry.querySelector('.event-name')?.textContent.trim() || '';
    const link = document.createElement('a');
    const parameters = new URLSearchParams({ event: key, name: eventName });
    link.href = `event-photos.html?${parameters.toString()}`;
    link.dataset.i18n = '';
    const photoLabels = window.siteUI?.labels?.photos || { en: 'Photos' };
    languageConfiguration.available.forEach((language) => {
      link.dataset[language.code] = photoLabels[language.code] || photoLabels[defaultLanguage];
    });
    link.textContent = link.dataset[currentLanguage] || link.dataset[defaultLanguage];
    links.appendChild(link);
  });

  const gallery = document.getElementById('event-photo-gallery');
  if (!gallery) return;

  const parameters = new URLSearchParams(window.location.search);
  const key = normalize(parameters.get('event') || '');
  const name = (parameters.get('name') || '').trim();
  const title = document.getElementById('event-photo-title');
  const status = document.getElementById('event-photo-status');

  if (name && title) {
    title.textContent = name;
    title.dataset.en = name;
    title.dataset.pt = name;
    document.title = `${name} — Eduardo Sampaio Pimenta`;
  }

  const matches = key
    ? files
        .filter((file) => matchesKey(file, key))
        .sort((a, b) => a.name.localeCompare(b.name, undefined, { numeric: true }))
    : [];

  if (!matches.length) {
    if (status) {
      status.dataset.en = 'No photos were found for this event.';
      status.dataset.pt = 'Nenhuma foto foi encontrada para este evento.';
      status.dataset.es = 'No se encontraron fotos para este evento.';
      status.dataset.i18n = '';
      status.textContent = status.dataset[currentLanguage] || status.dataset[defaultLanguage];
    }
    return;
  }

  if (status) status.remove();
  matches.forEach((file, index) => {
    const link = document.createElement('a');
    link.href = file.download_url;
    link.target = '_blank';
    link.rel = 'noopener noreferrer';

    const image = document.createElement('img');
    image.src = file.download_url;
    image.alt = `${name || 'Event'} — photo ${index + 1}`;
    image.loading = index < 2 ? 'eager' : 'lazy';
    image.decoding = 'async';

    link.appendChild(image);
    gallery.appendChild(link);
  });
})();
