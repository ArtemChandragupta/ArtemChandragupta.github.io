const prefersDark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark').matches;

let theme = localStorage.theme || (prefersDark ? "dark" : "light");

document.documentElement.dataset.theme = theme;

const q = document.querySelector.bind(document);

function updateThemeSelector() {
  const currentTheme = theme;
  const nextTheme = currentTheme === 'light' ? 'dark' : 'light';
  
  q('#themeSelector').innerHTML = `
    <button id="themeToggle" title="Toggle theme">
      theme: ${currentTheme}
    </button>
  `;

  q('#themeToggle').addEventListener('click', () => setTheme(nextTheme));

  const colors = {
    fill: getComputedStyle(q('.main-background'))['backgroundColor'],
    stroke: getComputedStyle(q('.main-background'))['color']
  };
  document.querySelector('meta[name="theme-color"]')?.setAttribute("content", colors.fill);
}

function setTheme(id) {
  localStorage.setItem('theme', id);
  document.documentElement.dataset.theme = id;
  theme = id;
  updateThemeSelector();
}

updateThemeSelector();
