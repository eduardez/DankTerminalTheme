.pragma library

var themes = [
    // --- Nord ---
    {
        id: "nord", name: "Nord", ghosttyName: "Nord",
        background: "#2e3440", foreground: "#d8dee9",
        cursorColor: "#eceff4", cursorText: "#282828",
        selectionBackground: "#eceff4", selectionForeground: "#4c566a",
        palette: ["#3b4252","#bf616a","#a3be8c","#ebcb8b","#81a1c1","#b48ead","#88c0d0","#e5e9f0",
                   "#596377","#bf616a","#a3be8c","#ebcb8b","#81a1c1","#b48ead","#8fbcbb","#eceff4"]
    },
    // --- Dracula ---
    {
        id: "dracula", name: "Dracula", ghosttyName: "Dracula",
        background: "#282a36", foreground: "#f8f8f2",
        cursorColor: "#f8f8f2", cursorText: "#282a36",
        selectionBackground: "#44475a", selectionForeground: "#ffffff",
        palette: ["#21222c","#ff5555","#50fa7b","#f1fa8c","#bd93f9","#ff79c6","#8be9fd","#f8f8f2",
                   "#6272a4","#ff6e6e","#69ff94","#ffffa5","#d6acff","#ff92df","#a4ffff","#ffffff"]
    },
    // --- Catppuccin Mocha ---
    {
        id: "catppuccin-mocha", name: "Catppuccin Mocha", ghosttyName: "Catppuccin Mocha",
        background: "#1e1e2e", foreground: "#cdd6f4",
        cursorColor: "#f5e0dc", cursorText: "#1e1e2e",
        selectionBackground: "#585b70", selectionForeground: "#cdd6f4",
        palette: ["#45475a","#f38ba8","#a6e3a1","#f9e2af","#89b4fa","#f5c2e7","#94e2d5","#a6adc8",
                   "#585b70","#f37799","#89d88b","#ebd391","#74a8fc","#f2aede","#6bd7ca","#bac2de"]
    },
    // --- Catppuccin Latte ---
    {
        id: "catppuccin-latte", name: "Catppuccin Latte", ghosttyName: "Catppuccin Latte",
        background: "#eff1f5", foreground: "#4c4f69",
        cursorColor: "#dc8a78", cursorText: "#eff1f5",
        selectionBackground: "#acb0be", selectionForeground: "#4c4f69",
        palette: ["#5c5f77","#d20f39","#40a02b","#df8e1d","#1e66f5","#ea76cb","#179299","#acb0be",
                   "#6c6f85","#de293e","#49af3d","#eea02d","#456eff","#fe85d8","#2d9fa8","#bcc0cc"]
    },
    // --- Catppuccin Frappe ---
    {
        id: "catppuccin-frappe", name: "Catppuccin Frappe", ghosttyName: "Catppuccin Frappe",
        background: "#303446", foreground: "#c6d0f5",
        cursorColor: "#f2d5cf", cursorText: "#303446",
        selectionBackground: "#626880", selectionForeground: "#c6d0f5",
        palette: ["#51576d","#e78284","#a6d189","#e5c890","#8caaee","#f4b8e4","#81c8be","#a5adce",
                   "#626880","#e67172","#8ec772","#d9ba73","#7b9ef0","#f2a4db","#5abfb5","#b5bfe2"]
    },
    // --- Catppuccin Macchiato ---
    {
        id: "catppuccin-macchiato", name: "Catppuccin Macchiato", ghosttyName: "Catppuccin Macchiato",
        background: "#24273a", foreground: "#cad3f5",
        cursorColor: "#f4dbd6", cursorText: "#24273a",
        selectionBackground: "#5b6078", selectionForeground: "#cad3f5",
        palette: ["#494d64","#ed8796","#a6da95","#eed49f","#8aadf4","#f5bde6","#8bd5ca","#a5adcb",
                   "#5b6078","#ec7486","#8ccf7f","#e1c682","#78a1f6","#f2a9dd","#63cbc0","#b8c0e0"]
    },
    // --- TokyoNight ---
    {
        id: "tokyonight", name: "TokyoNight", ghosttyName: "TokyoNight",
        background: "#1a1b26", foreground: "#c0caf5",
        cursorColor: "#c0caf5", cursorText: "#15161e",
        selectionBackground: "#33467c", selectionForeground: "#c0caf5",
        palette: ["#15161e","#f7768e","#9ece6a","#e0af68","#7aa2f7","#bb9af7","#7dcfff","#a9b1d6",
                   "#414868","#f7768e","#9ece6a","#e0af68","#7aa2f7","#bb9af7","#7dcfff","#c0caf5"]
    },
    // --- TokyoNight Storm ---
    {
        id: "tokyonight-storm", name: "TokyoNight Storm", ghosttyName: "TokyoNight Storm",
        background: "#24283b", foreground: "#c0caf5",
        cursorColor: "#c0caf5", cursorText: "#1d202f",
        selectionBackground: "#364a82", selectionForeground: "#c0caf5",
        palette: ["#1d202f","#f7768e","#9ece6a","#e0af68","#7aa2f7","#bb9af7","#7dcfff","#a9b1d6",
                   "#4e5575","#f7768e","#9ece6a","#e0af68","#7aa2f7","#bb9af7","#7dcfff","#c0caf5"]
    },
    // --- TokyoNight Moon ---
    {
        id: "tokyonight-moon", name: "TokyoNight Moon", ghosttyName: "TokyoNight Moon",
        background: "#222436", foreground: "#c8d3f5",
        cursorColor: "#c8d3f5", cursorText: "#222436",
        selectionBackground: "#2d3f76", selectionForeground: "#c8d3f5",
        palette: ["#1b1d2b","#ff757f","#c3e88d","#ffc777","#82aaff","#c099ff","#86e1fc","#828bb8",
                   "#444a73","#ff757f","#c3e88d","#ffc777","#82aaff","#c099ff","#86e1fc","#c8d3f5"]
    },
    // --- Gruvbox Dark ---
    {
        id: "gruvbox-dark", name: "Gruvbox Dark", ghosttyName: "Gruvbox Dark",
        background: "#282828", foreground: "#ebdbb2",
        cursorColor: "#ebdbb2", cursorText: "#282828",
        selectionBackground: "#665c54", selectionForeground: "#ebdbb2",
        palette: ["#282828","#cc241d","#98971a","#d79921","#458588","#b16286","#689d6a","#a89984",
                   "#928374","#fb4934","#b8bb26","#fabd2f","#83a598","#d3869b","#8ec07c","#ebdbb2"]
    },
    // --- Gruvbox Dark Hard ---
    {
        id: "gruvbox-dark-hard", name: "Gruvbox Dark Hard", ghosttyName: "Gruvbox Dark Hard",
        background: "#1d2021", foreground: "#ebdbb2",
        cursorColor: "#ebdbb2", cursorText: "#1d2021",
        selectionBackground: "#665c54", selectionForeground: "#ebdbb2",
        palette: ["#1d2021","#cc241d","#98971a","#d79921","#458588","#b16286","#689d6a","#a89984",
                   "#928374","#fb4934","#b8bb26","#fabd2f","#83a598","#d3869b","#8ec07c","#ebdbb2"]
    },
    // --- Rose Pine ---
    {
        id: "rose-pine", name: "Rose Pine", ghosttyName: "Rose Pine",
        background: "#191724", foreground: "#e0def4",
        cursorColor: "#e0def4", cursorText: "#191724",
        selectionBackground: "#403d52", selectionForeground: "#e0def4",
        palette: ["#26233a","#eb6f92","#31748f","#f6c177","#9ccfd8","#c4a7e7","#ebbcba","#e0def4",
                   "#6e6a86","#eb6f92","#31748f","#f6c177","#9ccfd8","#c4a7e7","#ebbcba","#e0def4"]
    },
    // --- Rose Pine Moon ---
    {
        id: "rose-pine-moon", name: "Rose Pine Moon", ghosttyName: "Rose Pine Moon",
        background: "#232136", foreground: "#e0def4",
        cursorColor: "#e0def4", cursorText: "#232136",
        selectionBackground: "#44415a", selectionForeground: "#e0def4",
        palette: ["#393552","#eb6f92","#3e8fb0","#f6c177","#9ccfd8","#c4a7e7","#ea9a97","#e0def4",
                   "#6e6a86","#eb6f92","#3e8fb0","#f6c177","#9ccfd8","#c4a7e7","#ea9a97","#e0def4"]
    },
    // --- Rose Pine Dawn ---
    {
        id: "rose-pine-dawn", name: "Rose Pine Dawn", ghosttyName: "Rose Pine Dawn",
        background: "#faf4ed", foreground: "#575279",
        cursorColor: "#575279", cursorText: "#faf4ed",
        selectionBackground: "#dfdad9", selectionForeground: "#575279",
        palette: ["#f2e9e1","#b4637a","#286983","#ea9d34","#56949f","#907aa9","#d7827e","#575279",
                   "#9893a5","#b4637a","#286983","#ea9d34","#56949f","#907aa9","#d7827e","#575279"]
    },
    // --- GitHub Dark ---
    {
        id: "github-dark", name: "GitHub Dark", ghosttyName: "GitHub Dark",
        background: "#101216", foreground: "#8b949e",
        cursorColor: "#c9d1d9", cursorText: "#101216",
        selectionBackground: "#3b5070", selectionForeground: "#ffffff",
        palette: ["#000000","#f78166","#56d364","#e3b341","#6ca4f8","#db61a2","#2b7489","#ffffff",
                   "#4d4d4d","#f78166","#56d364","#e3b341","#6ca4f8","#db61a2","#2b7489","#ffffff"]
    },
    // --- Kanagawa Dragon ---
    {
        id: "kanagawa-dragon", name: "Kanagawa Dragon", ghosttyName: "Kanagawa Dragon",
        background: "#181616", foreground: "#c8c093",
        cursorColor: "#c5c9c5", cursorText: "#1d202f",
        selectionBackground: "#223249", selectionForeground: "#c5c9c5",
        palette: ["#0d0c0c","#c4746e","#8a9a7b","#c4b28a","#8ba4b0","#a292a3","#8ea4a2","#c8c093",
                   "#a6a69c","#e46876","#87a987","#e6c384","#7fb4ca","#938aa9","#7aa89f","#c5c9c5"]
    },
    // --- Kanagawa Wave ---
    {
        id: "kanagawa-wave", name: "Kanagawa Wave", ghosttyName: "Kanagawa Wave",
        background: "#1f1f28", foreground: "#dcd7ba",
        cursorColor: "#c8c093", cursorText: "#1d202f",
        selectionBackground: "#2d4f67", selectionForeground: "#c8c093",
        palette: ["#090618","#c34043","#76946a","#c0a36e","#7e9cd8","#957fb8","#6a9589","#c8c093",
                   "#727169","#e82424","#98bb6c","#e6c384","#7fb4ca","#938aa9","#7aa89f","#dcd7ba"]
    },
    // --- One Dark (Atom) ---
    {
        id: "one-dark", name: "One Dark", ghosttyName: "Atom One Dark",
        background: "#21252b", foreground: "#abb2bf",
        cursorColor: "#abb2bf", cursorText: "#21252b",
        selectionBackground: "#323844", selectionForeground: "#abb2bf",
        palette: ["#21252b","#e06c75","#98c379","#e5c07b","#61afef","#c678dd","#56b6c2","#abb2bf",
                   "#767676","#e06c75","#98c379","#e5c07b","#61afef","#c678dd","#56b6c2","#abb2bf"]
    },
    // --- Solarized Darcula ---
    {
        id: "solarized-darcula", name: "Solarized Darcula", ghosttyName: "Solarized Darcula",
        background: "#3d3f41", foreground: "#d2d8d9",
        cursorColor: "#708284", cursorText: "#002831",
        selectionBackground: "#214283", selectionForeground: "#d2d8d9",
        palette: ["#25292a","#f24840","#629655","#b68800","#2075c7","#797fd4","#15968d","#d2d8d9",
                   "#65696a","#f24840","#629655","#b68800","#2075c7","#797fd4","#15968d","#d2d8d9"]
    },
    // --- Everforest Dark Hard ---
    {
        id: "everforest-dark", name: "Everforest Dark Hard", ghosttyName: "Everforest Dark Hard",
        background: "#1e2326", foreground: "#d3c6aa",
        cursorColor: "#e69875", cursorText: "#4c3743",
        selectionBackground: "#4c3743", selectionForeground: "#d3c6aa",
        palette: ["#7a8478","#e67e80","#a7c080","#dbbc7f","#7fbbb3","#d699b6","#83c092","#f2efdf",
                   "#a6b0a0","#f85552","#8da101","#dfa000","#3a94c5","#df69ba","#35a77c","#fffbef"]
    },
    // --- Ayu Mirage ---
    {
        id: "ayu-mirage", name: "Ayu Mirage", ghosttyName: "Ayu Mirage",
        background: "#1f2430", foreground: "#cccac2",
        cursorColor: "#ffcc66", cursorText: "#1f2430",
        selectionBackground: "#409fff", selectionForeground: "#1f2430",
        palette: ["#171b24","#ed8274","#87d96c","#facc6e","#6dcbfa","#dabafa","#90e1c6","#c7c7c7",
                   "#686868","#f28779","#d5ff80","#ffd173","#73d0ff","#dfbfff","#95e6cb","#ffffff"]
    },
    // --- Monokai Pro ---
    {
        id: "monokai-pro", name: "Monokai Pro", ghosttyName: "Monokai Pro",
        background: "#2d2a2e", foreground: "#fcfcfa",
        cursorColor: "#c1c0c0", cursorText: "#8e8d8d",
        selectionBackground: "#5b595c", selectionForeground: "#fcfcfa",
        palette: ["#2d2a2e","#ff6188","#a9dc76","#ffd866","#fc9867","#ab9df2","#78dce8","#fcfcfa",
                   "#727072","#ff6188","#a9dc76","#ffd866","#fc9867","#ab9df2","#78dce8","#fcfcfa"]
    },
    // --- Adwaita Dark ---
    {
        id: "adwaita-dark", name: "Adwaita Dark", ghosttyName: "Adwaita Dark",
        background: "#1d1d20", foreground: "#ffffff",
        cursorColor: "#ffffff", cursorText: "#1d1d20",
        selectionBackground: "#ffffff", selectionForeground: "#5e5c64",
        palette: ["#241f31","#c01c28","#2ec27e","#f5c211","#1e78e4","#9841bb","#0ab9dc","#c0bfbc",
                   "#5e5c64","#ed333b","#57e389","#f8e45c","#51a1ff","#c061cb","#4fd2fd","#f6f5f4"]
    },
    // --- Alabaster (light) ---
    {
        id: "alabaster", name: "Alabaster", ghosttyName: "Alabaster",
        background: "#f7f7f7", foreground: "#000000",
        cursorColor: "#007acc", cursorText: "#bfdbfe",
        selectionBackground: "#bfdbfe", selectionForeground: "#000000",
        palette: ["#000000","#aa3731","#448c27","#cb9000","#325cc0","#7a3e9d","#0083b2","#b7b7b7",
                   "#777777","#f05050","#60cb00","#f2af50","#007acc","#e64ce6","#00aacb","#f7f7f7"]
    }
];

function getTheme(id) {
    for (var i = 0; i < themes.length; i++) {
        if (themes[i].id === id) return themes[i];
    }
    return themes[0];
}

function getThemeOptions() {
    var opts = [];
    for (var i = 0; i < themes.length; i++) {
        opts.push({ label: themes[i].name, value: themes[i].id });
    }
    return opts;
}

var colorKeyMap = {
    "colorBackground": "background",
    "colorForeground": "foreground",
    "colorCursor": "cursorColor",
    "colorCursorText": "cursorText",
    "colorSelectionBg": "selectionBackground",
    "colorSelectionFg": "selectionForeground"
};

var colorLabels = {
    "colorBackground": "Background",
    "colorForeground": "Foreground",
    "colorCursor": "Cursor",
    "colorCursorText": "Cursor Text",
    "colorSelectionBg": "Selection BG",
    "colorSelectionFg": "Selection FG"
};

var colorKeys = [
    "colorBackground", "colorForeground", "colorCursor",
    "colorCursorText", "colorSelectionBg", "colorSelectionFg"
];
