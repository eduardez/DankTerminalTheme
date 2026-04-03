# Dank Terminal Theme for Dank Material Shell

**Dank Terminal Theme** is a lightweight plugin for Dank Material Shell (DMS) that bridges the gap between desktop aesthetics and terminal environments. It places theme management directly in the user's workflow—the navbar—starting with native support for the Ghostty terminal emulator.

## Features

- **Navbar Quick-Switcher**: Click the palette icon in the navbar to access the theme gallery
- **8 Built-in Ghostty Themes**: Nord, Gruvbox Dark, Catppuccin Mocha/Latte, Dracula, Atom One Dark, GitHub Dark, Builtin Solarized Dark
- **Live Preview**: Color swatches show theme colors before applying
- **Instant Hot-Reload**: Ghostty themes apply via SIGUSR2 signal without restart
- **Persistent Selection**: Remembers last selected theme across sessions

## Requirements

- Dank Material Shell (DMS) >= 1.4.0
- Ghostty terminal emulator (version 1.2.0+ recommended for SIGUSR2 support)

## Installation

1. Copy this folder to `~/.config/DankMaterialShell/plugins/DankTerminalTheme/`
2. Open DMS Settings → Plugins → Scan for Plugins
3. Enable "Dank Terminal Theme"
4. Add to DankBar widget list
5. Restart DMS: `dms restart`

## Usage

1. Click the Dank Terminal Theme icon (palette) in the navbar to open the theme picker
2. Use **Prev/Next** arrows or toggle **All** to open grid view
3. Click any theme to apply it instantly to Ghostty
4. Ghostty receives the new theme via SIGUSR2 signal and reloads

## Working Principle

Dank Terminal Theme uses Ghostty's native `theme` configuration option to switch between built-in themes. This leverages Ghostty's own theme system rather than writing custom color files.

### Theme Application Flow

1. User selects a theme in Dank Terminal Theme's navbar popout
2. Dank Terminal Theme updates `theme = <theme_name>` in Ghostty's config using sed
3. Dank Terminal Theme sends `SIGUSR2` to all Ghostty processes
4. Ghostty's signal handler triggers a config reload and applies the new theme
5. Theme changes apply instantly without restarting Ghostty

### File Structure

```
~/.config/ghostty/
└── config                      # Ghostty main config
                                 # Contains: theme = <built-in-theme-name>
```

### Available Themes

The plugin provides these Ghostty built-in themes:
- **Nord** - Arctic north-inspired colors
- **Gruvbox Dark** - Retro groove colors
- **Catppuccin Mocha** - Dark mode with pastel accents
- **Catppuccin Latte** - Light mode with pastel accents
- **Dracula** - Dark mode with vibrant colors
- **Atom One Dark** - One Dark color scheme
- **GitHub Dark** - GitHub's dark theme
- **Builtin Solarized Dark** - Solarized dark palette

### Ghostty Signal Handling

Ghostty handles `SIGUSR2` to trigger configuration reload. This is the recommended method for external applications to trigger theme updates. If SIGUSR2 is not available in your Ghostty version, manually reload with `Ctrl+Shift+,` in Ghostty.

## Architecture

```
DankTerminalTheme/
├── plugin.json           # Plugin manifest (name, author, version, permissions)
├── DankTerminalTheme.qml            # Main widget component
│                          # - applyTheme(): sets theme config + signals ghostty
│                          # - 8 built-in Ghostty themes with preview colors
│                          # - Navbar pills (horizontal/vertical)
│                          # - Popout UI with prev/next/all navigation
├── DankTerminalThemeSettings.qml    # Settings panel (basic stub)
└── README.md
```

## Permissions

Dank Terminal Theme requires:
- `settings_read` / `settings_write` - persist theme selection
- `process` - update ghostty config and signal Ghostty

## Credits

- Themes sourced from Ghostty's built-in theme library (iterm2-color-schemes)
- Plugin: Dank Terminal Theme by EduarD3V
- Version: 1.0.1-beta.2