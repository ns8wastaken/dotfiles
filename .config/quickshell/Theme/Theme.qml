pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    function getWorkspaceColor(modelData): color {
        if (modelData.active) return accentPrimary;
        if (modelData.urgent) return error;
        return surface;
    }

    function getWorkspaceTextColor(modelData): color {
        if (modelData.active) return textDark;
        return textPrimary;
    }

    // property alias color:    themeAdapter.color
    property alias backgroundPrimary:   themeAdapter.color.backgroundPrimary
    property alias backgroundSecondary: themeAdapter.color.backgroundSecondary
    property alias backgroundTertiary:  themeAdapter.color.backgroundTertiary
    property alias accentPrimary:       themeAdapter.color.accentPrimary
    property alias accentSecondary:     themeAdapter.color.accentSecondary
    property alias accentTertiary:      themeAdapter.color.accentTertiary
    property alias textPrimary:         themeAdapter.color.textPrimary
    property alias textSecondary:       themeAdapter.color.textSecondary
    property alias textPrimaryInverted: themeAdapter.color.textPrimaryInverted
    property alias textDisabled:        themeAdapter.color.textDisabled
    property alias textDark:            themeAdapter.color.textDark
    property alias textLight:           themeAdapter.color.textLight
    property alias outline:             themeAdapter.color.outline
    property alias highlight:           themeAdapter.color.highlight
    property alias error:               themeAdapter.color.error
    property alias warning:             themeAdapter.color.warning
    property alias surface:             themeAdapter.color.surface
    property alias surfaceVariant:      themeAdapter.color.surfaceVariant

    property alias font:     themeConfigAdapter.font
    property alias fontSize: themeConfigAdapter.fontSize
    property alias spacing:  themeConfigAdapter.spacing

    FileView {
        // TODO: allow the user to use a premade theme
        path: Quickshell.shellPath("Theme/Theme.json")

        watchChanges: true
        onFileChanged: reload()

        onLoadFailed: console.log("Error while loading theme (this may be a complete lie)")

        adapter: JsonAdapter {
            id: themeAdapter

            property ColorTheme color: ColorTheme {}
        }
    }

    FileView {
        path: Quickshell.shellPath("theme.json")

        watchChanges: true
        onFileChanged: reload()

        onLoadFailed: console.log("Error while loading theme config (this may be a complete lie)")

        adapter: JsonAdapter {
            id: themeConfigAdapter

            property FontTheme     font:     FontTheme {}
            property FontSizeTheme fontSize: FontSizeTheme {}
            property SpacingTheme  spacing:  SpacingTheme {}
        }
    }
}
