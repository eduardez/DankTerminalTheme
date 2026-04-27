// DankTerminalThemeSettings.qml
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
        text: "Real-time Ghostty theme management with 24 curated themes"
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

    StyledText {
        text: "Configuration"
        font.pixelSize: Theme.fontSizeMedium
        font.weight: Font.DemiBold
        color: Theme.surfaceText
    }

    ToggleSetting {
        settingKey: "showThemeNameInBar"
        label: "Show Theme Name in Bar"
        description: "Display the current theme name next to the icon"
        defaultValue: true
    }

    ToggleSetting {
        settingKey: "showColorPreview"
        label: "Show Color Preview"
        description: "Display theme color palette in the popout"
        defaultValue: true
    }

    StringSetting {
        settingKey: "ghosttyConfigPath"
        label: "Ghostty Config Path"
        description: "Path to Ghostty config file (relative to home)"
        placeholder: ".config/ghostty/config"
        defaultValue: ".config/ghostty/config"
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
        text: "• Click the palette icon in the bar to open the theme picker\n• Use arrows to cycle through themes or 'All' for grid view\n• Search by typing in the grid view\n• Themes apply instantly via SIGUSR2 signal to Ghostty"
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.surfaceVariantText
        width: parent.width
        wrapMode: Text.WordWrap
    }
}
