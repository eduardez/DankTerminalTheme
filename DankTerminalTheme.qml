import QtQuick
import Quickshell
import Quickshell.Io
import qs.Common
import qs.Services
import qs.Widgets
import qs.Modules.Plugins

PluginComponent {
    id: root

    layerNamespacePlugin: "dankterminaltheme"

    property string currentTheme: pluginData.currentTheme || "nord"
    property string terminal: pluginData.terminal || "ghostty"
    property bool showAllThemes: pluginData.showAllThemes === true
    property int gridColumns: parseInt(pluginData.gridColumns) || 4
    property bool showArrows: pluginData.showArrows !== false
    property bool showTerminalPicker: false

    readonly property var terminals: [
        { id: "ghostty", name: "Ghostty", icon: "terminal" },
        { id: "kitty", name: "Kitty", icon: "cat" },
        { id: "alacritty", name: "Alacritty", icon: "speed" },
        { id: "wezterm", name: "WezTerm", icon: "layers" }
    ]

    readonly property string homePath: Quickshell.shellEnv("HOME") || ""

    readonly property string ghosttyMainConfig: {
        var customPath = pluginData.ghosttyConfigPath
        if (customPath && customPath.length > 0) return customPath
        return "$HOME/.config/ghostty/config"
    }

    readonly property string kittyConfigPath: "$HOME/.config/kitty/kitty.conf"
    readonly property string kittyThemePath: "$HOME/.config/kitty/current-theme.conf"
    readonly property string alacrittyConfigPath: "$HOME/.config/alacritty/alacritty.toml"
    readonly property string alacrittyThemePath: "$HOME/.config/alacritty/themes/"
    readonly property string alacrittyActivePath: "$HOME/.config/alacritty/active-theme.toml"
    readonly property string weztermConfigPath: "$HOME/.config/wezterm/wezterm.lua"

    readonly property var curatedThemes: [
        { id: "nord", name: "Nord", ghosttyName: "Nord", kittyName: "Nord", alacrittyName: "nord", weztermName: "nord", bg: "#2e3440", fg: "#d8dee9", accent: "#88c0d0" },
        { id: "catppuccin-mocha", name: "Catppuccin Mocha", ghosttyName: "Catppuccin Mocha", kittyName: "Catppuccin-Mocha", alacrittyName: "catppuccin_mocha", weztermName: "Catppuccin Mocha", bg: "#1e1e2e", fg: "#cdd6f4", accent: "#94e2d5" },
        { id: "catppuccin-macchiato", name: "Catppuccin Macchiato", ghosttyName: "Catppuccin Macchiato", kittyName: "Catppuccin-Macchiato", alacrittyName: "catppuccin_macchiato", weztermName: "Catppuccin Macchiato", bg: "#24273a", fg: "#cad3f5", accent: "#8bd5ca" },
        { id: "catppuccin-frappe", name: "Catppuccin Frappe", ghosttyName: "Catppuccin Frappe", kittyName: "Catppuccin-Frappe", alacrittyName: "catppuccin_frappe", weztermName: "Catppuccin Frappe", bg: "#303446", fg: "#c6d0f5", accent: "#81c8be" },
        { id: "tokyonight", name: "TokyoNight", ghosttyName: "TokyoNight", kittyName: "Tokyo Night", alacrittyName: "tokyo_night", weztermName: "Tokyo Night", bg: "#1a1b26", fg: "#c0caf5", accent: "#7dcfff" },
        { id: "tokyonight-storm", name: "TokyoNight Storm", ghosttyName: "TokyoNight Storm", kittyName: "Tokyo Night Storm", alacrittyName: "tokyo_night_storm", weztermName: "Tokyo Night Storm", bg: "#24283b", fg: "#c0caf5", accent: "#7dcfff" },
        { id: "tokyonight-moon", name: "TokyoNight Moon", ghosttyName: "TokyoNight Moon", kittyName: "Tokyo Night Moon", alacrittyName: "tokyo_night_storm", weztermName: "Tokyo Night Moon", bg: "#222436", fg: "#c8d3f5", accent: "#86e1fc" },
        { id: "dracula", name: "Dracula", ghosttyName: "Dracula", kittyName: "Dracula", alacrittyName: "dracula", weztermName: "Dracula", bg: "#282a36", fg: "#f8f8f2", accent: "#8be9fd" },
        { id: "gruvbox-dark", name: "Gruvbox Dark", ghosttyName: "Gruvbox Dark", kittyName: "Gruvbox Dark", alacrittyName: "gruvbox_dark", weztermName: "GruvboxDark", bg: "#282828", fg: "#ebdbb2", accent: "#689d6a" },
        { id: "gruvbox-dark-hard", name: "Gruvbox Dark Hard", ghosttyName: "Gruvbox Dark Hard", kittyName: "Gruvbox Dark Hard", alacrittyName: "gruvbox_dark", weztermName: "GruvboxDarkHard", bg: "#1d2021", fg: "#ebdbb2", accent: "#689d6a" },
        { id: "rose-pine", name: "Rose Pine", ghosttyName: "Rose Pine", kittyName: "Rosé Pine", alacrittyName: "rose_pine", weztermName: "rose-pine", bg: "#191724", fg: "#e0def4", accent: "#ebbcba" },
        { id: "rose-pine-moon", name: "Rose Pine Moon", ghosttyName: "Rose Pine Moon", kittyName: "Rosé Pine Moon", alacrittyName: "rose_pine_moon", weztermName: "rose-pine-moon", bg: "#232136", fg: "#e0def4", accent: "#ea9a97" },
        { id: "github-dark", name: "GitHub Dark", ghosttyName: "GitHub Dark", kittyName: "GitHub Dark", alacrittyName: "github_dark", weztermName: "GitHub Dark", bg: "#101216", fg: "#8b949e", accent: "#2b7489" },
        { id: "monokai-pro", name: "Monokai Pro", ghosttyName: "Monokai Pro", kittyName: "Monokai Classic", alacrittyName: "monokai_pro", weztermName: "Monokai Pro (Gogh)", bg: "#2d2a2e", fg: "#fcfcfa", accent: "#78dce8" },
        { id: "kanagawa-wave", name: "Kanagawa Wave", ghosttyName: "Kanagawa Wave", kittyName: "Kanagawa", alacrittyName: "kanagawa_wave", weztermName: "Kanagawa (Gogh)", bg: "#1f1f28", fg: "#dcd7ba", accent: "#6a9589" },
        { id: "kanagawa-dragon", name: "Kanagawa Dragon", ghosttyName: "Kanagawa Dragon", kittyName: "Kanagawa_dragon", alacrittyName: "kanagawa_dragon", weztermName: "Kanagawa Dragon (Gogh)", bg: "#181616", fg: "#c5c9c5", accent: "#8ea4a2" },
        { id: "ayu-mirage", name: "Ayu Mirage", ghosttyName: "Ayu Mirage", kittyName: "Ayu Mirage", alacrittyName: "ayu_mirage", weztermName: "Ayu Mirage", bg: "#1f2430", fg: "#cccac2", accent: "#90e1c6" },
        { id: "one-dark", name: "One Dark", ghosttyName: "Atom One Dark", kittyName: "One Dark", alacrittyName: "one_dark", weztermName: "One Dark (Gogh)", bg: "#21252b", fg: "#abb2bf", accent: "#56b6c2" },
        { id: "everforest-dark-hard", name: "Everforest Dark Hard", ghosttyName: "Everforest Dark Hard", kittyName: "Everforest Dark Hard", alacrittyName: "everforest_dark_hard", weztermName: "Everforest Dark Hard (Gogh)", bg: "#1e2326", fg: "#d3c6aa", accent: "#83c092" },
        { id: "catppuccin-latte", name: "Catppuccin Latte", ghosttyName: "Catppuccin Latte", kittyName: "Catppuccin-Latte", alacrittyName: "catppuccin_latte", weztermName: "Catppuccin Latte", bg: "#eff1f5", fg: "#4c4f69", accent: "#179299" },
        { id: "rose-pine-dawn", name: "Rose Pine Dawn", ghosttyName: "Rose Pine Dawn", kittyName: "Rosé Pine Dawn", alacrittyName: "rose_pine_dawn", weztermName: "rose-pine-dawn", bg: "#faf4ed", fg: "#575279", accent: "#d7827e" }
    ]

    readonly property var extraThemes: [
        { id: "gruvbox-light", name: "Gruvbox Light", ghosttyName: "Gruvbox Light", kittyName: "Gruvbox Light", alacrittyName: "gruvbox_light", weztermName: "GruvboxLight", bg: "#fbf1c7", fg: "#3c3836", accent: "#689d6a" },
        { id: "github-dark-default", name: "GitHub Dark Default", ghosttyName: "GitHub Dark Default", kittyName: "GitHub Dark", alacrittyName: "github_dark_default", weztermName: "GitHub Dark", bg: "#0d1117", fg: "#e6edf3", accent: "#39c5cf" },
        { id: "github-light-default", name: "GitHub Light Default", ghosttyName: "GitHub Light Default", kittyName: "GitHub Light", alacrittyName: "github_light_default", weztermName: "GitHub Dark", bg: "#ffffff", fg: "#1f2328", accent: "#1b7c83" },
        { id: "monokai-classic", name: "Monokai Classic", ghosttyName: "Monokai Classic", kittyName: "Monokai Classic", alacrittyName: "monokai", weztermName: "Monokai Pro (Gogh)", bg: "#272822", fg: "#fdfff1", accent: "#66d9ef" },
        { id: "ayu-light", name: "Ayu Light", ghosttyName: "Ayu Light", kittyName: "Ayu Light", alacrittyName: "ayu_light", weztermName: "Ayu Light (Gogh)", bg: "#f8f9fa", fg: "#5c6166", accent: "#46ba94" },
        { id: "adwaita-dark", name: "Adwaita Dark", ghosttyName: "Adwaita Dark", kittyName: "Adwaita dark", alacrittyName: "adwaita_dark", weztermName: "Adwaita Dark", bg: "#1d1d20", fg: "#ffffff", accent: "#0ab9dc" },
        { id: "carbonfox", name: "Carbonfox", ghosttyName: "Carbonfox", kittyName: "Carbonfox", alacrittyName: "carbonfox", weztermName: "carbonfox", bg: "#161616", fg: "#f2f4f8", accent: "#33b1ff" },
        { id: "nightfox", name: "Nightfox", ghosttyName: "Nightfox", kittyName: "Nightfox", alacrittyName: "nightfox", weztermName: "nightfox", bg: "#192330", fg: "#cdcecf", accent: "#63cdcf" },
        { id: "dayfox", name: "Dayfox", ghosttyName: "Dayfox", kittyName: "Dayfox", alacrittyName: "dayfox", weztermName: "dayfox", bg: "#f6f2ee", fg: "#3d2b5a", accent: "#287980" },
        { id: "dawnfox", name: "Dawnfox", ghosttyName: "Dawnfox", kittyName: "Dawnfox", alacrittyName: "dawnfox", weztermName: "dawnfox", bg: "#faf4ed", fg: "#575279", accent: "#56949f" },
        { id: "nordfox", name: "Nordfox", ghosttyName: "Nordfox", kittyName: "Nordfox", alacrittyName: "nordfox", weztermName: "nordfox", bg: "#2e3440", fg: "#cdcecf", accent: "#88c0d0" },
        { id: "sonokai", name: "Sonokai", ghosttyName: "Sonokai", kittyName: "Sonokai Sushia", alacrittyName: "sonokai", weztermName: "Sonokai (Gogh)", bg: "#2c2e34", fg: "#e2e2e3", accent: "#f39660" },
        { id: "iceberg-dark", name: "Iceberg Dark", ghosttyName: "Iceberg Dark", kittyName: "Iceberg Dark", alacrittyName: "iceberg", weztermName: "iceberg-dark", bg: "#161821", fg: "#c6c8d1", accent: "#89b8c2" },
        { id: "moonfly", name: "Moonfly", ghosttyName: "Moonfly", kittyName: "Moonfly", alacrittyName: "moonfly", weztermName: "Moonfly (Gogh)", bg: "#080808", fg: "#bdbdbd", accent: "#79dac8" },
        { id: "desert", name: "Desert", ghosttyName: "Desert", kittyName: "Desert", alacrittyName: "desert", weztermName: "Desert", bg: "#333333", fg: "#ffffff", accent: "#ffa0a0" },
        { id: "zenburn", name: "Zenburn", ghosttyName: "Zenburn", kittyName: "Zenburn", alacrittyName: "zenburn", weztermName: "Zenburn", bg: "#3f3f3f", fg: "#dcdccc", accent: "#8cd0d3" },
        { id: "breeze", name: "Breeze", ghosttyName: "Breeze", kittyName: "Breeze", alacrittyName: "breeze", weztermName: "Breeze", bg: "#31363b", fg: "#eff0f1", accent: "#1abc9c" },
        { id: "challenger-deep", name: "Challenger Deep", ghosttyName: "Challenger Deep", kittyName: "Challenger Deep", alacrittyName: "challenger_deep", weztermName: "ChallengerDeep", bg: "#1e1c31", fg: "#cbe1e7", accent: "#63f2f1" },
        { id: "horizon", name: "Horizon", ghosttyName: "Horizon", kittyName: "Horizon", alacrittyName: "horizon_dark", weztermName: "Horizon Dark (Gogh)", bg: "#1c1e26", fg: "#d5d8da", accent: "#59e1e3" },
        { id: "doom-one", name: "Doom One", ghosttyName: "Doom One", kittyName: "Doom One", alacrittyName: "doom_one", weztermName: "DoomOne", bg: "#282c34", fg: "#bbc2cf", accent: "#51afef" },
        { id: "alabaster", name: "Alabaster", ghosttyName: "Alabaster", kittyName: "Alabaster", alacrittyName: "alabaster", weztermName: "Alabaster", bg: "#f7f7f7", fg: "#000000", accent: "#0083b2" },
        { id: "one-half-light", name: "One Half Light", ghosttyName: "One Half Light", kittyName: "One Half Light", alacrittyName: "one_half_light", weztermName: "OneHalfLight", bg: "#fafafa", fg: "#383a42", accent: "#0997b3" },
        { id: "one-half-dark", name: "One Half Dark", ghosttyName: "One Half Dark", kittyName: "One Half Dark", alacrittyName: "one_half_dark", weztermName: "OneHalfDark", bg: "#282c34", fg: "#dcdfe4", accent: "#56b6c2" },
        { id: "material-dark", name: "Material Dark", ghosttyName: "Material Dark", kittyName: "Material Dark", alacrittyName: "material_theme", weztermName: "MaterialDark", bg: "#232322", fg: "#e5e5e5", accent: "#0e717c" },
        { id: "material-darker", name: "Material Darker", ghosttyName: "Material Darker", kittyName: "Material Darker", alacrittyName: "material_theme", weztermName: "MaterialDarker", bg: "#212121", fg: "#eeffff", accent: "#89ddff" },
        { id: "solarized-dark-hc", name: "Solarized Dark HC", ghosttyName: "Solarized Dark Higher Contrast", kittyName: "Solarized Dark Higher Contrast", alacrittyName: "solarized_dark", weztermName: "Solarized Dark Higher Contrast", bg: "#001e27", fg: "#9cc2c3", accent: "#259286" },
        { id: "atom-one-light", name: "Atom One Light", ghosttyName: "Atom One Light", kittyName: "Atom One Light", alacrittyName: "one_light", weztermName: "AtomOneLight", bg: "#f9f9f9", fg: "#2a2c33", accent: "#3f953a" },
        { id: "afterglow", name: "Afterglow", ghosttyName: "Afterglow", kittyName: "Afterglow", alacrittyName: "afterglow", weztermName: "Afterglow", bg: "#212121", fg: "#d0d0d0", accent: "#7dd6cf" },
        { id: "cyberpunk", name: "Cyberpunk", ghosttyName: "Cyberpunk", kittyName: "Cyberpunk", alacrittyName: "cyber_punk_neon", weztermName: "cyberpunk", bg: "#332a57", fg: "#e5e5e5", accent: "#86cbfe" },
        { id: "bluloco-dark", name: "Bluloco Dark", ghosttyName: "Bluloco Dark", kittyName: "Bluloco Dark", alacrittyName: "bluloco_dark", weztermName: "BlulocoDark", bg: "#282c34", fg: "#b9c0cb", accent: "#4483aa" },
        { id: "brogrammer", name: "Brogrammer", ghosttyName: "Brogrammer", kittyName: "Brogrammer", alacrittyName: "brogrammer", weztermName: "Brogrammer", bg: "#131313", fg: "#d6dbe5", accent: "#1081d6" },
        { id: "forest-blue", name: "Forest Blue", ghosttyName: "Forest Blue", kittyName: "Forest Blue", alacrittyName: "forest_blue", weztermName: "ForestBlue", bg: "#051519", fg: "#e2d8cd", accent: "#31658c" },
        { id: "ocean", name: "Ocean", ghosttyName: "Ocean", kittyName: "Ocean", alacrittyName: "ocean", weztermName: "Ocean", bg: "#224fbc", fg: "#ffffff", accent: "#00a6b2" },
        { id: "dark-plus", name: "Dark+", ghosttyName: "Dark+", kittyName: "Dark+", alacrittyName: "dark_plus", weztermName: "Dark+", bg: "#1e1e1e", fg: "#cccccc", accent: "#11a8cd" },
        { id: "dark-modern", name: "Dark Modern", ghosttyName: "Dark Modern", kittyName: "Dark Modern", alacrittyName: "dark_modern", weztermName: "Dark Modern", bg: "#1f1f1f", fg: "#cccccc", accent: "#1db4d6" },
        { id: "earthsong", name: "Earthsong", ghosttyName: "Earthsong", kittyName: "Earthsong", alacrittyName: "earthsong", weztermName: "Earthsong", bg: "#292520", fg: "#e5c7a9", accent: "#509552" },
        { id: "embers-dark", name: "Embers Dark", ghosttyName: "Embers Dark", kittyName: "Embers Dark", alacrittyName: "embers_dark", weztermName: "Embers (base16)", bg: "#16130f", fg: "#a39a90", accent: "#576d82" },
        { id: "flexoki-dark", name: "Flexoki Dark", ghosttyName: "Flexoki Dark", kittyName: "Flexoki (Dark)", alacrittyName: "flexoki", weztermName: "flexoki-dark", bg: "#100f0f", fg: "#cecdc3", accent: "#3aa99f" },
        { id: "gruber-darker", name: "Gruber Darker", ghosttyName: "Gruber Darker", kittyName: "Gruber Darker", alacrittyName: "gruber_darker", weztermName: "Gruber (base16)", bg: "#181818", fg: "#e4e4e4", accent: "#90aa9e" },
        { id: "espresso", name: "Espresso", ghosttyName: "Espresso", kittyName: "Espresso", alacrittyName: "espresso", weztermName: "Espresso", bg: "#323232", fg: "#ffffff", accent: "#bed6ff" },
        { id: "hardcore", name: "Hardcore", ghosttyName: "Hardcore", kittyName: "Hardcore", alacrittyName: "hardcore", weztermName: "Hardcore", bg: "#121212", fg: "#a0a0a0", accent: "#5e7175" },
        { id: "iterm2-default", name: "iTerm2 Default", ghosttyName: "iTerm2 Default", kittyName: "iTerm2 Default", alacrittyName: "iterm", weztermName: "iTerm2 Default", bg: "#000000", fg: "#ffffff", accent: "#00c5c7" },
        { id: "lovelace", name: "Lovelace", ghosttyName: "Lovelace", kittyName: "Lovelace", alacrittyName: "thelovelace", weztermName: "lovelace", bg: "#1d1f28", fg: "#fdfdfd", accent: "#79e6f3" },
        { id: "mariana", name: "Mariana", ghosttyName: "Mariana", kittyName: "Mariana", alacrittyName: "Mariana", weztermName: "Mariana", bg: "#343d46", fg: "#d8dee9", accent: "#5fb4b4" },
        { id: "mellow", name: "Mellow", ghosttyName: "Mellow", kittyName: "Mellow", alacrittyName: "mellow", weztermName: "Mellow", bg: "#161617", fg: "#c9c7cd", accent: "#ea83a5" },
        { id: "molokai", name: "Molokai", ghosttyName: "Molokai", kittyName: "Molokai", alacrittyName: "monokai", weztermName: "Molokai", bg: "#121212", fg: "#bbbbbb", accent: "#43a8d0" },
        { id: "snazzy", name: "Snazzy", ghosttyName: "Snazzy", kittyName: "Snazzy", alacrittyName: "snazzy", weztermName: "Snazzy", bg: "#1e1f29", fg: "#ebece6", accent: "#8be9fe" },
        { id: "spacedust", name: "Spacedust", ghosttyName: "Spacedust", kittyName: "Spacedust", alacrittyName: "spacedust", weztermName: "Spacedust", bg: "#0a1e24", fg: "#ecf0c1", accent: "#06afc7" },
        { id: "tinacious-design-dark", name: "Tinacious Dark", ghosttyName: "Tinacious Design Dark", kittyName: "Tinacious Design Dark", alacrittyName: "tinacious_design_dark", weztermName: "Tinacious Design (Dark)", bg: "#1d1d26", fg: "#cbcbf0", accent: "#00ceca" },
        { id: "tinacious-design-light", name: "Tinacious Light", ghosttyName: "Tinacious Design Light", kittyName: "Tinacious Design Light", alacrittyName: "tinacious_design_light", weztermName: "Tinacious Design (Light)", bg: "#f8f8ff", fg: "#1d1d26", accent: "#00ceca" },
        { id: "primary", name: "Primary", ghosttyName: "Primary", kittyName: "Primary", alacrittyName: "primary", weztermName: "primary", bg: "#ffffff", fg: "#000000", accent: "#4285f4" },
        { id: "wild-cherry", name: "Wild Cherry", ghosttyName: "Wild Cherry", kittyName: "Wild Cherry", alacrittyName: "wild_cherry", weztermName: "Wild Cherry (Gogh)", bg: "#1f1726", fg: "#dafaff", accent: "#c1b8b7" },
        { id: "firewatch", name: "Firewatch", ghosttyName: "Firewatch", kittyName: "Firewatch", alacrittyName: "firewatch", weztermName: "Firewatch", bg: "#1e2027", fg: "#9ba2b2", accent: "#44a8b6" },
        { id: "aura", name: "Aura", ghosttyName: "Aura", kittyName: "Aura", alacrittyName: "aura", weztermName: "Aura (Gogh)", bg: "#15141b", fg: "#edecee", accent: "#61ffca" },
        { id: "atelier-sulphurpool", name: "Atelier Sulphurpool", ghosttyName: "Atelier Sulphurpool", kittyName: "Atelier Sulphurpool Dark", alacrittyName: "atelier_sulphurpool", weztermName: "Atelier Sulphurpool (base16)", bg: "#202746", fg: "#979db4", accent: "#22a2c9" },
        { id: "belafonte-night", name: "Belafonte Night", ghosttyName: "Belafonte Night", kittyName: "Belafonte Night", alacrittyName: "belafonte_night", weztermName: "Belafonte Night", bg: "#20111b", fg: "#968c83", accent: "#989a9c" },
        { id: "birds-of-paradise", name: "Birds Of Paradise", ghosttyName: "Birds Of Paradise", kittyName: "Birds Of Paradise", alacrittyName: "birds_of_paradise", weztermName: "Birds Of Paradise", bg: "#2a1f1d", fg: "#e0dbb7", accent: "#74a6ad" },
        { id: "cobalt2", name: "Cobalt2", ghosttyName: "Cobalt2", kittyName: "Cobalt 2", alacrittyName: "cobalt2", weztermName: "Cobalt2", bg: "#132738", fg: "#ffffff", accent: "#00bbbb" },
        { id: "broadcast", name: "Broadcast", ghosttyName: "Broadcast", kittyName: "Broadcast", alacrittyName: "broadcast", weztermName: "Broadcast", bg: "#2b2b2b", fg: "#e6e1dc", accent: "#6e9cbe" },
        { id: "cutie-pro", name: "Cutie Pro", ghosttyName: "Cutie Pro", kittyName: "Cutie Pro", alacrittyName: "cutie_pro", weztermName: "Cutie Pro", bg: "#181818", fg: "#d5d0c9", accent: "#37cb8a" },
        { id: "dimmed-monokai", name: "Dimmed Monokai", ghosttyName: "Dimmed Monokai", kittyName: "Dimmed Monokai", alacrittyName: "dimmed_monokai", weztermName: "Dimmed Monokai", bg: "#1f1f1f", fg: "#b9bcba", accent: "#578fa4" },
        { id: "electron-highlighter", name: "Electron Highlighter", ghosttyName: "Electron Highlighter", kittyName: "Electron Highlighter", alacrittyName: "electron_highlighter", weztermName: "Electron Highlighter", bg: "#23283d", fg: "#a5b6d4", accent: "#00fdff" },
        { id: "fahrenheit", name: "Fahrenheit", ghosttyName: "Fahrenheit", kittyName: "Fahrenheit", alacrittyName: "fahrenheit", weztermName: "Fahrenheit", bg: "#000000", fg: "#ffffce", accent: "#979797" },
        { id: "galaxy", name: "Galaxy", ghosttyName: "Galaxy", kittyName: "Galaxy", alacrittyName: "galaxy", weztermName: "Galaxy", bg: "#1d2837", fg: "#ffffff", accent: "#1f9ee7" },
        { id: "glacier", name: "Glacier", ghosttyName: "Glacier", kittyName: "Glacier", alacrittyName: "glacier", weztermName: "Glacier", bg: "#0c1115", fg: "#ffffff", accent: "#778397" },
        { id: "shades-of-purple", name: "Shades Of Purple", ghosttyName: "Shades Of Purple", kittyName: "Shades of Purple", alacrittyName: "shades_of_purple", weztermName: "Shades Of Purple", bg: "#1e1d40", fg: "#ffffff", accent: "#00c5c7" },
        { id: "soft-server", name: "Soft Server", ghosttyName: "Soft Server", kittyName: "Soft Server", alacrittyName: "soft_server", weztermName: "Soft Server", bg: "#242626", fg: "#99a3a2", accent: "#6ba58f" },
        { id: "vibrant-ink", name: "Vibrant Ink", ghosttyName: "Vibrant Ink", kittyName: "Vibrant Ink", alacrittyName: "vibrant_ink", weztermName: "Vibrant Ink", bg: "#000000", fg: "#ffffff", accent: "#44b4cc" },
        { id: "adventure-time", name: "Adventure Time", ghosttyName: "Adventure Time", kittyName: "Adventure Time", alacrittyName: "adventure_time", weztermName: "Adventure Time", bg: "#1f1d45", fg: "#f8dcc0", accent: "#70a598" },
        { id: "aizen-dark", name: "Aizen Dark", ghosttyName: "Aizen Dark", kittyName: "Aizen Dark", alacrittyName: "aizen_dark", weztermName: "Aizen Dark", bg: "#1a1a1a", fg: "#d0d6f0", accent: "#90dcd0" },
        { id: "andromeda", name: "Andromeda", ghosttyName: "Andromeda", kittyName: "Andromeda", alacrittyName: "andromeda", weztermName: "Andromeda", bg: "#262a33", fg: "#e5e5e5", accent: "#0fa8cd" },
        { id: "apple-classic", name: "Apple Classic", ghosttyName: "Apple Classic", kittyName: "Apple Classic", alacrittyName: "apple_classic", weztermName: "Apple Classic", bg: "#2c2b2b", fg: "#d5a200", accent: "#00c5c7" },
        { id: "bright-lights", name: "Bright Lights", ghosttyName: "Bright Lights", kittyName: "Bright Lights", alacrittyName: "bright_lights", weztermName: "Bright Lights", bg: "#191919", fg: "#b3c9d7", accent: "#6cbfb5" },
        { id: "banana-blueberry", name: "Banana Blueberry", ghosttyName: "Banana Blueberry", kittyName: "Banana Blueberry", alacrittyName: "banana_blueberry", weztermName: "Banana Blueberry", bg: "#191323", fg: "#cccccc", accent: "#56b6c2" },
        { id: "3024-night", name: "3024 Night", ghosttyName: "3024 Night", kittyName: "3024 Night", alacrittyName: "3024_night", weztermName: "3024 Night", bg: "#090300", fg: "#a5a2a2", accent: "#b5e4f4" },
        { id: "aardvark-blue", name: "Aardvark Blue", ghosttyName: "Aardvark Blue", kittyName: "Aardvark Blue", alacrittyName: "aardvark_blue", weztermName: "Aardvark Blue", bg: "#102040", fg: "#dddddd", accent: "#008eb0" }
    ]

    readonly property var allThemes: curatedThemes.concat(extraThemes)

    function getTerminalName(theme, term) {
        if (term === "ghostty") return theme.ghosttyName
        if (term === "kitty") return theme.kittyName || theme.ghosttyName
        if (term === "alacritty") return theme.alacrittyName || theme.id
        if (term === "wezterm") return theme.weztermName || theme.ghosttyName
        return theme.ghosttyName
    }

    function isThemeAvailable(theme, term) {
        if (term === "ghostty") return true
        if (term === "kitty") return theme.kittyName !== undefined && theme.kittyName !== null
        if (term === "alacritty") return theme.alacrittyName !== undefined && theme.alacrittyName !== null
        if (term === "wezterm") return theme.weztermName !== undefined && theme.weztermName !== null
        return true
    }

    readonly property var filteredThemes: {
        if (terminal === "ghostty") return showAllThemes ? allThemes : curatedThemes
        var list = showAllThemes ? allThemes : curatedThemes
        var filtered = []
        for (var i = 0; i < list.length; i++) {
            if (isThemeAvailable(list[i], terminal)) filtered.push(list[i])
        }
        return filtered
    }

    readonly property var themes: filteredThemes

    readonly property var themeMap: {
        var map = {}
        for (var i = 0; i < allThemes.length; i++) map[allThemes[i].id] = allThemes[i]
        return map
    }

    property var theme: themeMap[currentTheme] || curatedThemes[0]

    function prevTheme() {
        var idx = -1
        for (var i = 0; i < themes.length; i++) { if (themes[i].id === currentTheme) { idx = i; break } }
        var newIdx = idx > 0 ? idx - 1 : themes.length - 1
        applyTheme(themes[newIdx].id)
    }

    function nextTheme() {
        var idx = -1
        for (var i = 0; i < themes.length; i++) { if (themes[i].id === currentTheme) { idx = i; break } }
        var newIdx = idx < themes.length - 1 ? idx + 1 : 0
        applyTheme(themes[newIdx].id)
    }

    function applyThemeGhostty(ghosttyName) {
        var bashCmd =
            "sed -i -e '/^theme = /d' -e '/^config-file = themes\\//d' \"" + ghosttyMainConfig + "\"; " +
            "echo 'theme = " + ghosttyName + "' >> \"" + ghosttyMainConfig + "\""
        Quickshell.execDetached(["bash", "-c", bashCmd])
        Quickshell.execDetached(["bash", "-c", "pkill -SIGUSR2 ghostty 2>/dev/null || true"])
    }

    function applyThemeKitty(kittyName) {
        var tmpFile = "/tmp/dank-kitty-theme.conf"
        var cmd =
            "kitty +kitten themes --dump-theme '" + kittyName + "' > " + tmpFile + " 2>/dev/null && " +
            "cp " + tmpFile + " " + kittyThemePath + " && " +
            "grep -q 'include.*current-theme\\.conf' \"" + kittyConfigPath + "\" 2>/dev/null || " +
            "(mkdir -p ~/.config/kitty && echo 'include current-theme.conf' >> \"" + kittyConfigPath + "\"); " +
            "pkill -SIGUSR1 kitty 2>/dev/null || true"
        Quickshell.execDetached(["bash", "-c", cmd])
    }

    function applyThemeAlacritty(alacrittyName) {
        var themeSrc = alacrittyThemePath + "themes/" + alacrittyName + ".toml"
        var cmd =
            "mkdir -p ~/.config/alacritty/themes/themes && " +
            "if [ ! -f " + themeSrc + " ] || head -1 " + themeSrc + " | grep -q '404'; then " +
            "  curl -sL 'https://raw.githubusercontent.com/alacritty/alacritty-theme/master/themes/" + alacrittyName + ".toml' -o " + themeSrc + " 2>/dev/null; " +
            "fi; " +
            "if [ -f " + themeSrc + " ] && ! head -1 " + themeSrc + " | grep -q '404'; then " +
            "  ln -sf " + themeSrc + " " + alacrittyActivePath + "; " +
            "fi; " +
            "if [ ! -f " + alacrittyConfigPath + " ]; then " +
            "  echo '[general]' > " + alacrittyConfigPath + "; " +
            "  echo 'import = [ \\\"~/.config/alacritty/active-theme.toml\\\" ]' >> " + alacrittyConfigPath + "; " +
            "elif ! grep -q 'active-theme' " + alacrittyConfigPath + " 2>/dev/null; then " +
            "  echo 'import = [ \\\"~/.config/alacritty/active-theme.toml\\\" ]' >> " + alacrittyConfigPath + "; " +
            "fi; " +
            "touch " + alacrittyConfigPath
        Quickshell.execDetached(["bash", "-c", cmd])
    }

    function applyThemeWezterm(weztermName) {
        var cmd =
            "if [ ! -f \"" + weztermConfigPath + "\" ]; then " +
            "  mkdir -p $(dirname \"" + weztermConfigPath + "\") && " +
            "  echo 'local wezterm = require \"wezterm\"' > \"" + weztermConfigPath + "\" && " +
            "  echo 'local config = wezterm.config_builder()' >> \"" + weztermConfigPath + "\" && " +
            "  echo 'config.color_scheme = \\\"" + weztermName + "\\\"' >> \"" + weztermConfigPath + "\" && " +
            "  echo 'return config' >> \"" + weztermConfigPath + "\"; " +
            "elif grep -q 'color_scheme' \"" + weztermConfigPath + "\" 2>/dev/null; then " +
            "  sed -i 's/color_scheme\\s*=.*/color_scheme = \\\"" + weztermName + "\\\"/' \"" + weztermConfigPath + "\"; " +
            "else " +
            "  sed -i '/return config/i config.color_scheme = \\\"" + weztermName + "\\\"' \"" + weztermConfigPath + "\"; " +
            "fi"
        Quickshell.execDetached(["bash", "-c", cmd])
    }

    function applyTheme(themeId) {
        var t = themeMap[themeId]
        if (!t) return

        var name = getTerminalName(t, terminal)

        if (terminal === "ghostty") applyThemeGhostty(name)
        else if (terminal === "kitty") applyThemeKitty(name)
        else if (terminal === "alacritty") applyThemeAlacritty(name)
        else if (terminal === "wezterm") applyThemeWezterm(name)

        currentTheme = themeId
        pluginData.currentTheme = themeId
    }

    function switchTerminal(termId) {
        terminal = termId
        pluginData.terminal = termId
        showTerminalPicker = false
        if (themeMap[currentTheme] && !isThemeAvailable(themeMap[currentTheme], termId)) {
            var first = curatedThemes[0]
            if (isThemeAvailable(first, termId)) {
                currentTheme = first.id
                pluginData.currentTheme = first.id
            }
        }
    }

    function getCurrentTerminalName() {
        for (var i = 0; i < terminals.length; i++) {
            if (terminals[i].id === terminal) return terminals[i].name
        }
        return "Ghostty"
    }

    horizontalBarPill: Component {
        Row {
            spacing: Theme.spacingXS
            DankIcon { name: "palette"; size: root.iconSize; color: Theme.primary; anchors.verticalCenter: parent.verticalCenter }
            StyledText { text: root.theme.name; font.pixelSize: Theme.fontSizeSmall; color: Theme.surfaceText; anchors.verticalCenter: parent.verticalCenter }
            DankIcon { name: "chevron_down"; size: 10; color: Theme.surfaceVariantText; anchors.verticalCenter: parent.verticalCenter }
        }
    }

    verticalBarPill: Component {
        Column {
            spacing: Theme.spacingXS
            DankIcon { name: "palette"; size: root.iconSize; color: Theme.primary; anchors.horizontalCenter: parent.horizontalCenter }
            StyledText { text: root.theme.name; font.pixelSize: Theme.fontSizeSmall; color: Theme.surfaceText; anchors.horizontalCenter: parent.horizontalCenter }
            DankIcon { name: "chevron_down"; size: 10; color: Theme.surfaceVariantText; anchors.horizontalCenter: parent.horizontalCenter }
        }
    }

    popoutContent: Component {
        PopoutComponent {
            id: popout
            showCloseButton: false

            property real cw: root.popoutWidth - Theme.spacingL

            Column {
                id: mainCol
                spacing: Theme.spacingS
                width: popout.cw
                clip: false

                Rectangle {
                    width: popout.cw
                    height: 48
                    radius: Theme.cornerRadius
                    color: root.theme.bg
                    border.width: 1
                    border.color: Theme.outline

                    Row {
                        anchors.centerIn: parent
                        spacing: 8
                        Rectangle { width: 14; height: 14; radius: 7; color: root.theme.fg; anchors.verticalCenter: parent.verticalCenter }
                        Rectangle { width: 14; height: 14; radius: 7; color: root.theme.accent; anchors.verticalCenter: parent.verticalCenter }
                        StyledText {
                            text: root.theme.name
                            font.pixelSize: 14
                            font.weight: Font.Bold
                            color: root.theme.fg
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                }

                GridView {
                    id: gridView
                    width: popout.cw
                    height: root.showAllThemes ? 280 : 180
                    cellWidth: popout.cw / root.gridColumns
                    cellHeight: 52
                    model: root.themes
                    clip: true
                    flow: GridView.LeftToRight

                    delegate: Item {
                        width: gridView.cellWidth
                        height: gridView.cellHeight

                        Rectangle {
                            anchors.fill: parent
                            anchors.margins: 3
                            radius: 8
                            color: modelData.bg
                            border.width: modelData.id === root.currentTheme ? 2 : 1
                            border.color: modelData.id === root.currentTheme ? Theme.primary : Theme.outline

                            Row {
                                anchors.centerIn: parent
                                spacing: 3
                                Rectangle { width: 10; height: 10; radius: 5; color: modelData.fg }
                                Rectangle { width: 10; height: 10; radius: 5; color: modelData.accent }
                            }

                            Rectangle {
                                visible: modelData.id === root.currentTheme
                                width: 8; height: 8; radius: 4
                                color: Theme.primary
                                anchors.top: parent.top; anchors.topMargin: 3
                                anchors.right: parent.right; anchors.rightMargin: 3
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: root.applyTheme(modelData.id)
                            }
                        }
                    }
                }

                Row {
                    id: arrowRow
                    spacing: 4
                    width: popout.cw
                    height: 36
                    visible: root.showArrows
                    Rectangle {
                        width: 36
                        height: 36
                        radius: 8
                        color: prevArea.containsMouse ? Theme.surfaceContainerHigh : "transparent"
                        DankIcon { name: "chevron_left"; size: 18; color: Theme.surfaceText; anchors.centerIn: parent }
                        MouseArea { id: prevArea; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: root.prevTheme() }
                    }

                    Rectangle {
                        id: dropdownBtn
                        width: popout.cw - 80
                        height: 36
                        radius: 8
                        color: dropdownArea.containsMouse ? Theme.surfaceContainerHigh : Theme.surfaceContainer

                        Row {
                            anchors.centerIn: parent
                            spacing: 4
                            StyledText {
                                text: root.getCurrentTerminalName()
                                font.pixelSize: 12
                                font.weight: Font.Bold
                                color: Theme.surfaceText
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            DankIcon {
                                name: root.showTerminalPicker ? "chevron_up" : "chevron_down"
                                size: 12
                                color: Theme.surfaceText
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        MouseArea {
                            id: dropdownArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.showTerminalPicker = !root.showTerminalPicker
                        }
                    }

                    Rectangle {
                        width: 36
                        height: 36
                        radius: 8
                        color: nextArea.containsMouse ? Theme.surfaceContainerHigh : "transparent"
                        DankIcon { name: "chevron_right"; size: 18; color: Theme.surfaceText; anchors.centerIn: parent }
                        MouseArea { id: nextArea; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: root.nextTheme() }
                    }
                }

                Rectangle {
                    id: dropdownPopup
                    visible: root.showTerminalPicker
                    width: dropdownBtn.width
                    height: dropdownCol.height + 8
                    radius: 8
                    z: 999
                    color: Theme.surfaceContainer
                    anchors.left: parent.left
                    anchors.leftMargin: 40

                    Column {
                        id: dropdownCol
                        anchors.margins: 4
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        spacing: 2

                        Repeater {
                            model: root.terminals

                            Rectangle {
                                width: dropdownCol.width
                                height: 30
                                radius: 6
                                color: modelData.id === root.terminal ? Theme.primary : "transparent"

                                StyledText {
                                    text: modelData.name
                                    font.pixelSize: 12
                                    font.weight: modelData.id === root.terminal ? Font.Bold : Font.Normal
                                    color: modelData.id === root.terminal ? Theme.onPrimary : Theme.surfaceText
                                    anchors.centerIn: parent
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: root.switchTerminal(modelData.id)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    popoutWidth: 360
    popoutHeight: root.showAllThemes ? 440 : 280

    Component.onCompleted: console.info("DankTerminalTheme loaded:", currentTheme, "terminal:", terminal)
}
