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
    property string searchQuery: ""

    readonly property string homePath: {
        try {
            var h = process.env.HOME
            if (h && h.length > 0) return h
            return "/home/" + (process.env.USER || "")
        } catch(e) {
            return "/home/eduardez"
        }
    }
    readonly property string ghosttyConfigDir: homePath + "/.config/ghostty"
    readonly property string ghosttyMainConfig: ghosttyConfigDir + "/config"

    readonly property var themes: [
        { id: "nord", name: "Nord", ghosttyName: "Nord", bg: "#2e3440", fg: "#d8dee9", accent: "#88c0d0" },
        { id: "catppuccin-mocha", name: "Catppuccin Mocha", ghosttyName: "Catppuccin Mocha", bg: "#1e1e2e", fg: "#cdd6f4", accent: "#89b4fa" },
        { id: "catppuccin-macchiato", name: "Catppuccin Macchiato", ghosttyName: "Catppuccin Macchiato", bg: "#24273a", fg: "#cad3f5", accent: "#8aadf4" },
        { id: "catppuccin-frappe", name: "Catppuccin Frappe", ghosttyName: "Catppuccin Frappe", bg: "#303446", fg: "#c6d0f5", accent: "#8caaee" },
        { id: "tokyonight", name: "TokyoNight", ghosttyName: "TokyoNight", bg: "#1a1b26", fg: "#c0caf5", accent: "#7aa2f7" },
        { id: "tokyonight-storm", name: "TokyoNight Storm", ghosttyName: "TokyoNight Storm", bg: "#24283b", fg: "#c0caf5", accent: "#7aa2f7" },
        { id: "tokyonight-moon", name: "TokyoNight Moon", ghosttyName: "TokyoNight Moon", bg: "#222436", fg: "#c8d3f5", accent: "#82aaff" },
        { id: "dracula", name: "Dracula", ghosttyName: "Dracula", bg: "#282a36", fg: "#f8f8f2", accent: "#bd93f9" },
        { id: "gruvbox-dark", name: "Gruvbox Dark", ghosttyName: "Gruvbox Dark", bg: "#282828", fg: "#ebdbb2", accent: "#83a598" },
        { id: "gruvbox-dark-hard", name: "Gruvbox Dark Hard", ghosttyName: "Gruvbox Dark Hard", bg: "#1d2021", fg: "#ebdbb2", accent: "#83a598" },
        { id: "rose-pine", name: "Rose Pine", ghosttyName: "Rose Pine", bg: "#191724", fg: "#e0def4", accent: "#c4a7e7" },
        { id: "rose-pine-moon", name: "Rose Pine Moon", ghosttyName: "Rose Pine Moon", bg: "#232136", fg: "#e0def4", accent: "#c4a7e7" },
        { id: "github-dark", name: "GitHub Dark", ghosttyName: "GitHub Dark", bg: "#101216", fg: "#8b949e", accent: "#6ca4f8" },
        { id: "monokai-pro", name: "Monokai Pro", ghosttyName: "Monokai Pro", bg: "#2d2a2e", fg: "#fcfcfa", accent: "#ab9df2" },
        { id: "kanagawa-wave", name: "Kanagawa Wave", ghosttyName: "Kanagawa Wave", bg: "#1f1f28", fg: "#dcd7ba", accent: "#7e9cd8" },
        { id: "kanagawa-dragon", name: "Kanagawa Dragon", ghosttyName: "Kanagawa Dragon", bg: "#181616", fg: "#c8c093", accent: "#8ba4b0" },
        { id: "ayu-mirage", name: "Ayu Mirage", ghosttyName: "Ayu Mirage", bg: "#1f2430", fg: "#cccac2", accent: "#6dcbfa" },
        { id: "one-dark", name: "One Dark", ghosttyName: "Atom One Dark", bg: "#21252b", fg: "#abb2bf", accent: "#61afef" },
        { id: "everforest-dark", name: "Everforest Dark Hard", ghosttyName: "Everforest Dark Hard", bg: "#1e2326", fg: "#d3c6aa", accent: "#7fbbb3" },

        { id: "catppuccin-latte", name: "Catppuccin Latte", ghosttyName: "Catppuccin Latte", bg: "#eff1f5", fg: "#4c4f69", accent: "#1e66f5" },
        { id: "gruvbox-light", name: "Gruvbox Light", ghosttyName: "Gruvbox Light", bg: "#fbf1c7", fg: "#3c3836", accent: "#458588" },
        { id: "rose-pine-dawn", name: "Rose Pine Dawn", ghosttyName: "Rose Pine Dawn", bg: "#faf4ed", fg: "#575279", accent: "#907aa9" }
    ]

    readonly property var themeMap: {
        var map = {}
        for (var i = 0; i < themes.length; i++) map[themes[i].id] = themes[i]
        return map
    }

    readonly property var filteredThemes: {
        if (!searchQuery) return themes
        var q = searchQuery.toLowerCase()
        return themes.filter(function(t) {
            return t.name.toLowerCase().indexOf(q) !== -1 || t.id.indexOf(q) !== -1
        })
    }

    property var theme: themeMap[currentTheme] || themes[0]

    function prevTheme() {
        var idx = themes.indexOf(theme)
        applyTheme(themes[idx > 0 ? idx - 1 : themes.length - 1].id)
    }

    function nextTheme() {
        var idx = themes.indexOf(theme)
        applyTheme(themes[idx < themes.length - 1 ? idx + 1 : 0].id)
    }

    function applyTheme(themeId) {
        var t = themeMap[themeId]
        if (!t) return
        var ghosttyName = t.ghosttyName
        var bashCmd =
            "sed -i -e '/^theme = /d' -e '/^config-file = themes\\//d' '" + ghosttyMainConfig + "'; " +
            "echo 'theme = " + ghosttyName + "' >> '" + ghosttyMainConfig + "'"
        Quickshell.execDetached(["bash", "-c", bashCmd])
        Quickshell.execDetached(["bash", "-c", "pkill -SIGUSR2 ghostty 2>/dev/null || true"])
        currentTheme = themeId
        pluginData.currentTheme = themeId
    }

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

    popoutContent: Component {
        PopoutComponent {
            id: popout
            headerText: "Terminal Theme"
            detailsText: root.theme.name
            showCloseButton: true

            property real cw: root.popoutWidth - Theme.spacingXL

            Column {
                id: mainCol
                spacing: Theme.spacingS
                width: popout.cw

                // Current theme preview (compact)
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
                    height: 200
                    cellWidth: popout.cw / 3
                    cellHeight: 52
                    model: root.filteredThemes
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

                // Footer nav
                Row {
                    spacing: 0
                    width: popout.cw
                    height: 36

                    Rectangle {
                        width: parent.width / 3
                        height: parent.height
                        radius: 8
                        color: prevArea.containsMouse ? Theme.surfaceContainerHigh : "transparent"
                        DankIcon { name: "chevron_left"; size: 18; color: Theme.surfaceText; anchors.centerIn: parent }
                        MouseArea { id: prevArea; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: root.prevTheme() }
                    }

                    Rectangle {
                        width: parent.width / 3
                        height: parent.height
                        radius: 8
                        color: searchArea.containsMouse ? Theme.surfaceContainerHigh : "transparent"
                        DankIcon { name: "search"; size: 16; color: Theme.surfaceText; anchors.centerIn: parent }
                        MouseArea {
                            id: searchArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                searchField.visible = !searchField.visible
                                if (searchField.visible) searchField.forceActiveFocus()
                            }
                        }
                    }

                    Rectangle {
                        width: parent.width / 3
                        height: parent.height
                        radius: 8
                        color: nextArea.containsMouse ? Theme.surfaceContainerHigh : "transparent"
                        DankIcon { name: "chevron_right"; size: 18; color: Theme.surfaceText; anchors.centerIn: parent }
                        MouseArea { id: nextArea; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor; onClicked: root.nextTheme() }
                    }
                }

                // Search field (hidden by default)
                DankTextField {
                    id: searchField
                    visible: false
                    width: popout.cw
                    height: 32
                    placeholderText: "Search..."
                    onTextChanged: root.searchQuery = text
                    leftIconName: "search"
                    leftIconSize: 16
                }
            }
        }
    }

    popoutWidth: 320
    popoutHeight: 320

    Component.onCompleted: console.info("DankTerminalTheme loaded:", currentTheme)
}
