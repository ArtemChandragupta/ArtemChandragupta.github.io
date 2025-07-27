const defaultThemes = {
  light: "gruvbox-light",
  dark: "gruvbox-dark"
}

const prefersDark = window.matchMedia?.('(prefers-color-scheme: dark)').matches;

let theme = localStorage.theme || (prefersDark ? defaultThemes.dark : defaultThemes.light);

document.documentElement.dataset.theme = theme;

const q = document.querySelector.bind(document);

function toggleTheme() {
  const nextTheme = theme === defaultThemes.light 
    ? defaultThemes.dark 
    : defaultThemes.light;
  
  setTheme(nextTheme);
}

function initThemeButton() {
  const button = document.createElement('button');
  button.id = 'themeToggle';
  button.textContent = theme.includes('light') ? 'LIGHT' : 'DARK';
  button.title = 'Сменить тему';
  button.addEventListener('click', toggleTheme);
  
  q('#themeSelector').replaceChildren(button);
}

function setTheme(id) {
  localStorage.setItem('theme', id);
  document.documentElement.dataset.theme = id;
  theme = id;
  updateThemeButton();
}

function updateThemeButton() {
  const button = q('#themeSelector');
  if (button) {
    button.textContent = theme.includes('light') ? 'LIGHT' : 'DARK';
  }
}

initThemeButton();
