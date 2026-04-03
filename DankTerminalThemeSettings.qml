// DankTerminalThemeSettings.qml
import QtQuick
import qs.Common
import qs.Modules.Plugins
import qs.Widgets

PluginSettings {
    id: root
    pluginId: "dankterminaltheme"

    StyledText {
        width: parent.width
        text: "Dank Terminal Theme"
        font.pixelSize: Theme.fontSizeLarge
        font.weight: Font.Bold
        color: Theme.surfaceText
    }

    StyledText {
        width: parent.width
        text: "Terminal Theme Manager for Ghostty"
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.surfaceVariantText
    }
}