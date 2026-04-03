// DankTerminalTheme.qml - Terminal Theme Manager for Ghostty
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
    property bool showGridView: false

    readonly property string homePath: {
        // Try to get home directory from environment
        try {
            return process.env.HOME || (process.env.USER ? "/home/" + process.env.USER : "")
        } catch(e) {
            return ""
        }
    }
    readonly property string ghosttyConfigDir: homePath + "/.config/ghostty"
    readonly property string ghosttyMainConfig: ghosttyConfigDir + "/config"
    readonly property string ghosttySystemThemesDir: "/usr/share/ghostty/themes"
    readonly property string ghosttyUserThemesDir: ghosttyConfigDir + "/themes"

    // Cache for parsed theme colors (keyed by ghosttyName)
    property var themeColorsCache: ({})

    // Read and parse a ghostty theme file, returning an object with colors
    // Returns null if theme file cannot be read
    function readThemeColors(ghosttyName) {
        // Check cache first
        if (themeColorsCache[ghosttyName] !== undefined) {
            return themeColorsCache[ghosttyName]
        }

        // Try to read from cache file created by bash script
        try {
            if (io && io.file) {
                var cacheFile = "/tmp/ghostty_themes_cache.txt"
                var content = io.file.read(cacheFile)
                if (content) {
                    parseThemesFromCache(content)
                    if (themeColorsCache[ghosttyName] !== undefined) {
                        return themeColorsCache[ghosttyName]
                    }
                }
            }
        } catch(e) {}

        // Return defaults if not cached yet
        return {
            background: "#000000",
            foreground: "#ffffff",
            cursorColor: "#ffffff",
            cursorText: "#000000",
            selectionBackground: "#ffffff",
            selectionForeground: "#000000",
            palette: ["#000000","#000000","#000000","#000000","#000000","#000000","#000000","#000000",
                      "#000000","#000000","#000000","#000000","#000000","#000000","#000000","#000000"]
        }
    }

    // Parse themes from cache content
    function parseThemesFromCache(content) {
        try {
            var themeBlocks = content.split("---END---")
            for (var i = 0; i < themeBlocks.length; i++) {
                var block = themeBlocks[i].trim()
                if (!block) continue
                
                var lines = block.split("\n")
                if (lines.length < 2) continue
                
                var themeName = lines[0].trim().replace(/:$/, "")
                if (!themeName) continue
                
                var colors = {
                    background: "#000000",
                    foreground: "#ffffff",
                    cursorColor: "#ffffff",
                    cursorText: "#000000",
                    selectionBackground: "#ffffff",
                    selectionForeground: "#000000",
                    palette: ["#000000","#000000","#000000","#000000","#000000","#000000","#000000","#000000",
                              "#000000","#000000","#000000","#000000","#000000","#000000","#000000","#000000"]
                }
                
                for (var j = 1; j < lines.length; j++) {
                    var line = lines[j].trim()
                    if (!line || line[0] === "#") continue
                    
                    var eqIndex = line.indexOf("=")
                    if (eqIndex === -1) continue
                    
                    var key = line.substring(0, eqIndex).trim()
                    var value = line.substring(eqIndex + 1).trim()
                    
                    if (key === "background") {
                        colors.background = value
                    } else if (key === "foreground") {
                        colors.foreground = value
                    } else if (key === "cursor-color") {
                        colors.cursorColor = value
                    } else if (key === "cursor-text") {
                        colors.cursorText = value
                    } else if (key === "selection-background") {
                        colors.selectionBackground = value
                    } else if (key === "selection-foreground") {
                        colors.selectionForeground = value
                    } else if (key.startsWith("palette")) {
                        var paletteIndex = key.substring(7).trim()
                        if (paletteIndex !== "" && !isNaN(paletteIndex)) {
                            colors.palette[parseInt(paletteIndex)] = value
                        }
                    }
                }
                
                themeColorsCache[themeName] = colors
            }
        } catch(e) {}
    }

    // Parse themes from cache file
    function parseThemesFromCache() {
        try {
            var file = io.file.read("/tmp/ghostty_themes_cache.txt")
            if (!file) return
            
            var themeBlocks = file.split("---END---")
            for (var i = 0; i < themeBlocks.length; i++) {
                var block = themeBlocks[i].trim()
                if (!block) continue
                
                var lines = block.split("\n")
                if (lines.length < 2) continue
                
                var themeName = lines[0].trim().replace(/:$/, "")
                if (!themeName) continue
                
                var colors = {
                    background: "#000000",
                    foreground: "#ffffff",
                    cursorColor: "#ffffff",
                    cursorText: "#000000",
                    selectionBackground: "#ffffff",
                    selectionForeground: "#000000",
                    palette: ["#000000","#000000","#000000","#000000","#000000","#000000","#000000","#000000",
                              "#000000","#000000","#000000","#000000","#000000","#000000","#000000","#000000"]
                }
                
                for (var j = 1; j < lines.length; j++) {
                    var line = lines[j].trim()
                    if (!line || line[0] === "#") continue
                    
                    var eqIndex = line.indexOf("=")
                    if (eqIndex === -1) continue
                    
                    var key = line.substring(0, eqIndex).trim()
                    var value = line.substring(eqIndex + 1).trim()
                    
                    if (key === "background") {
                        colors.background = value
                    } else if (key === "foreground") {
                        colors.foreground = value
                    } else if (key === "cursor-color") {
                        colors.cursorColor = value
                    } else if (key === "cursor-text") {
                        colors.cursorText = value
                    } else if (key === "selection-background") {
                        colors.selectionBackground = value
                    } else if (key === "selection-foreground") {
                        colors.selectionForeground = value
                    } else if (key.startsWith("palette")) {
                        var paletteIndex = key.substring(7).trim()
                        if (paletteIndex !== "" && !isNaN(paletteIndex)) {
                            colors.palette[parseInt(paletteIndex)] = value
                        }
                    }
                }
                
                themeColorsCache[themeName] = colors
            }
        } catch(e) {}
    }

    function readThemeColors(ghosttyName) {
        // Check cache first
        if (themeColorsCache[ghosttyName] !== undefined) {
            return themeColorsCache[ghosttyName]
        }

        // Return defaults if not cached yet
        return {
            background: "#000000",
            foreground: "#ffffff",
            cursorColor: "#ffffff",
            cursorText: "#000000",
            selectionBackground: "#ffffff",
            selectionForeground: "#000000",
            palette: ["#000000","#000000","#000000","#000000","#000000","#000000","#000000","#000000",
                      "#000000","#000000","#000000","#000000","#000000","#000000","#000000","#000000"]
        }
    }
        })
    }

    // Parse the output from the bash command
    function parseAllThemesOutput(output) {
        var themeBlocks = output.split("---END---")
        for (var i = 0; i < themeBlocks.length; i++) {
            var block = themeBlocks[i].trim()
            if (!block) continue
            
            var lines = block.split("\n")
            if (lines.length < 2) continue
            
            var themeName = lines[0].trim().replace(/:$/, "")
            if (!themeName) continue
            
            var colors = {
                background: "#000000",
                foreground: "#ffffff",
                cursorColor: "#ffffff",
                cursorText: "#000000",
                selectionBackground: "#ffffff",
                selectionForeground: "#000000",
                palette: ["#000000","#000000","#000000","#000000","#000000","#000000","#000000","#000000",
                          "#000000","#000000","#000000","#000000","#000000","#000000","#000000","#000000"]
            }
            
            for (var j = 1; j < lines.length; j++) {
                var line = lines[j].trim()
                if (!line || line[0] === "#") continue
                
                var eqIndex = line.indexOf("=")
                if (eqIndex === -1) continue
                
                var key = line.substring(0, eqIndex).trim()
                var value = line.substring(eqIndex + 1).trim()
                
                if (key === "background") {
                    colors.background = value
                } else if (key === "foreground") {
                    colors.foreground = value
                } else if (key === "cursor-color") {
                    colors.cursorColor = value
                } else if (key === "cursor-text") {
                    colors.cursorText = value
                } else if (key === "selection-background") {
                    colors.selectionBackground = value
                } else if (key === "selection-foreground") {
                    colors.selectionForeground = value
                } else if (key.startsWith("palette")) {
                    var paletteIndex = key.substring(7).trim()
                    if (paletteIndex !== "" && !isNaN(paletteIndex)) {
                        colors.palette[parseInt(paletteIndex)] = value
                    }
                }
            }
            
            themeColorsCache[themeName] = colors
        }
    }

    function readThemeColors(ghosttyName) {
        // Check cache first
        if (themeColorsCache[ghosttyName] !== undefined) {
            return themeColorsCache[ghosttyName]
        }

        // Return defaults if not cached yet
        return {
            background: "#000000",
            foreground: "#ffffff",
            cursorColor: "#ffffff",
            cursorText: "#000000",
            selectionBackground: "#ffffff",
            selectionForeground: "#000000",
            palette: ["#000000","#000000","#000000","#000000","#000000","#000000","#000000","#000000",
                      "#000000","#000000","#000000","#000000","#000000","#000000","#000000","#000000"]
        }
    }

    // Get a preview of the first 8 palette colors for a theme
    function getThemePalettePreview(ghosttyName) {
        var colors = readThemeColors(ghosttyName)
        return colors.palette.slice(0, 8)
    }

    // Ghostty built-in themes - ghosttyName must match `ghostty +list-themes` output
    readonly property var themes: [
        { id: "0x96f", name: "0x96f", ghosttyName: "0x96f" },
        { id: "12-bit-rainbow", name: "12-bit Rainbow", ghosttyName: "12-bit Rainbow" },
        { id: "3024-day", name: "3024 Day", ghosttyName: "3024 Day" },
        { id: "3024-night", name: "3024 Night", ghosttyName: "3024 Night" },
        { id: "aardvark-blue", name: "Aardvark Blue", ghosttyName: "Aardvark Blue" },
        { id: "abernathy", name: "Abernathy", ghosttyName: "Abernathy" },
        { id: "adventure", name: "Adventure", ghosttyName: "Adventure" },
        { id: "adventure-time", name: "Adventure Time", ghosttyName: "Adventure Time" },
        { id: "adwaita", name: "Adwaita", ghosttyName: "Adwaita" },
        { id: "adwaita-dark", name: "Adwaita Dark", ghosttyName: "Adwaita Dark" },
        { id: "afterglow", name: "Afterglow", ghosttyName: "Afterglow" },
        { id: "alabaster", name: "Alabaster", ghosttyName: "Alabaster" },
        { id: "alien-blood", name: "Alien Blood", ghosttyName: "Alien Blood" },
        { id: "andromeda", name: "Andromeda", ghosttyName: "Andromeda" },
        { id: "apple-classic", name: "Apple Classic", ghosttyName: "Apple Classic" },
        { id: "apple-system-colors", name: "Apple System Colors", ghosttyName: "Apple System Colors" },
        { id: "apple-system-colors-light", name: "Apple System Colors Light", ghosttyName: "Apple System Colors Light" },
        { id: "arcoiris", name: "Arcoiris", ghosttyName: "Arcoiris" },
        { id: "ardoise", name: "Ardoise", ghosttyName: "Ardoise" },
        { id: "argonaut", name: "Argonaut", ghosttyName: "Argonaut" },
        { id: "arthur", name: "Arthur", ghosttyName: "Arthur" },
        { id: "atelier-sulphurpool", name: "Atelier Sulphurpool", ghosttyName: "Atelier Sulphurpool" },
        { id: "atom", name: "Atom", ghosttyName: "Atom" },
        { id: "atom-one-dark", name: "Atom One Dark", ghosttyName: "Atom One Dark" },
        { id: "atom-one-light", name: "Atom One Light", ghosttyName: "Atom One Light" },
        { id: "aura", name: "Aura", ghosttyName: "Aura" },
        { id: "aurora", name: "Aurora", ghosttyName: "Aurora" },
        { id: "ayu", name: "Ayu", ghosttyName: "Ayu" },
        { id: "ayu-light", name: "Ayu Light", ghosttyName: "Ayu Light" },
        { id: "ayu-mirage", name: "Ayu Mirage", ghosttyName: "Ayu Mirage" },
        { id: "banana-blueberry", name: "Banana Blueberry", ghosttyName: "Banana Blueberry" },
        { id: "batman", name: "Batman", ghosttyName: "Batman" },
        { id: "belafonte-day", name: "Belafonte Day", ghosttyName: "Belafonte Day" },
        { id: "belafonte-night", name: "Belafonte Night", ghosttyName: "Belafonte Night" },
        { id: "birds-of-paradise", name: "Birds Of Paradise", ghosttyName: "Birds Of Paradise" },
        { id: "black-metal", name: "Black Metal", ghosttyName: "Black Metal" },
        { id: "black-metal-bathory", name: "Black Metal (Bathory)", ghosttyName: "Black Metal (Bathory)" },
        { id: "black-metal-burzum", name: "Black Metal (Burzum)", ghosttyName: "Black Metal (Burzum)" },
        { id: "black-metal-dark-funeral", name: "Black Metal (Dark Funeral)", ghosttyName: "Black Metal (Dark Funeral)" },
        { id: "black-metal-gorgoroth", name: "Black Metal (Gorgoroth)", ghosttyName: "Black Metal (Gorgoroth)" },
        { id: "black-metal-immortal", name: "Black Metal (Immortal)", ghosttyName: "Black Metal (Immortal)" },
        { id: "black-metal-khold", name: "Black Metal (Khold)", ghosttyName: "Black Metal (Khold)" },
        { id: "black-metal-marduk", name: "Black Metal (Marduk)", ghosttyName: "Black Metal (Marduk)" },
        { id: "black-metal-mayhem", name: "Black Metal (Mayhem)", ghosttyName: "Black Metal (Mayhem)" },
        { id: "black-metal-nile", name: "Black Metal (Nile)", ghosttyName: "Black Metal (Nile)" },
        { id: "black-metal-venom", name: "Black Metal (Venom)", ghosttyName: "Black Metal (Venom)" },
        { id: "blazer", name: "Blazer", ghosttyName: "Blazer" },
        { id: "blue-berry-pie", name: "Blue Berry Pie", ghosttyName: "Blue Berry Pie" },
        { id: "blue-dolphin", name: "Blue Dolphin", ghosttyName: "Blue Dolphin" },
        { id: "blue-matrix", name: "Blue Matrix", ghosttyName: "Blue Matrix" },
        { id: "bluloco-dark", name: "Bluloco Dark", ghosttyName: "Bluloco Dark" },
        { id: "bluloco-light", name: "Bluloco Light", ghosttyName: "Bluloco Light" },
        { id: "borland", name: "Borland", ghosttyName: "Borland" },
        { id: "box", name: "Box", ghosttyName: "Box" },
        { id: "branch", name: "branch", ghosttyName: "branch" },
        { id: "breadog", name: "Breadog", ghosttyName: "Breadog" },
        { id: "breeze", name: "Breeze", ghosttyName: "Breeze" },
        { id: "bright-lights", name: "Bright Lights", ghosttyName: "Bright Lights" },
        { id: "broadcast", name: "Broadcast", ghosttyName: "Broadcast" },
        { id: "brogrammer", name: "Brogrammer", ghosttyName: "Brogrammer" },
        { id: "builtin-dark", name: "Builtin Dark", ghosttyName: "Builtin Dark" },
        { id: "builtin-light", name: "Builtin Light", ghosttyName: "Builtin Light" },
        { id: "builtin-pastel-dark", name: "Builtin Pastel Dark", ghosttyName: "Builtin Pastel Dark" },
        { id: "builtin-solarized-dark", name: "Builtin Solarized Dark", ghosttyName: "Builtin Solarized Dark" },
        { id: "builtin-solarized-light", name: "Builtin Solarized Light", ghosttyName: "Builtin Solarized Light" },
        { id: "builtin-tango-dark", name: "Builtin Tango Dark", ghosttyName: "Builtin Tango Dark" },
        { id: "builtin-tango-light", name: "Builtin Tango Light", ghosttyName: "Builtin Tango Light" },
        { id: "c64", name: "C64", ghosttyName: "C64" },
        { id: "calamity", name: "Calamity", ghosttyName: "Calamity" },
        { id: "carbonfox", name: "Carbonfox", ghosttyName: "Carbonfox" },
        { id: "catppuccin-frappe", name: "Catppuccin Frappe", ghosttyName: "Catppuccin Frappe" },
        { id: "catppuccin-latte", name: "Catppuccin Latte", ghosttyName: "Catppuccin Latte" },
        { id: "catppuccin-macchiato", name: "Catppuccin Macchiato", ghosttyName: "Catppuccin Macchiato" },
        { id: "catppuccin-mocha", name: "Catppuccin Mocha", ghosttyName: "Catppuccin Mocha" },
        { id: "cga", name: "CGA", ghosttyName: "CGA" },
        { id: "chalk", name: "Chalk", ghosttyName: "Chalk" },
        { id: "chalkboard", name: "Chalkboard", ghosttyName: "Chalkboard" },
        { id: "challenger-deep", name: "Challenger Deep", ghosttyName: "Challenger Deep" },
        { id: "chester", name: "Chester", ghosttyName: "Chester" },
        { id: "ciapre", name: "Ciapre", ghosttyName: "Ciapre" },
        { id: "citruszest", name: "Citruszest", ghosttyName: "Citruszest" },
        { id: "clrs", name: "CLRS", ghosttyName: "CLRS" },
        { id: "cobalt-neon", name: "Cobalt Neon", ghosttyName: "Cobalt Neon" },
        { id: "cobalt-next", name: "Cobalt Next", ghosttyName: "Cobalt Next" },
        { id: "cobalt-next-dark", name: "Cobalt Next Dark", ghosttyName: "Cobalt Next Dark" },
        { id: "cobalt-next-minimal", name: "Cobalt Next Minimal", ghosttyName: "Cobalt Next Minimal" },
        { id: "cobalt2", name: "Cobalt2", ghosttyName: "Cobalt2" },
        { id: "coffee-theme", name: "Coffee Theme", ghosttyName: "Coffee Theme" },
        { id: "crayon-pony-fish", name: "Crayon Pony Fish", ghosttyName: "Crayon Pony Fish" },
        { id: "cursor-dark", name: "Cursor Dark", ghosttyName: "Cursor Dark" },
        { id: "cutie-pro", name: "Cutie Pro", ghosttyName: "Cutie Pro" },
        { id: "cyberdyne", name: "Cyberdyne", ghosttyName: "Cyberdyne" },
        { id: "cyberpunk", name: "Cyberpunk", ghosttyName: "Cyberpunk" },
        { id: "cyberpunk-scarlet-protocol", name: "Cyberpunk Scarlet Protocol", ghosttyName: "Cyberpunk Scarlet Protocol" },
        { id: "dankcolors", name: "dankcolors", ghosttyName: "dankcolors" },
        { id: "dark-modern", name: "Dark Modern", ghosttyName: "Dark Modern" },
        { id: "dark-pastel", name: "Dark Pastel", ghosttyName: "Dark Pastel" },
        { id: "darkplus", name: "Dark+", ghosttyName: "Dark+" },
        { id: "darkermatrix", name: "Darkermatrix", ghosttyName: "Darkermatrix" },
        { id: "darkmatrix", name: "Darkmatrix", ghosttyName: "Darkmatrix" },
        { id: "darkside", name: "Darkside", ghosttyName: "Darkside" },
        { id: "dawnfox", name: "Dawnfox", ghosttyName: "Dawnfox" },
        { id: "dayfox", name: "Dayfox", ghosttyName: "Dayfox" },
        { id: "deep", name: "Deep", ghosttyName: "Deep" },
        { id: "desert", name: "Desert", ghosttyName: "Desert" },
        { id: "detuned", name: "Detuned", ghosttyName: "Detuned" },
        { id: "dimidium", name: "Dimidium", ghosttyName: "Dimidium" },
        { id: "dimmed-monokai", name: "Dimmed Monokai", ghosttyName: "Dimmed Monokai" },
        { id: "django", name: "Django", ghosttyName: "Django" },
        { id: "django-reborn-again", name: "Django Reborn Again", ghosttyName: "Django Reborn Again" },
        { id: "django-smooth", name: "Django Smooth", ghosttyName: "Django Smooth" },
        { id: "doom-one", name: "Doom One", ghosttyName: "Doom One" },
        { id: "doom-peacock", name: "Doom Peacock", ghosttyName: "Doom Peacock" },
        { id: "dot-gov", name: "Dot Gov", ghosttyName: "Dot Gov" },
        { id: "dracula", name: "Dracula", ghosttyName: "Dracula" },
        { id: "dracula-plus", name: "Dracula+", ghosttyName: "Dracula+" },
        { id: "duckbones", name: "Duckbones", ghosttyName: "Duckbones" },
        { id: "duotone-dark", name: "Duotone Dark", ghosttyName: "Duotone Dark" },
        { id: "duskfox", name: "Duskfox", ghosttyName: "Duskfox" },
        { id: "earthsong", name: "Earthsong", ghosttyName: "Earthsong" },
        { id: "electron-highlighter", name: "Electron Highlighter", ghosttyName: "Electron Highlighter" },
        { id: "elegant", name: "Elegant", ghosttyName: "Elegant" },
        { id: "elemental", name: "Elemental", ghosttyName: "Elemental" },
        { id: "elementary", name: "Elementary", ghosttyName: "Elementary" },
        { id: "embark", name: "Embark", ghosttyName: "Embark" },
        { id: "embers-dark", name: "Embers Dark", ghosttyName: "Embers Dark" },
        { id: "encom", name: "ENCOM", ghosttyName: "ENCOM" },
        { id: "espresso", name: "Espresso", ghosttyName: "Espresso" },
        { id: "espresso-libre", name: "Espresso Libre", ghosttyName: "Espresso Libre" },
        { id: "everblush", name: "Everblush", ghosttyName: "Everblush" },
        { id: "everforest-dark-hard", name: "Everforest Dark Hard", ghosttyName: "Everforest Dark Hard" },
        { id: "everforest-light-med", name: "Everforest Light Med", ghosttyName: "Everforest Light Med" },
        { id: "fahrenheit", name: "Fahrenheit", ghosttyName: "Fahrenheit" },
        { id: "fairyfloss", name: "Fairyfloss", ghosttyName: "Fairyfloss" },
        { id: "farmhouse-dark", name: "Farmhouse Dark", ghosttyName: "Farmhouse Dark" },
        { id: "farmhouse-light", name: "Farmhouse Light", ghosttyName: "Farmhouse Light" },
        { id: "fideloper", name: "Fideloper", ghosttyName: "Fideloper" },
        { id: "firefly-traditional", name: "Firefly Traditional", ghosttyName: "Firefly Traditional" },
        { id: "firefox-dev", name: "Firefox Dev", ghosttyName: "Firefox Dev" },
        { id: "firewatch", name: "Firewatch", ghosttyName: "Firewatch" },
        { id: "fish-tank", name: "Fish Tank", ghosttyName: "Fish Tank" },
        { id: "flat", name: "Flat", ghosttyName: "Flat" },
        { id: "flatland", name: "Flatland", ghosttyName: "Flatland" },
        { id: "flexoki-dark", name: "Flexoki Dark", ghosttyName: "Flexoki Dark" },
        { id: "flexoki-light", name: "Flexoki Light", ghosttyName: "Flexoki Light" },
        { id: "floraverse", name: "Floraverse", ghosttyName: "Floraverse" },
        { id: "forest-blue", name: "Forest Blue", ghosttyName: "Forest Blue" },
        { id: "framer", name: "Framer", ghosttyName: "Framer" },
        { id: "front-end-delight", name: "Front End Delight", ghosttyName: "Front End Delight" },
        { id: "fun-forrest", name: "Fun Forrest", ghosttyName: "Fun Forrest" },
        { id: "galaxy", name: "Galaxy", ghosttyName: "Galaxy" },
        { id: "galizur", name: "Galizur", ghosttyName: "Galizur" },
        { id: "ghostty-default-style-dark", name: "Ghostty Default Style Dark", ghosttyName: "Ghostty Default Style Dark" },
        { id: "github", name: "GitHub", ghosttyName: "GitHub" },
        { id: "github-dark", name: "GitHub Dark", ghosttyName: "GitHub Dark" },
        { id: "github-dark-colorblind", name: "GitHub Dark Colorblind", ghosttyName: "GitHub Dark Colorblind" },
        { id: "github-dark-default", name: "GitHub Dark Default", ghosttyName: "GitHub Dark Default" },
        { id: "github-dark-dimmed", name: "GitHub Dark Dimmed", ghosttyName: "GitHub Dark Dimmed" },
        { id: "github-dark-high-contrast", name: "GitHub Dark High Contrast", ghosttyName: "GitHub Dark High Contrast" },
        { id: "github-light-colorblind", name: "GitHub Light Colorblind", ghosttyName: "GitHub Light Colorblind" },
        { id: "github-light-default", name: "GitHub Light Default", ghosttyName: "GitHub Light Default" },
        { id: "github-light-high-contrast", name: "GitHub Light High Contrast", ghosttyName: "GitHub Light High Contrast" },
        { id: "gitlab-dark", name: "GitLab Dark", ghosttyName: "GitLab Dark" },
        { id: "gitlab-dark-grey", name: "GitLab Dark Grey", ghosttyName: "GitLab Dark Grey" },
        { id: "gitlab-light", name: "GitLab Light", ghosttyName: "GitLab Light" },
        { id: "glacier", name: "Glacier", ghosttyName: "Glacier" },
        { id: "grape", name: "Grape", ghosttyName: "Grape" },
        { id: "grass", name: "Grass", ghosttyName: "Grass" },
        { id: "grey-green", name: "Grey Green", ghosttyName: "Grey Green" },
        { id: "gruber-darker", name: "Gruber Darker", ghosttyName: "Gruber Darker" },
        { id: "gruvbox-dark", name: "Gruvbox Dark", ghosttyName: "Gruvbox Dark" },
        { id: "gruvbox-dark-hard", name: "Gruvbox Dark Hard", ghosttyName: "Gruvbox Dark Hard" },
        { id: "gruvbox-light", name: "Gruvbox Light", ghosttyName: "Gruvbox Light" },
        { id: "gruvbox-light-hard", name: "Gruvbox Light Hard", ghosttyName: "Gruvbox Light Hard" },
        { id: "gruvbox-material", name: "Gruvbox Material", ghosttyName: "Gruvbox Material" },
        { id: "gruvbox-material-dark", name: "Gruvbox Material Dark", ghosttyName: "Gruvbox Material Dark" },
        { id: "gruvbox-material-light", name: "Gruvbox Material Light", ghosttyName: "Gruvbox Material Light" },
        { id: "guezwhoz", name: "Guezwhoz", ghosttyName: "Guezwhoz" },
        { id: "hacktober", name: "Hacktober", ghosttyName: "Hacktober" },
        { id: "hardcore", name: "Hardcore", ghosttyName: "Hardcore" },
        { id: "harper", name: "Harper", ghosttyName: "Harper" },
        { id: "havn-daggry", name: "Havn Daggry", ghosttyName: "Havn Daggry" },
        { id: "havn-skumring", name: "Havn Skumring", ghosttyName: "Havn Skumring" },
        { id: "hax0r-blue", name: "HaX0R Blue", ghosttyName: "HaX0R Blue" },
        { id: "hax0r-gr33n", name: "HaX0R Gr33n", ghosttyName: "HaX0R Gr33n" },
        { id: "hax0r-r3d", name: "HaX0R R3D", ghosttyName: "HaX0R R3d" },
        { id: "heeler", name: "Heeler", ghosttyName: "Heeler" },
        { id: "highway", name: "Highway", ghosttyName: "Highway" },
        { id: "hipster-green", name: "Hipster Green", ghosttyName: "Hipster Green" },
        { id: "hivacruz", name: "Hivacruz", ghosttyName: "Hivacruz" },
        { id: "homebrew", name: "Homebrew", ghosttyName: "Homebrew" },
        { id: "hopscotch", name: "Hopscotch", ghosttyName: "Hopscotch" },
        { id: "hopscotch-256", name: "Hopscotch.256", ghosttyName: "Hopscotch.256" },
        { id: "horizon", name: "Horizon", ghosttyName: "Horizon" },
        { id: "horizon-bright", name: "Horizon Bright", ghosttyName: "Horizon Bright" },
        { id: "hot-dog-stand", name: "Hot Dog Stand", ghosttyName: "Hot Dog Stand" },
        { id: "hot-dog-stand-mustard", name: "Hot Dog Stand (Mustard)", ghosttyName: "Hot Dog Stand (Mustard)" },
        { id: "hurtado", name: "Hurtado", ghosttyName: "Hurtado" },
        { id: "hybrid", name: "Hybrid", ghosttyName: "Hybrid" },
        { id: "ibm-5153-cga", name: "IBM 5153 CGA", ghosttyName: "IBM 5153 CGA" },
        { id: "ibm-5153-cga-black", name: "IBM 5153 CGA (Black)", ghosttyName: "IBM 5153 CGA (Black)" },
        { id: "ic-green-ppl", name: "IC Green PPL", ghosttyName: "IC Green PPL" },
        { id: "ic-orange-ppl", name: "IC Orange PPL", ghosttyName: "IC Orange PPL" },
        { id: "iceberg-dark", name: "Iceberg Dark", ghosttyName: "Iceberg Dark" },
        { id: "iceberg-light", name: "Iceberg Light", ghosttyName: "Iceberg Light" },
        { id: "idea", name: "Idea", ghosttyName: "Idea" },
        { id: "idle-toes", name: "Idle Toes", ghosttyName: "Idle Toes" },
        { id: "ir-black", name: "IR Black", ghosttyName: "IR Black" },
        { id: "irix-console", name: "IRIX Console", ghosttyName: "IRIX Console" },
        { id: "irix-terminal", name: "IRIX Terminal", ghosttyName: "IRIX Terminal" },
        { id: "iterm2-dark-background", name: "iTerm2 Dark Background", ghosttyName: "iTerm2 Dark Background" },
        { id: "iterm2-default", name: "iTerm2 Default", ghosttyName: "iTerm2 Default" },
        { id: "iterm2-light-background", name: "iTerm2 Light Background", ghosttyName: "iTerm2 Light Background" },
        { id: "iterm2-pastel-dark-background", name: "iTerm2 Pastel Dark Background", ghosttyName: "iTerm2 Pastel Dark Background" },
        { id: "iterm2-smoooooth", name: "iTerm2 Smoooooth", ghosttyName: "iTerm2 Smoooooth" },
        { id: "iterm2-solarized-dark", name: "iTerm2 Solarized Dark", ghosttyName: "iTerm2 Solarized Dark" },
        { id: "iterm2-solarized-light", name: "iTerm2 Solarized Light", ghosttyName: "iTerm2 Solarized Light" },
        { id: "iterm2-tango-dark", name: "iTerm2 Tango Dark", ghosttyName: "iTerm2 Tango Dark" },
        { id: "iterm2-tango-light", name: "iTerm2 Tango Light", ghosttyName: "iTerm2 Tango Light" },
        { id: "jackie-brown", name: "Jackie Brown", ghosttyName: "Jackie Brown" },
        { id: "japanesque", name: "Japanesque", ghosttyName: "Japanesque" },
        { id: "jellybeans", name: "Jellybeans", ghosttyName: "Jellybeans" },
        { id: "jetbrains-darcula", name: "JetBrains Darcula", ghosttyName: "JetBrains Darcula" },
        { id: "jubi", name: "Jubi", ghosttyName: "Jubi" },
        { id: "kanagawa-dragon", name: "Kanagawa Dragon", ghosttyName: "Kanagawa Dragon" },
        { id: "kanagawa-wave", name: "Kanagawa Wave", ghosttyName: "Kanagawa Wave" },
        { id: "kanagawabones", name: "Kanagawabones", ghosttyName: "Kanagawabones" },
        { id: "kibble", name: "Kibble", ghosttyName: "Kibble" },
        { id: "kitty-default", name: "Kitty Default", ghosttyName: "Kitty Default" },
        { id: "kitty-low-contrast", name: "Kitty Low Contrast", ghosttyName: "Kitty Low Contrast" },
        { id: "kolorit", name: "Kolorit", ghosttyName: "Kolorit" },
        { id: "konsolas", name: "Konsolas", ghosttyName: "Konsolas" },
        { id: "kurokula", name: "Kurokula", ghosttyName: "Kurokula" },
        { id: "lab-fox", name: "Lab Fox", ghosttyName: "Lab Fox" },
        { id: "laser", name: "Laser", ghosttyName: "Laser" },
        { id: "later-this-evening", name: "Later This Evening", ghosttyName: "Later This Evening" },
        { id: "lavandula", name: "Lavandula", ghosttyName: "Lavandula" },
        { id: "light-owl", name: "Light Owl", ghosttyName: "Light Owl" },
        { id: "liquid-carbon", name: "Liquid Carbon", ghosttyName: "Liquid Carbon" },
        { id: "liquid-carbon-transparent", name: "Liquid Carbon Transparent", ghosttyName: "Liquid Carbon Transparent" },
        { id: "lovelace", name: "Lovelace", ghosttyName: "Lovelace" },
        { id: "lumina-active", name: "lumina_active", ghosttyName: "lumina_active" },
        { id: "man-page", name: "Man Page", ghosttyName: "Man Page" },
        { id: "mariana", name: "Mariana", ghosttyName: "Mariana" },
        { id: "material", name: "Material", ghosttyName: "Material" },
        { id: "material-dark", name: "Material Dark", ghosttyName: "Material Dark" },
        { id: "material-darker", name: "Material Darker", ghosttyName: "Material Darker" },
        { id: "material-design-colors", name: "Material Design Colors", ghosttyName: "Material Design Colors" },
        { id: "material-ocean", name: "Material Ocean", ghosttyName: "Material Ocean" },
        { id: "mathias", name: "Mathias", ghosttyName: "Mathias" },
        { id: "matrix", name: "Matrix", ghosttyName: "Matrix" },
        { id: "matte-black", name: "Matte Black", ghosttyName: "Matte Black" },
        { id: "medallion", name: "Medallion", ghosttyName: "Medallion" },
        { id: "melange-dark", name: "Melange Dark", ghosttyName: "Melange Dark" },
        { id: "melange-light", name: "Melange Light", ghosttyName: "Melange Light" },
        { id: "mellifluous", name: "Mellifluous", ghosttyName: "Mellifluous" },
        { id: "mellow", name: "Mellow", ghosttyName: "Mellow" },
        { id: "miasma", name: "Miasma", ghosttyName: "Miasma" },
        { id: "midnight-in-mojave", name: "Midnight In Mojave", ghosttyName: "Midnight In Mojave" },
        { id: "mirage", name: "Mirage", ghosttyName: "Mirage" },
        { id: "misterioso", name: "Misterioso", ghosttyName: "Misterioso" },
        { id: "molokai", name: "Molokai", ghosttyName: "Molokai" },
        { id: "mona-lisa", name: "Mona Lisa", ghosttyName: "Mona Lisa" },
        { id: "monokai-classic", name: "Monokai Classic", ghosttyName: "Monokai Classic" },
        { id: "monokai-pro", name: "Monokai Pro", ghosttyName: "Monokai Pro" },
        { id: "monokai-pro-light", name: "Monokai Pro Light", ghosttyName: "Monokai Pro Light" },
        { id: "monokai-pro-light-sun", name: "Monokai Pro Light Sun", ghosttyName: "Monokai Pro Light Sun" },
        { id: "monokai-pro-machine", name: "Monokai Pro Machine", ghosttyName: "Monokai Pro Machine" },
        { id: "monokai-pro-octagon", name: "Monokai Pro Octagon", ghosttyName: "Monokai Pro Octagon" },
        { id: "monokai-pro-ristretto", name: "Monokai Pro Ristretto", ghosttyName: "Monokai Pro Ristretto" },
        { id: "monokai-pro-spectrum", name: "Monokai Pro Spectrum", ghosttyName: "Monokai Pro Spectrum" },
        { id: "monokai-remastered", name: "Monokai Remastered", ghosttyName: "Monokai Remastered" },
        { id: "monokai-soda", name: "Monokai Soda", ghosttyName: "Monokai Soda" },
        { id: "monokai-vivid", name: "Monokai Vivid", ghosttyName: "Monokai Vivid" },
        { id: "moonfly", name: "Moonfly", ghosttyName: "Moonfly" },
        { id: "n0tch2k", name: "N0Tch2K", ghosttyName: "N0Tch2K" },
        { id: "neobones-dark", name: "Neobones Dark", ghosttyName: "Neobones Dark" },
        { id: "neobones-light", name: "Neobones Light", ghosttyName: "Neobones Light" },
        { id: "neon", name: "Neon", ghosttyName: "Neon" },
        { id: "neopolitan", name: "Neopolitan", ghosttyName: "Neopolitan" },
        { id: "neutron", name: "Neutron", ghosttyName: "Neutron" },
        { id: "night-lion-v1", name: "Night Lion V1", ghosttyName: "Night Lion V1" },
        { id: "night-lion-v2", name: "Night Lion V2", ghosttyName: "Night Lion V2" },
        { id: "night-owl", name: "Night Owl", ghosttyName: "Night Owl" },
        { id: "night-owlish-light", name: "Night Owlish Light", ghosttyName: "Night Owlish Light" },
        { id: "nightfox", name: "Nightfox", ghosttyName: "Nightfox" },
        { id: "niji", name: "Niji", ghosttyName: "Niji" },
        { id: "no-clown-fiesta", name: "No Clown Fiesta", ghosttyName: "No Clown Fiesta" },
        { id: "no-clown-fiesta-light", name: "No Clown Fiesta Light", ghosttyName: "No Clown Fiesta Light" },
        { id: "nocturnal-winter", name: "Nocturnal Winter", ghosttyName: "Nocturnal Winter" },
        { id: "nord", name: "Nord", ghosttyName: "Nord" },
        { id: "nord-light", name: "Nord Light", ghosttyName: "Nord Light" },
        { id: "nord-wave", name: "Nord Wave", ghosttyName: "Nord Wave" },
        { id: "nordfox", name: "Nordfox", ghosttyName: "Nordfox" },
        { id: "novel", name: "Novel", ghosttyName: "Novel" },
        { id: "novmbr", name: "novmbr", ghosttyName: "novmbr" },
        { id: "nvim-dark", name: "Nvim Dark", ghosttyName: "Nvim Dark" },
        { id: "nvim-light", name: "Nvim Light", ghosttyName: "Nvim Light" },
        { id: "obsidian", name: "Obsidian", ghosttyName: "Obsidian" },
        { id: "ocean", name: "Ocean", ghosttyName: "Ocean" },
        { id: "oceanic-material", name: "Oceanic Material", ghosttyName: "Oceanic Material" },
        { id: "oceanic-next", name: "Oceanic Next", ghosttyName: "Oceanic Next" },
        { id: "ollie", name: "Ollie", ghosttyName: "Ollie" },
        { id: "one-dark-two", name: "One Dark Two", ghosttyName: "One Dark Two" },
        { id: "one-double-dark", name: "One Double Dark", ghosttyName: "One Double Dark" },
        { id: "one-double-light", name: "One Double Light", ghosttyName: "One Double Light" },
        { id: "one-half-dark", name: "One Half Dark", ghosttyName: "One Half Dark" },
        { id: "one-half-light", name: "One Half Light", ghosttyName: "One Half Light" },
        { id: "operator-mono-dark", name: "Operator Mono Dark", ghosttyName: "Operator Mono Dark" },
        { id: "overnight-slumber", name: "Overnight Slumber", ghosttyName: "Overnight Slumber" },
        { id: "owl", name: "owl", ghosttyName: "owl" },
        { id: "oxocarbon", name: "Oxocarbon", ghosttyName: "Oxocarbon" },
        { id: "pale-night-hc", name: "Pale Night Hc", ghosttyName: "Pale Night Hc" },
        { id: "pandora", name: "Pandora", ghosttyName: "Pandora" },
        { id: "paraiso-dark", name: "Paraiso Dark", ghosttyName: "Paraiso Dark" },
        { id: "paul-millr", name: "Paul Millr", ghosttyName: "Paul Millr" },
        { id: "pencil-dark", name: "Pencil Dark", ghosttyName: "Pencil Dark" },
        { id: "pencil-light", name: "Pencil Light", ghosttyName: "Pencil Light" },
        { id: "peppermint", name: "Peppermint", ghosttyName: "Peppermint" },
        { id: "phala-green-dark", name: "Phala Green Dark", ghosttyName: "Phala Green Dark" },
        { id: "piatto-light", name: "Piatto Light", ghosttyName: "Piatto Light" },
        { id: "pnevma", name: "Pnevma", ghosttyName: "Pnevma" },
        { id: "poimandres", name: "Poimandres", ghosttyName: "Poimandres" },
        { id: "poimandres-darker", name: "Poimandres Darker", ghosttyName: "Poimandres Darker" },
        { id: "poimandres-storm", name: "Poimandres Storm", ghosttyName: "Poimandres Storm" },
        { id: "poimandres-white", name: "Poimandres White", ghosttyName: "Poimandres White" },
        { id: "popping-and-locking", name: "Popping And Locking", ghosttyName: "Popping And Locking" },
        { id: "powershell", name: "Powershell", ghosttyName: "Powershell" },
        { id: "primary", name: "Primary", ghosttyName: "Primary" },
        { id: "pro", name: "Pro", ghosttyName: "Pro" },
        { id: "pro-light", name: "Pro Light", ghosttyName: "Pro Light" },
        { id: "purple-rain", name: "Purple Rain", ghosttyName: "Purple Rain" },
        { id: "purplepeter", name: "Purplepeter", ghosttyName: "Purplepeter" },
        { id: "rapture", name: "Rapture", ghosttyName: "Rapture" },
        { id: "raycast-dark", name: "Raycast Dark", ghosttyName: "Raycast Dark" },
        { id: "raycast-light", name: "Raycast Light", ghosttyName: "Raycast Light" },
        { id: "rebecca", name: "Rebecca", ghosttyName: "Rebecca" },
        { id: "red-alert", name: "Red Alert", ghosttyName: "Red Alert" },
        { id: "red-planet", name: "Red Planet", ghosttyName: "Red Planet" },
        { id: "red-sands", name: "Red Sands", ghosttyName: "Red Sands" },
        { id: "relaxed", name: "Relaxed", ghosttyName: "Relaxed" },
        { id: "retro", name: "Retro", ghosttyName: "Retro" },
        { id: "retro-legends", name: "Retro Legends", ghosttyName: "Retro Legends" },
        { id: "rippedcasts", name: "Rippedcasts", ghosttyName: "Rippedcasts" },
        { id: "rose-pine", name: "Rose Pine", ghosttyName: "Rose Pine" },
        { id: "rose-pine-dawn", name: "Rose Pine Dawn", ghosttyName: "Rose Pine Dawn" },
        { id: "rose-pine-moon", name: "Rose Pine Moon", ghosttyName: "Rose Pine Moon" },
        { id: "rouge-2", name: "Rouge 2", ghosttyName: "Rouge 2" },
        { id: "royal", name: "Royal", ghosttyName: "Royal" },
        { id: "ryuuko", name: "Ryuuko", ghosttyName: "Ryuuko" },
        { id: "sakura", name: "Sakura", ghosttyName: "Sakura" },
        { id: "scarlet-protocol", name: "Scarlet Protocol", ghosttyName: "Scarlet Protocol" },
        { id: "sea-shells", name: "Sea Shells", ghosttyName: "Sea Shells" },
        { id: "seafoam-pastel", name: "Seafoam Pastel", ghosttyName: "Seafoam Pastel" },
        { id: "selenized-black", name: "Selenized Black", ghosttyName: "Selenized Black" },
        { id: "selenized-dark", name: "Selenized Dark", ghosttyName: "Selenized Dark" },
        { id: "selenized-light", name: "Selenized Light", ghosttyName: "Selenized Light" },
        { id: "seoulbones-dark", name: "Seoulbones Dark", ghosttyName: "Seoulbones Dark" },
        { id: "seoulbones-light", name: "Seoulbones Light", ghosttyName: "Seoulbones Light" },
        { id: "seti", name: "Seti", ghosttyName: "Seti" },
        { id: "shades-of-purple", name: "Shades Of Purple", ghosttyName: "Shades Of Purple" },
        { id: "shaman", name: "Shaman", ghosttyName: "Shaman" },
        { id: "slate", name: "Slate", ghosttyName: "Slate" },
        { id: "sleepy-hollow", name: "Sleepy Hollow", ghosttyName: "Sleepy Hollow" },
        { id: "smyck", name: "Smyck", ghosttyName: "Smyck" },
        { id: "snazzy", name: "Snazzy", ghosttyName: "Snazzy" },
        { id: "snazzy-soft", name: "Snazzy Soft", ghosttyName: "Snazzy Soft" },
        { id: "soft-server", name: "Soft Server", ghosttyName: "Soft Server" },
        { id: "solarized-darcula", name: "Solarized Darcula", ghosttyName: "Solarized Darcula" },
        { id: "solarized-dark-higher-contrast", name: "Solarized Dark Higher Contrast", ghosttyName: "Solarized Dark Higher Contrast" },
        { id: "solarized-dark-patched", name: "Solarized Dark Patched", ghosttyName: "Solarized Dark Patched" },
        { id: "solarized-osaka-night", name: "Solarized Osaka Night", ghosttyName: "Solarized Osaka Night" },
        { id: "sonokai", name: "Sonokai", ghosttyName: "Sonokai" },
        { id: "spacedust", name: "Spacedust", ghosttyName: "Spacedust" },
        { id: "spacegray", name: "Spacegray", ghosttyName: "Spacegray" },
        { id: "spacegray-bright", name: "Spacegray Bright", ghosttyName: "Spacegray Bright" },
        { id: "spacegray-eighties", name: "Spacegray Eighties", ghosttyName: "Spacegray Eighties" },
        { id: "spacegray-eighties-dull", name: "Spacegray Eighties Dull", ghosttyName: "Spacegray Eighties Dull" },
        { id: "spiderman", name: "Spiderman", ghosttyName: "Spiderman" },
        { id: "spring", name: "Spring", ghosttyName: "Spring" },
        { id: "square", name: "Square", ghosttyName: "Square" },
        { id: "squirrelsong-dark", name: "Squirrelsong Dark", ghosttyName: "Squirrelsong Dark" },
        { id: "srcery", name: "Srcery", ghosttyName: "Srcery" },
        { id: "starlight", name: "Starlight", ghosttyName: "Starlight" },
        { id: "sublette", name: "Sublette", ghosttyName: "Sublette" },
        { id: "subliminal", name: "Subliminal", ghosttyName: "Subliminal" },
        { id: "sugarplum", name: "Sugarplum", ghosttyName: "Sugarplum" },
        { id: "sundried", name: "Sundried", ghosttyName: "Sundried" },
        { id: "symfonic", name: "Symfonic", ghosttyName: "Symfonic" },
        { id: "synthwave", name: "Synthwave", ghosttyName: "Synthwave" },
        { id: "synthwave-alpha", name: "Synthwave Alpha", ghosttyName: "Synthwave Alpha" },
        { id: "synthwave-everything", name: "Synthwave Everything", ghosttyName: "Synthwave Everything" },
        { id: "tango-adapted", name: "Tango Adapted", ghosttyName: "Tango Adapted" },
        { id: "tango-half-adapted", name: "Tango Half Adapted", ghosttyName: "Tango Half Adapted" },
        { id: "tearout", name: "Tearout", ghosttyName: "Tearout" },
        { id: "teerb", name: "Teerb", ghosttyName: "Teerb" },
        { id: "terafox", name: "Terafox", ghosttyName: "Terafox" },
        { id: "terminal-basic", name: "Terminal Basic", ghosttyName: "Terminal Basic" },
        { id: "terminal-basic-dark", name: "Terminal Basic Dark", ghosttyName: "Terminal Basic Dark" },
        { id: "thayer-bright", name: "Thayer Bright", ghosttyName: "Thayer Bright" },
        { id: "the-hulk", name: "The Hulk", ghosttyName: "The Hulk" },
        { id: "tinacious-design-dark", name: "Tinacious Design Dark", ghosttyName: "Tinacious Design Dark" },
        { id: "tinacious-design-light", name: "Tinacious Design Light", ghosttyName: "Tinacious Design Light" },
        { id: "tokyonight", name: "TokyoNight", ghosttyName: "TokyoNight" },
        { id: "tokyonight-day", name: "TokyoNight Day", ghosttyName: "TokyoNight Day" },
        { id: "tokyonight-moon", name: "TokyoNight Moon", ghosttyName: "TokyoNight Moon" },
        { id: "tokyonight-night", name: "TokyoNight Night", ghosttyName: "TokyoNight Night" },
        { id: "tokyonight-storm", name: "TokyoNight Storm", ghosttyName: "TokyoNight Storm" },
        { id: "tomorrow", name: "Tomorrow", ghosttyName: "Tomorrow" },
        { id: "tomorrow-night", name: "Tomorrow Night", ghosttyName: "Tomorrow Night" },
        { id: "tomorrow-night-blue", name: "Tomorrow Night Blue", ghosttyName: "Tomorrow Night Blue" },
        { id: "tomorrow-night-bright", name: "Tomorrow Night Bright", ghosttyName: "Tomorrow Night Bright" },
        { id: "tomorrow-night-burns", name: "Tomorrow Night Burns", ghosttyName: "Tomorrow Night Burns" },
        { id: "tomorrow-night-eighties", name: "Tomorrow Night Eighties", ghosttyName: "Tomorrow Night Eighties" },
        { id: "toy-chest", name: "Toy Chest", ghosttyName: "Toy Chest" },
        { id: "traffic", name: "traffic", ghosttyName: "traffic" },
        { id: "treehouse", name: "Treehouse", ghosttyName: "Treehouse" },
        { id: "twilight", name: "Twilight", ghosttyName: "Twilight" },
        { id: "ubuntu", name: "Ubuntu", ghosttyName: "Ubuntu" },
        { id: "ultra-dark", name: "Ultra Dark", ghosttyName: "Ultra Dark" },
        { id: "ultra-violent", name: "Ultra Violent", ghosttyName: "Ultra Violent" },
        { id: "under-the-sea", name: "Under The Sea", ghosttyName: "Under The Sea" },
        { id: "unikitty", name: "Unikitty", ghosttyName: "Unikitty" },
        { id: "urban", name: "urban", ghosttyName: "urban" },
        { id: "urple", name: "Urple", ghosttyName: "Urple" },
        { id: "vague", name: "Vague", ghosttyName: "Vague" },
        { id: "vaughn", name: "Vaughn", ghosttyName: "Vaughn" },
        { id: "vercel", name: "Vercel", ghosttyName: "Vercel" },
        { id: "vesper", name: "Vesper", ghosttyName: "Vesper" },
        { id: "vibrant-ink", name: "Vibrant Ink", ghosttyName: "Vibrant Ink" },
        { id: "vimbones", name: "Vimbones", ghosttyName: "Vimbones" },
        { id: "violet-dark", name: "Violet Dark", ghosttyName: "Violet Dark" },
        { id: "violet-light", name: "Violet Light", ghosttyName: "Violet Light" },
        { id: "violite", name: "Violite", ghosttyName: "Violite" },
        { id: "warm-neon", name: "Warm Neon", ghosttyName: "Warm Neon" },
        { id: "wez", name: "Wez", ghosttyName: "Wez" },
        { id: "whimsy", name: "Whimsy", ghosttyName: "Whimsy" },
        { id: "wild-cherry", name: "Wild Cherry", ghosttyName: "Wild Cherry" },
        { id: "wilmersdorf", name: "Wilmersdorf", ghosttyName: "Wilmersdorf" },
        { id: "wombat", name: "Wombat", ghosttyName: "Wombat" },
        { id: "wryan", name: "Wryan", ghosttyName: "Wryan" },
        { id: "xcode-dark", name: "Xcode Dark", ghosttyName: "Xcode Dark" },
        { id: "xcode-dark-hc", name: "Xcode Dark hc", ghosttyName: "Xcode Dark hc" },
        { id: "xcode-light", name: "Xcode Light", ghosttyName: "Xcode Light" },
        { id: "xcode-light-hc", name: "Xcode Light hc", ghosttyName: "Xcode Light hc" },
        { id: "xcode-wwdc", name: "Xcode WWDC", ghosttyName: "Xcode WWDC" },
        { id: "zenbones", name: "Zenbones", ghosttyName: "Zenbones" },
        { id: "zenbones-dark", name: "Zenbones Dark", ghosttyName: "Zenbones Dark" },
        { id: "zenbones-light", name: "Zenbones Light", ghosttyName: "Zenbones Light" },
        { id: "zenburn", name: "Zenburn", ghosttyName: "Zenburn" },
        { id: "zenburned", name: "Zenburned", ghosttyName: "Zenburned" },
        { id: "zenwritten-dark", name: "Zenwritten Dark", ghosttyName: "Zenwritten Dark" },
        { id: "zenwritten-light", name: "Zenwritten Light", ghosttyName: "Zenwritten Light" }
    ]

    property var theme: {
        for (var i = 0; i < themes.length; i++) {
            if (themes[i].id === currentTheme) return themes[i]
        }
        return themes[0]
    }

    function getCurrentIndex() {
        for (var i = 0; i < themes.length; i++) {
            if (themes[i].id === currentTheme) return i
        }
        return 0
    }

    function prevTheme() {
        var idx = getCurrentIndex()
        var newIdx = idx > 0 ? idx - 1 : themes.length - 1
        applyTheme(themes[newIdx].id)
    }

    function nextTheme() {
        var idx = getCurrentIndex()
        var newIdx = idx < themes.length - 1 ? idx + 1 : 0
        applyTheme(themes[newIdx].id)
    }

    function applyTheme(themeId) {
        // Find theme data by matching id
        var t = themes[0]
        for (var i = 0; i < themes.length; i++) {
            if (themes[i].id === themeId) { t = themes[i]; break }
        }

        var ghosttyName = t.ghosttyName

        // Build and execute theme change via Quickshell.execDetached
        // Remove existing theme lines and append at end (after all config-file entries)
        var bashCmd = 
            "sed -i '/^theme = /d' '" + ghosttyMainConfig + "'; " +
            "echo 'theme = " + ghosttyName + "' >> '" + ghosttyMainConfig + "'"

        Quickshell.execDetached(["bash", "-c", bashCmd])

        // Signal ghostty to reload via SIGUSR2
        Quickshell.execDetached(["bash", "-c", "pkill -SIGUSR2 ghostty 2>/dev/null || true"])

        // Update UI
        currentTheme = themeId
    }

    // Navbar Pills
    horizontalBarPill: Component {
        Row {
            spacing: Theme.spacingXS
            DankIcon { name: "palette"; size: root.iconSize; color: Theme.primary; anchors.verticalCenter: parent.verticalCenter }
            StyledText { text: root.theme.name; font.pixelSize: Theme.fontSizeSmall; color: Theme.surfaceText; anchors.verticalCenter: parent.verticalCenter }
        }
    }

    verticalBarPill: Component {
        Column {
            spacing: Theme.spacingXS
            DankIcon { name: "palette"; size: root.iconSize; color: Theme.primary; anchors.horizontalCenter: parent.horizontalCenter }
            StyledText { text: root.theme.name; font.pixelSize: Theme.fontSizeSmall; color: Theme.surfaceText; anchors.horizontalCenter: parent.horizontalCenter }
        }
    }

    // Popout
    popoutContent: Component {
        PopoutComponent {
            id: popout
            headerText: "Dank Terminal Theme"
            detailsText: root.showGridView ? "Select Theme" : root.theme.name
            showCloseButton: true

            // Content area - fixed width
            property real contentWidth: root.popoutWidth - Theme.spacingXL
            property real contentH: root.showGridView ? 200 : 160
            property real footerH: 40

            // Merged layout: content + footer in single Column
            Column {
                id: mainColumn
                spacing: 0

                // MAIN VIEW - Golden ratio color preview (no text)
                Item {
                    visible: !root.showGridView
                    width: popout.contentWidth
                    height: 200

                    property var themeColors: root.readThemeColors(root.theme.ghosttyName)
                    // Golden ratio constants
                    readonly property real phi: 1.618
                    readonly property real baseSize: 28
                    readonly property real smallSize: baseSize / phi
                    readonly property real tinySize: smallSize / phi

                    // Golden spiral positions (x, y, size) for 22 colors
                    // Arranged in golden ratio proportions
                    Item {
                        anchors.centerIn: parent

                        // Center: Background (largest)
                        Rectangle {
                            x: parent.width / 2 - baseSize / 2 + 30
                            y: parent.height / 2 - baseSize / 2 - 20
                            width: baseSize; height: baseSize
                            radius: 6
                            color: themeColors.background
                            border.width: 1; border.color: Theme.outline
                        }

                        // Foreground (golden size)
                        Rectangle {
                            x: parent.width / 2 - baseSize / 2 + 30 + baseSize + 4
                            y: parent.height / 2 - baseSize / 2 - 20
                            width: smallSize; height: baseSize
                            radius: 6
                            color: themeColors.foreground
                            border.width: 1; border.color: Theme.outline
                        }

                        // Cursor color (tiny)
                        Rectangle {
                            x: parent.width / 2 - baseSize / 2 + 30 + baseSize + 4 + smallSize + 4
                            y: parent.height / 2 - baseSize / 2 - 20
                            width: tinySize; height: tinySize
                            radius: 4
                            color: themeColors.cursorColor
                            border.width: 1; border.color: Theme.outline
                        }

                        // Cursor text (tiny)
                        Rectangle {
                            x: parent.width / 2 - baseSize / 2 + 30 + baseSize + 4 + smallSize + 4
                            y: parent.height / 2 - baseSize / 2 - 20 + tinySize + 4
                            width: tinySize; height: tinySize
                            radius: 4
                            color: themeColors.cursorText
                            border.width: 1; border.color: Theme.outline
                        }

                        // Selection bg (golden spiral next)
                        Rectangle {
                            x: parent.width / 2 - baseSize / 2 + 30
                            y: parent.height / 2 - baseSize / 2 + baseSize + 6
                            width: smallSize; height: smallSize
                            radius: 5
                            color: themeColors.selectionBackground
                            border.width: 1; border.color: Theme.outline
                        }

                        // Selection fg (smaller)
                        Rectangle {
                            x: parent.width / 2 - baseSize / 2 + 30 + smallSize + 4
                            y: parent.height / 2 - baseSize / 2 + baseSize + 6
                            width: smallSize / phi; height: smallSize / phi
                            radius: 4
                            color: themeColors.selectionForeground
                            border.width: 1; border.color: Theme.outline
                        }

                        // Palette 0-7 (golden row)
                        Repeater {
                            model: 8
                            Rectangle {
                                x: parent.width / 2 - (8 * (smallSize + 2)) / 2 + index * (smallSize + 2)
                                y: parent.height / 2 - baseSize / 2 + 5
                                width: smallSize; height: smallSize
                                radius: 4
                                color: themeColors.palette[index] || "#888888"
                                border.width: 1; border.color: Theme.outline
                            }
                        }

                        // Palette 8-15 (second golden row)
                        Repeater {
                            model: 8
                            Rectangle {
                                x: parent.width / 2 - (8 * (smallSize + 2)) / 2 + index * (smallSize + 2)
                                y: parent.height / 2 - baseSize / 2 + 5 + smallSize + 6
                                width: smallSize; height: smallSize
                                radius: 4
                                color: themeColors.palette[index + 8] || "#888888"
                                border.width: 1; border.color: Theme.outline
                            }
                        }
                    }

                    StyledText {
                        text: "Click 'All' to switch themes"
                        font.pixelSize: 10
                        color: Theme.outline
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottomMargin: 6
                    }
                }

                // GRID VIEW (theme list)
                Item {
                    visible: root.showGridView
                    width: popout.contentWidth
                    height: 200

                    Flickable {
                        width: parent.width
                        height: parent.height
                        contentHeight: listCol.height
                        clip: true

                        Column {
                            id: listCol
                            spacing: 6
                            width: popout.contentWidth

                            Repeater {
                                model: root.themes

                                delegate: Rectangle {
                                    width: popout.contentWidth
                                    height: 68
                                    radius: 10
                                    color: modelData.id === root.currentTheme ? Theme.primaryContainer : Theme.surfaceContainerHigh
                                    border.width: modelData.id === root.currentTheme ? 2 : 0
                                    border.color: Theme.primary || "#000000"

                                    property var itemThemeColors: root.readThemeColors(modelData.ghosttyName)

                                    Row {
                                        spacing: 10
                                        anchors.left: parent.left; anchors.leftMargin: 12
                                        anchors.right: parent.right; anchors.rightMargin: 12
                                        anchors.verticalCenter: parent.verticalCenter

                                        DankIcon {
                                            name: "palette"; size: 18; color: Theme.primary
                                            anchors.verticalCenter: parent.verticalCenter
                                        }

                                        Column {
                                            spacing: 2
                                            anchors.verticalCenter: parent.verticalCenter

                                            StyledText {
                                                text: modelData.name; font.pixelSize: 13; font.weight: Font.Medium
                                                color: modelData.id === root.currentTheme ? Theme.onPrimaryContainer : Theme.surfaceText
                                            }

                                            // Color swatches row: bg, fg, cursor, cursorText, selectionBg, selectionFg
                                            Row {
                                                spacing: 2

                                                // Background
                                                Rectangle {
                                                    width: 12; height: 12; radius: 2
                                                    color: parent.parent.parent.itemThemeColors.background
                                                    border.width: 1; border.color: Theme.outline
                                                }
                                                // Foreground
                                                Rectangle {
                                                    width: 12; height: 12; radius: 2
                                                    color: parent.parent.parent.itemThemeColors.foreground
                                                    border.width: 1; border.color: Theme.outline
                                                }
                                                // Cursor
                                                Rectangle {
                                                    width: 12; height: 12; radius: 2
                                                    color: parent.parent.parent.itemThemeColors.cursorColor
                                                    border.width: 1; border.color: Theme.outline
                                                }
                                                // Cursor text
                                                Rectangle {
                                                    width: 12; height: 12; radius: 2
                                                    color: parent.parent.parent.itemThemeColors.cursorText
                                                    border.width: 1; border.color: Theme.outline
                                                }
                                                // Selection bg
                                                Rectangle {
                                                    width: 12; height: 12; radius: 2
                                                    color: parent.parent.parent.itemThemeColors.selectionBackground
                                                    border.width: 1; border.color: Theme.outline
                                                }
                                                // Selection fg
                                                Rectangle {
                                                    width: 12; height: 12; radius: 2
                                                    color: parent.parent.parent.itemThemeColors.selectionForeground
                                                    border.width: 1; border.color: Theme.outline
                                                }

                                                // Divider
                                                Rectangle {
                                                    width: 1; height: 12
                                                    color: Theme.outline
                                                    anchors.verticalCenter: parent.verticalCenter
                                                }

                                                // Full 16-color palette (8 colors visible, smaller)
                                                Repeater {
                                                    model: 8

                                                    Rectangle {
                                                        width: 10; height: 12; radius: 2
                                                        color: parent.parent.parent.itemThemeColors.palette[index] || "#888888"
                                                        border.width: 1; border.color: Theme.outline
                                                    }
                                                }
                                            }
                                        }

                                        DankIcon {
                                            name: "check_circle"; size: 16; color: Theme.primary
                                            visible: modelData.id === root.currentTheme
                                            anchors.verticalCenter: parent.verticalCenter
                                        }
                                    }

                                    MouseArea {
                                        width: parent.width; height: parent.height
                                        hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                                        onClicked: { root.showGridView = false; root.applyTheme(modelData.id) }
                                    }
                                }
                            }
                        }
                    }
                }

                // MERGED FOOTER - no border, blends with content
                Row {
                    spacing: 0
                    width: popout.contentWidth
                    height: popout.footerH

                    // Prev arrow
                    Rectangle {
                        width: parent.width / 3
                        height: parent.height
                        radius: 8
                        color: prevArea.containsMouse ? Theme.surfaceContainerHigh : "transparent"

                        DankIcon {
                            name: "chevron_left"; size: 20; color: Theme.surfaceText
                            anchors.centerIn: parent
                        }

                        MouseArea {
                            id: prevArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.prevTheme()
                        }
                    }

                    // Grid/List toggle
                    Rectangle {
                        width: parent.width / 3
                        height: parent.height
                        radius: 8
                        color: gridArea.containsMouse ? Theme.surfaceContainerHigh : "transparent"

                        Row {
                            spacing: 4
                            anchors.centerIn: parent
                            DankIcon {
                                name: root.showGridView ? "view_agenda" : "grid_view"
                                size: 16; color: Theme.surfaceText
                                anchors.verticalCenter: parent.verticalCenter
                            }
                            StyledText {
                                text: root.showGridView ? "Back" : "All"
                                font.pixelSize: 12; color: Theme.surfaceText
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }

                        MouseArea {
                            id: gridArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.showGridView = !root.showGridView
                        }
                    }

                    // Next arrow
                    Rectangle {
                        width: parent.width / 3
                        height: parent.height
                        radius: 8
                        color: nextArea.containsMouse ? Theme.surfaceContainerHigh : "transparent"

                        DankIcon {
                            name: "chevron_right"; size: 20; color: Theme.surfaceText
                            anchors.centerIn: parent
                        }

                        MouseArea {
                            id: nextArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.nextTheme()
                        }
                    }
                }
            }
        }
    }

    popoutWidth: 316
    popoutHeight: 220

    Component.onCompleted: {
        console.info("DankTerminalTheme loaded:", currentTheme)
        // Pre-generate theme colors cache via bash
        var cmd = 'for f in /usr/share/ghostty/themes/*; do name=$(basename "$f"); echo "$name:"; cat "$f"; echo "---END---"; done > /tmp/ghostty_themes_cache.txt'
        Quickshell.execDetached(["bash", "-c", cmd])
    }
}