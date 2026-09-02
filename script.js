const languageButton = document.querySelector(".language-toggle");
const languageCurrent = document.querySelector(".language-current");
const languageTarget = document.querySelector(".language-target");
const translatableElements = document.querySelectorAll("[data-en][data-pt]");
const menuButton = document.querySelector(".menu-toggle");
const navigation = document.querySelector(".site-nav");
const header = document.querySelector(".site-header");

const metadata = {
  en: { buttonLabel: "Mudar para português" },
  pt: { buttonLabel: "Switch to English" },
};

let currentLanguage = localStorage.getItem("esp-language") || "en";

function setLanguage(language) {
  currentLanguage = language;
  document.documentElement.lang = language === "pt" ? "pt-BR" : "en";

  translatableElements.forEach((element) => {
    element.textContent = element.dataset[language];
  });

  document.title = document.body.dataset[`title${language === "en" ? "En" : "Pt"}`];
  document.querySelector('meta[name="description"]').content =
    document.body.dataset[`description${language === "en" ? "En" : "Pt"}`];
  languageButton.setAttribute("aria-label", metadata[language].buttonLabel);
  languageCurrent.textContent = language.toUpperCase();
  languageTarget.textContent = language === "en" ? "PT" : "EN";
  localStorage.setItem("esp-language", language);
}

languageButton.addEventListener("click", () => {
  setLanguage(currentLanguage === "en" ? "pt" : "en");
});

function closeMenu() {
  menuButton.setAttribute("aria-expanded", "false");
  navigation.classList.remove("open");
  document.body.classList.remove("menu-open");
}

menuButton.addEventListener("click", () => {
  const isOpen = menuButton.getAttribute("aria-expanded") === "true";
  menuButton.setAttribute("aria-expanded", String(!isOpen));
  navigation.classList.toggle("open", !isOpen);
  document.body.classList.toggle("menu-open", !isOpen);
});

navigation.querySelectorAll("a").forEach((link) => {
  link.addEventListener("click", closeMenu);
});

window.addEventListener("resize", () => {
  if (window.innerWidth > 960) closeMenu();
});

window.addEventListener(
  "scroll",
  () => {
    header.classList.toggle("scrolled", window.scrollY > 12);
  },
  { passive: true },
);

const revealObserver = new IntersectionObserver(
  (entries, observer) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add("visible");
        observer.unobserve(entry.target);
      }
    });
  },
  { threshold: 0.12, rootMargin: "0px 0px -40px" },
);

document.querySelectorAll(".reveal").forEach((element) => revealObserver.observe(element));

const portraitSlides = [...document.querySelectorAll(".portrait-slide")];
const reducedMotion = window.matchMedia("(prefers-reduced-motion: reduce)");
const heroSimulation = document.querySelector(".hero-simulation");

if (heroSimulation && reducedMotion.matches) {
  heroSimulation.pause();
}

if (portraitSlides.length > 1 && !reducedMotion.matches) {
  let activePortrait = 0;

  window.setInterval(() => {
    portraitSlides[activePortrait].classList.remove("active");
    activePortrait = (activePortrait + 1) % portraitSlides.length;
    portraitSlides[activePortrait].classList.add("active");
  }, 5200);
}

const currentPage = document.body.dataset.page;
document.querySelectorAll(".site-nav a[data-page-link]").forEach((link) => {
  if (link.dataset.pageLink === currentPage) {
    link.classList.add("active");
    link.setAttribute("aria-current", "page");
  }
});

document.getElementById("current-year").textContent = new Date().getFullYear();
setLanguage(currentLanguage);
