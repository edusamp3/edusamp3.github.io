const languageButton = document.querySelector(".language-toggle");
const languageCurrent = document.querySelector(".language-current");
const languageTarget = document.querySelector(".language-target");
const translatableElements = document.querySelectorAll("[data-en][data-pt]");
const menuButton = document.querySelector(".menu-toggle");
const navigation = document.querySelector(".site-nav");
const header = document.querySelector(".site-header");

const metadata = {
  en: {
    title: "Eduardo Sampaio Pimenta — Mathematics",
    description:
      "Academic website of Eduardo Sampaio Pimenta, mathematician and researcher in probability theory, stochastic processes, scaling limits and random walks.",
    buttonLabel: "Mudar para português",
  },
  pt: {
    title: "Eduardo Sampaio Pimenta — Matemática",
    description:
      "Site acadêmico de Eduardo Sampaio Pimenta, matemático e pesquisador em teoria da probabilidade, processos estocásticos, limites de escala e passeios aleatórios.",
    buttonLabel: "Switch to English",
  },
};

let currentLanguage = localStorage.getItem("esp-language") || "en";

function setLanguage(language) {
  currentLanguage = language;
  document.documentElement.lang = language === "pt" ? "pt-BR" : "en";

  translatableElements.forEach((element) => {
    element.textContent = element.dataset[language];
  });

  document.title = metadata[language].title;
  document.querySelector('meta[name="description"]').content = metadata[language].description;
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

const sections = document.querySelectorAll("main section[id]");
const navLinks = document.querySelectorAll(".site-nav a");

const sectionObserver = new IntersectionObserver(
  (entries) => {
    entries.forEach((entry) => {
      if (!entry.isIntersecting) return;
      navLinks.forEach((link) => {
        link.classList.toggle("active", link.getAttribute("href") === `#${entry.target.id}`);
      });
    });
  },
  { rootMargin: "-35% 0px -55%", threshold: 0 },
);

sections.forEach((section) => sectionObserver.observe(section));

document.getElementById("current-year").textContent = new Date().getFullYear();
setLanguage(currentLanguage);
