# Dank Terminal Theme for Dank Material Shell

[![RELEASE](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2Feduardez%2FDankTerminalTheme%2Frefs%2Fheads%2Fmain%2Fplugin.json&query=version&style=for-the-badge&label=RELEASE&labelColor=101418&color=9ccbfb)](https://github.com/eduardez/DankTerminalTheme)

A bar widget that lets you manage your Ghostty terminal theme from your desktop, with instant hot-reload and a curated color grid.

![Dank Terminal Theme Screenshot](https://raw.githubusercontent.com/eduardez/DankTerminalTheme/main/assets/screenshot.png)

![Dank Terminal Theme Screenshot1](https://raw.githubusercontent.com/eduardez/DankTerminalTheme/main/assets/screenshot_1.png)

![Dank Terminal Theme Screenshot2](https://raw.githubusercontent.com/eduardez/DankTerminalTheme/main/assets/screenshot_2.png)


## Features

- **Navbar theme picker**: Click the palette icon to open the theme gallery popout
- **98 curated themes**: 21 hand-picked popular themes + 77 additional, with real color previews
- **Instant hot-reload**: Ghostty themes apply via `SIGUSR2` signal without restart
- **Color grid**: See actual background, foreground, and accent colors at a glance
- **Navigation arrows**: Cycle through themes with prev/next buttons
- **Persistent selection**: Remembers your last theme across sessions
- **Configurable grid**: Choose 3, 4, 5, or 6 columns in settings

## Requirements

- Dank Material Shell (DMS) >= 1.4.0
- Ghostty terminal emulator

## Installation

### Via DMS

```bash
dms plugins install DankTerminalTheme
```

### Via DMS GUI

1. Open DMS Settings (`Mod+,`) and go to the Plugins tab
2. Click **Browse**
3. Find **Dank Terminal Theme** and click **Install**

### Manually

```bash
cd ~/.config/DankMaterialShell/plugins
git clone https://github.com/eduardez/DankTerminalTheme.git
```

1. Open DMS Settings (`Mod+,`) and go to the Plugins tab
2. Click **Scan for plugins**
3. Enable the **Dank Terminal Theme** plugin

## Usage

### Switching Themes

1. Click the palette icon in your navbar to open the theme picker
2. Click any color swatch in the grid to apply it instantly
3. The current theme is highlighted with a colored border and indicator dot

### Navigation Arrows

Use the **prev/next** arrows at the bottom of the popout to cycle through themes sequentially. Arrows can be hidden via settings.

### Grid View

The popout shows a color grid with actual background, foreground, and accent color previews. Configure the number of columns in Settings (default: 4).

### Settings

| Setting | Description | Default |
|---------|-------------|---------|
| Show All Themes | Show all 98 themes instead of just the 21 curated ones | Off |
| Grid Columns | Number of columns in the color grid | 4 |
| Ghostty Config Path | Custom path to Ghostty config (relative to home) | `~/.config/ghostty/config` |
| Show Navigation Arrows | Show prev/next arrows in the popout footer | On |

## How It Works

The plugin uses Ghostty's native `theme` configuration option to switch between built-in themes.

1. User selects a theme in the popout
2. Plugin removes the old `theme = ` line from Ghostty's config
3. Appends `theme = <name>` to the config file
4. Sends `SIGUSR2` to all Ghostty processes to trigger a config reload
5. Theme applies instantly without restarting Ghostty

If `SIGUSR2` is not available, manually reload with `Ctrl+Shift+,` in Ghostty.

## Permissions

- `settings_read` / `settings_write` - persist theme selection and settings
- `process` - update Ghostty config and send signals

## Files

- `plugin.json` - Plugin manifest
- `DankTerminalTheme.qml` - Main widget: themes array, color grid popout, apply logic
- `DankTerminalThemeSettings.qml` - Settings panel
- `README.md` - This file

## Author

EduarD3V

## License

Same as DankMaterialShell
