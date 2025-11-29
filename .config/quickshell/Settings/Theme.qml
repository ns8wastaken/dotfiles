pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    function applyOpacity(color, opacity) {
        return color.replace('#', '#' + opacity);
    }

    // FileView to load theme data from JSON file
    FileView {
        path: Quickshell.shellDir + "/Settings/Theme.json"

        watchChanges: true
        onFileChanged: this.reload()

        onLoadFailed: console.log("Error while loading theme (this may be a complete lie)")

        adapter: JsonAdapter {
            id: themeData

            // Backgrounds
            property string backgroundPrimary: "#0C0D11"
            property string backgroundSecondary: "#151720"
            property string backgroundTertiary: "#1D202B"

            // Accent Colors
            property string accentPrimary: "#A8AEFF"
            property string accentSecondary: "#9EA0FF"
            property string accentTertiary: "#8EABFF"

            // Text Colors
            property string textPrimary: "#CACEE2"
            property string textSecondary: "#B7BBD0"
            property string textDisabled: "#6B718A"
            property string textDark: "#0C0D11"
            property string textLight: "#F3DEFF"

            // Styling
            property string outline: "#44485A"
            property string highlight: "#E3C2FF"

            // Error/Warning
            property string error: "#FF6B81"
            property string warning: "#FFBB66"

            // Surfaces & Elevation
            property string surface: "#1A1C26"
            property string surfaceVariant: "#2A2D3A"
        }
    }

    // Backgrounds
    property color backgroundPrimary: themeData.backgroundPrimary
    property color backgroundSecondary: themeData.backgroundSecondary
    property color backgroundTertiary: themeData.backgroundTertiary

    // Accent Colors
    property color accentPrimary: themeData.accentPrimary
    property color accentSecondary: themeData.accentSecondary
    property color accentTertiary: themeData.accentTertiary

    // Text Colors
    property color textPrimary: themeData.textPrimary
    property color textSecondary: themeData.textSecondary
    property color textDisabled: themeData.textDisabled
    property color textDark: themeData.textDark
    property color textLight: themeData.textLight

    // Styling
    property color outline: themeData.outline
    property color highlight: themeData.highlight

    // Error/Warning
    property color error: themeData.error
    property color warning: themeData.warning

    // Surfaces & Elevation
    property color surface: themeData.surface
    property color surfaceVariant: themeData.surfaceVariant
}
