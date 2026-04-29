# Dank Terminal Theme for Dank Material Shell

[![RELEASE](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2Feduardez%2FDankTerminalTheme%2Frefs%2Fheads%2Fmain%2Fplugin.json&query=version&style=for-the-badge&label=RELEASE&labelColor=101418&color=9ccbfb)](https://github.com/eduardez/DankTerminalTheme)

A bar widget that lets you manage your terminal emulator theme from your desktop, with instant hot-reload and a curated color grid. Supports **Ghostty**, **Kitty**, **Alacritty**, and **WezTerm**.

![Dank Terminal Theme Screenshot](https://raw.githubusercontent.com/eduardez/DankTerminalTheme/main/assets/screenshot.png)

![Dank Terminal Theme Screenshot1](https://raw.githubusercontent.com/eduardez/DankTerminalTheme/main/assets/screenshot_1.png)

![Dank Terminal Theme Screenshot2](https://raw.githubusercontent.com/eduardez/DankTerminalTheme/main/assets/screenshot_2.png)

## Features

- **Multi-terminal support**: Switch themes for Ghostty, Kitty, Alacritty, and WezTerm from the same widget
- **Terminal dropdown selector**: Pick your active terminal from a dropdown between the navigation arrows
- **76 built-in themes**: 21 curated popular themes + 55 additional, with real color previews
- **Instant hot-reload**: Themes apply without restarting the terminal
- **Color grid**: See actual background, foreground, and accent colors at a glance
- **Navigation arrows**: Cycle through themes with prev/next buttons
- **Persistent selection**: Remembers your last theme and terminal across sessions
- **Configurable grid**: Choose 3, 4, 5, or 6 columns in settings

## Requirements

- Dank Material Shell (DMS) >= 1.4.0
- At least one of the following terminal emulators:
  - **Ghostty** - no additional setup required
  - **Kitty** - uses the built-in `kitty +kitten themes` system
  - **Alacritty** - requires internet connection on first use (themes are downloaded from the [alacritty-theme](https://github.com/alacritty/alacritty-theme) repository and cached locally)
  - **WezTerm** - no additional setup required

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

### Selecting a Terminal

1. Click the palette icon in your navbar to open the theme picker
2. Click the **terminal name** dropdown (between the arrows) to select your terminal emulator
3. Explore the themes

### Switching Themes

1. Click any color swatch in the grid to apply it instantly
2. The current theme is highlighted with a colored border and indicator dot

### Navigation Arrows

Use the **prev/next** arrows to cycle through themes sequentially. The terminal selector dropdown sits between them.

### Grid View

The popout shows a color grid with actual background, foreground, and accent color previews. Configure the number of columns in Settings (default: 4).

### Settings

| Setting | Description | Default |
|---------|-------------|---------|
| Terminal Emulator | Which terminal to apply themes to | Ghostty |
| Show All Themes | Show all 76 themes instead of just the main ones | Off |
| Grid Columns | Number of columns in the color grid | 4 |
| Ghostty Config Path | Custom path to Ghostty config (relative to home) | `~/.config/ghostty/config` |
| Show Navigation Arrows | Show prev/next arrows in the popout footer | On |

## How It Works

Each terminal emulator has a different theming mechanism. The plugin handles all of them transparently.

### Ghostty

Uses Ghostty's native `theme` configuration option with built-in themes.

1. Removes the old `theme = ` line from `~/.config/ghostty/config`
2. Appends `theme = <name>` to the config file
3. Sends `SIGUSR2` to all Ghostty processes to trigger a config reload

If `SIGUSR2` is not available, manually reload with `Ctrl+Shift+,` in Ghostty.

### Kitty

Uses Kitty's built-in theme system via `kitty +kitten themes --dump-theme`.

1. Dumps the selected theme content using `kitty +kitten themes --dump-theme <name>`
2. Writes the output to `~/.config/kitty/current-theme.conf`
3. Ensures `include current-theme.conf` is present in `~/.config/kitty/kitty.conf`
4. Sends `SIGUSR1` to all Kitty processes to trigger a config reload

Requires Kitty's built-in themes (included by default).

### Alacritty

Downloads and caches theme TOML files from the [alacritty-theme](https://github.com/alacritty/alacritty-theme) repository.

1. On first use, downloads the theme TOML from GitHub (`master` branch) to `~/.config/alacritty/themes/themes/`
2. Creates a symlink at `~/.config/alacritty/active-theme.toml` pointing to the selected theme file
3. Ensures `import = [ "~/.config/alacritty/active-theme.toml" ]` is present in `~/.config/alacritty/alacritty.toml`
4. Alacritty auto-reloads when the config file is touched

**Note**: First-time theme application requires an internet connection to download the theme file. Subsequent uses are served from the local cache.

### WezTerm

Modifies the `color_scheme` setting in WezTerm's Lua configuration.

1. If no config exists, creates `~/.config/wezterm/wezterm.lua` with a minimal configuration including the color scheme
2. If a config exists, uses `sed` to replace the `color_scheme = "..."` line
3. WezTerm auto-reloads on config file changes

**Note**: If you have a custom `wezterm.lua`, the plugin looks for a `color_scheme` assignment and replaces it. Complex configs may need manual adjustment.

## Theme Coverage

Not all 76 themes are available for every terminal. When a theme isn't available for a terminal, the closest alternative is used (e.g., "Iceberg Dark" maps to "Iceberg" in Kitty).

| Terminal | Available Themes | Notes |
|----------|-----------------|-------|
| Ghostty | 76/76 | All themes available |
| Kitty | ~58/76 | Uses closest match when exact theme unavailable |
| Alacritty | ~53/76 | Depends on themes in the alacritty-theme repo |
| WezTerm | ~63/76 | 600+ built-in color schemes, many match by name |



## Permissions

- `settings_read` / `settings_write` - persist theme selection, terminal choice, and settings
- `process` - update terminal configs, send signals, and download theme files

## Files

- `plugin.json` - Plugin manifest
- `DankTerminalTheme.qml` - Main widget: themes array, color grid popout, per-terminal apply logic
- `DankTerminalThemeSettings.qml` - Settings panel with terminal selector
- `README.md` - This file

## Author

EduarD3V

## License

Same as DankMaterialShell
