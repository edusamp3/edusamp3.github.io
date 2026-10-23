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
