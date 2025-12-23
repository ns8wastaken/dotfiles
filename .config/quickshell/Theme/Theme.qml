pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    function getWorkspaceColor(modelData): color {
        if (modelData.name == "special:magic") return Theme.accentTertiary;
        if (modelData.active) return Theme.accentPrimary;
        if (modelData.urgent) return Theme.error;
        if (modelData.focused) return Theme.error;
        return Theme.surface;
    }

    function getWorkspaceTextColor(modelData): color {
        if (modelData.name == "special:magic") return Theme.textDark;
        if (modelData.active) return Theme.textDark;
        return Theme.textPrimary;
    }

    property alias backgroundPrimary: themeData.backgroundPrimary
    property alias backgroundSecondary: themeData.backgroundSecondary
    property alias backgroundTertiary: themeData.backgroundTertiary

    property alias accentPrimary: themeData.accentPrimary
    property alias accentSecondary: themeData.accentSecondary
    property alias accentTertiary: themeData.accentTertiary

    property alias textPrimary: themeData.textPrimary
    property alias textSecondary: themeData.textSecondary
    property alias textPrimaryInverted: themeData.textPrimaryInverted
    property alias textDisabled: themeData.textDisabled
    property alias textDark: themeData.textDark
    property alias textLight: themeData.textLight

    property alias outline: themeData.outline
    property alias highlight: themeData.highlight

    property alias error: themeData.error
    property alias warning: themeData.warning

    property alias surface: themeData.surface
    property alias surfaceVariant: themeData.surfaceVariant

    FileView {
        path: Quickshell.shellPath("Theme/Theme.json")

        watchChanges: true
        onFileChanged: this.reload()

        onLoadFailed: console.log("Error while loading theme (this may be a complete lie)")

        adapter: JsonAdapter {
            id: themeData

            // Backgrounds
            property color backgroundPrimary: "#0C0D11"
            property color backgroundSecondary: "#14161C"
            property color backgroundTertiary: "#FF0000"

            // Accent Colors
            property color accentPrimary: "#A8AEFF"
            property color accentSecondary: "#9C9DFF"
            property color accentTertiary: "#79A8FF"

            // Text Colors
            property color textPrimary: "#CACEE2"
            property color textSecondary: "#B7BBD0"
            property color textPrimaryInverted: "#191B29"
            property color textLight: "#F3DEFF"
            property color textDark: "#0C0D11"
            property color textDisabled: "#6B718A"

            // Styling
            property color outline: "#44485A"
            property color highlight: "#E3C2FF"

            // Error/Warning
            property color error: "#FF6B81"
            property color warning: "#FFBB66"

            // Surfaces & Elevation
            property color surface: "#35394A"
            property color surfaceVariant: "#2A2D3A"
        }
    }
}
