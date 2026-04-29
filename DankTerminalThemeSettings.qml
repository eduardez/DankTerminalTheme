import QtQuick
import qs.Common
import qs.Modules.Plugins
import qs.Widgets

PluginSettings {
    id: root
    pluginId: "dankterminaltheme"

    StyledText {
        text: "Dank Terminal Theme"
        font.pixelSize: Theme.fontSizeLarge
        font.weight: Font.Bold
        color: Theme.surfaceText
    }

    StyledText {
        text: "Real-time terminal theme management supporting Ghostty, Kitty, Alacritty, and WezTerm with 76 built-in themes"
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.surfaceVariantText
        width: parent.width
        wrapMode: Text.WordWrap
    }

    StyledRect {
        width: parent.width
        height: 1
        color: Theme.surfaceVariant
    }
    
    SelectionSetting {
        settingKey: "terminal"
        label: "Terminal Emulator"
        description: "Select which terminal emulator to theme"
        options: [
            { label: "Ghostty", value: "ghostty" },
            { label: "Kitty", value: "kitty" },
            { label: "Alacritty", value: "alacritty" },
            { label: "WezTerm", value: "wezterm" }
        ]
        defaultValue: "ghostty"
    }

    StyledRect {
        width: parent.width
        height: 1
        color: Theme.surfaceVariant
    }

    StyledText {
        text: "Configuration"
        font.pixelSize: Theme.fontSizeMedium
        font.weight: Font.DemiBold
        color: Theme.surfaceText
    }

    ToggleSetting {
        settingKey: "showAllThemes"
        label: "Show All Themes"
        description: "Show all 76 themes instead of the curated 21"
        defaultValue: false
    }

    ToggleSetting {
        settingKey: "showArrows"
        label: "Show Footer"
        description: "Show footer arrows and terminal selector in the popout footer"
        defaultValue: true
    }

    SelectionSetting {
        settingKey: "gridColumns"
        label: "Grid Columns"
        description: "Number of columns in the theme grid"
        options: [
            { label: "3", value: 3 },
            { label: "4", value: 4 },
            { label: "5", value: 5 },
            { label: "6", value: 6 }
        ]
        defaultValue: "4"
    }

    StyledRect {
        width: parent.width
        height: 1
        color: Theme.surfaceVariant
    }

    StyledText {
        text: "Config Paths"
        font.pixelSize: Theme.fontSizeMedium
        font.weight: Font.DemiBold
        color: Theme.surfaceText
    }

    StringSetting {
        settingKey: "ghosttyConfigPath"
        label: "Ghostty Config Path"
        description: "Path to Ghostty config file"
        placeholder: "$HOME/.config/ghostty/config"
        defaultValue: "$HOME/.config/ghostty/config"
    }

    StyledRect {
        width: parent.width
        height: 1
        color: Theme.surfaceVariant
    }

    StyledText {
        text: "How It Works"
        font.pixelSize: Theme.fontSizeMedium
        font.weight: Font.DemiBold
        color: Theme.surfaceText
    }

    StyledText {
        text: "• Select your terminal emulator in the popout or settings\n• Click a color swatch to apply that theme\n• Use arrows to cycle through themes\n• Ghostty: applies via config + SIGUSR2 signal\n• Kitty: applies via kitten themes --reload-in=all\n• Alacritty: swaps theme symlinks (requires alacritty-theme repo)\n• WezTerm: updates color_scheme in Lua config"
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.surfaceVariantText
        width: parent.width
        wrapMode: Text.WordWrap
    }
}
