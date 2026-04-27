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
        text: "Real-time Ghostty theme management with 98 built-in themes"
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
        settingKey: "showAllThemes"
        label: "Show All Themes"
        description: "Show all 98 themes instead of the curated 21"
        defaultValue: false
    }

    SelectionSetting {
        settingKey: "gridColumns"
        label: "Grid Columns"
        description: "Number of columns in the theme grid"
        values: ["3", "4", "5", "6"]
        defaultIndex: 1
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
        text: "• Click the palette icon in the bar to open the theme picker\n• Use arrows to cycle through themes\n• Click a color swatch to apply that theme\n• Themes apply instantly via SIGUSR2 signal to Ghostty"
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.surfaceVariantText
        width: parent.width
        wrapMode: Text.WordWrap
    }
}
