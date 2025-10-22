const themes = {
  'blew': {
    'fg': '#aeb7e8',
    'bg': '#030826',
    'act1': '#1f2b68',
    'act2': '#aeb7e8',
    'act3': '#1f2b68',
    'ina1': '#0b164f',
    'ina2': '#47bc4f',
    'ina3': '#15152f',
    'wall': '#0b164f',
  },
  'nanoc': {
    'fg': '#f6ebd3',
    'bg': '#2a232d',
    'act1': '#de7138',
    'act2': '#2a232d',
    'act3': '#dbac89',
    'ina1': '#a13b3a',
    'ina2': '#2a232d',
    'ina3': '#532a3a',
    'wall': '#3e434b',
  },
  'buddybud': {
    'fg': '#bdae93',
    'bg': '#252323',
    'act1': '#458588',
    'act2': '#f9f5d7',
    'act3': '#32302F',
    'ina1': '#32302F',
    'ina2': '#bdae93',
    'ina3': '#32302F',
    'wall': '#32302F',
  },
  'budgray': {
    'fg': '#333333',
    'bg': '#cccccc',
    'act1': '#3c6388',
    'act2': '#ebdbb2',
    'act3': '#3c6388',
    'ina1': '#314D68',
    'ina2': '#bdae93',
    'ina3': '#314D68',
    'wall': '#314D68',
  },
  'dracula': {
    'fg': '#ffffff',
    'bg': '#24283b',
    'act1': '#313E7C',
    'act2': '#ffffff',
    'act3': '#313E7C',
    'ina1': '#44475a',
    'ina2': '#ffffff',
    'ina3': '#44475a',
    'wall': '#44475a',
  },
  'forest': {
    'fg': '#252323',
    'bg': '#bdae93',
    'act1': '#427b58',
    'act2': '#f9f5d7',
    'act3': '#427b58',
    'ina1': '#427b58',
    'ina2': '#252323',
    'ina3': '#427b58',
    'wall': '#bdae93',
  },
  'gruvbox': {
    'fg': '#fbf1c7',
    'bg': '#282828',
    'act1': '#1d2021',
    'act2': '#bdae93',
    'act3': '#1d2021',
    'ina1': '#1d2021',
    'ina2': '#fbf1c7',
    'ina3': '#1d2021',
    'wall': '#1d2021',
  },
  'hyper': {
    'fg': '#c5a9a7',
    'bg': '#15152f',
    'act1': '#254f64',
    'act2': '#FFEFFE',
    'act3': '#15152f',
    'ina1': '#3d6481',
    'ina2': '#c5a9a7',
    'ina3': '#15152f',
    'wall': '#3d6481',
  },
  'kasugano': {
    'fg': '#ffffff',
    'bg': '#1b1b1b',
    'act1': '#E54F5D',
    'act2': '#FFFFFF',
    'act3': '#E54F5D',
    'ina1': '#9A1C3E',
    'ina2': '#ffffff',
    'ina3': '#9A1C3E',
    'wall': '#1b1b1b',
  },
  'monokai': {
    'fg': '#F1EBEB',
    'bg': '#272822',
    'act1': '#272822',
    'act2': '#F1EBEB',
    'act3': '#8FC029',
    'ina1': '#272822',
    'ina2': '#F1EBEB',
    'ina3': '#F1EBEB',
    'wall': '#272822',
  },
  'nature-suede': {
    'fg': '#c8c2a7',
    'bg': '#170f0D',
    'act1': '#392925',
    'act2': '#c8c2a7',
    'act3': '#120d0c',
    'ina1': '#4a4342',
    'ina2': '#0b0908',
    'ina3': '#120d0c',
    'wall': '#4a4342',
  },
  'nord': {
    'fg': '#D8DEE9',
    'bg': '#2E3440',
    'act1': '#3B4252',
    'act2': '#f9f5d7',
    'act3': '#4C566A',
    'ina1': '#434C5E',
    'ina2': '#D8DEE9',
    'ina3': '#4C566A',
    'wall': '#434C5E',
  },
  'notepad': {
    'fg': '#252323',
    'bg': '#FFBB8B',
    'act1': '#FF8C57',
    'act2': '#ffffff',
    'act3': '#F77438',
    'ina1': '#BD9B61',
    'ina2': '#9F7A39',
    'ina3': '#9F7A39',
    'wall': '#BD9B61',
  },
  'notepad-bud': {
    'fg': '#252323',
    'bg': '#f1dab0',
    'act1': '#FC9B4A',
    'act2': '#FFD9C7',
    'act3': '#FC9B4A',
    'ina1': '#BD9B61',
    'ina2': '#9F7A39',
    'ina3': '#9F7A39',
    'wall': '#BD9B61',
  },
  'pal': {
    'fg': '#f2e5bc',
    'bg': '#000000',
    'act1': '#181921',
    'act2': '#f2e5bc',
    'act3': '#181921',
    'ina1': '#15152f',
    'ina2': '#666666',
    'ina3': '#15152f',
    'wall': '#15152f',
  },
  'purple': {
    'fg': '#d9cfd3',
    'bg': '#0f090c',
    'act1': '#36001B',
    'act2': '#d9cfd3',
    'act3': '#36001B',
    'ina1': '#0f090c',
    'ina2': '#666666',
    'ina3': '#15152f',
    'wall': '#0f090c',
  },
  'solarized-dark': {
    'fg': '#adbcbc',
    'bg': '#103c48',
    'act1': '#184956',
    'act2': '#cad8d9',
    'act3': '#184956',
    'ina1': '#103c48',
    'ina2': '#adbcbc',
    'ina3': '#184956',
    'wall': '#103c48',
  },
  'solarized-light': {
    'fg': '#1c1c1c',
    'bg': '#ffffd7',
    'act1': '#4e4e4e',
    'act2': '#ffffd7',
    'act3': '#808080',
    'ina1': '#8a8a8a',
    'ina2': '#ffffd7',
    'ina3': '#808080',
    'wall': '#8a8a8a',
  },
  'trim-yer-beard': {
    'fg': '#daba8b',
    'bg': '#191716',
    'act1': '#a86441',
    'act2': '#daba8b',
    'act3': '#383332',
    'ina1': '#262322',
    'ina2': '#755e4a',
    'ina3': '#383332',
    'wall': '#262322',
  },
  'yousai': {
    'fg': '#F5E7DE',
    'bg': '#4C3226',
    'act1': '#664233',
    'act2': '#F5E7DE',
    'act3': '#664233',
    'ina1': '#2E2420',
    'ina2': '#A67C53',
    'ina3': '#2E2420',
    'wall': '#4C3226',
  },
};

const mapTheme = (variables) => {
  if (variables == null) {
    theme = 'yousai';
    return mapTheme(themes['yousai']);
  }

  return {
    '--foreground': variables.fg || '',
    '--background': variables.bg || '',
    '--border': variables.wall || '',
    '--background-secondary': variables.ina1 || '',
    '--foreground-secondary': variables.ina2 || '',
    '--border-secondary': variables.ina3 || '',
    '--background-primary': variables.act1 || '',
    '--foreground-primary': variables.act2 || '',
    '--border-primary': variables.act3 || '',
    '--color-wall': variables.wall || '',
  };
};

const randomTheme = () => {
    return Object.keys(themes)[Math.floor(Math.random()*Object.keys(themes).length)];
};

let new_url = new URLSearchParams(window.location.search);

let theme = new_url.get('theme');
if (theme == null) theme = 'random';

const themeObject = mapTheme(themes[theme]);

window.history.replaceState(null, document.title, window.location.href.split("?")[0] + "?theme=" + theme);

const root = document.documentElement;

Object.keys(themeObject).forEach((property) => {
  if (property === 'name') {
    return;
  }

  root.style.setProperty(property, themeObject[property]);
});
