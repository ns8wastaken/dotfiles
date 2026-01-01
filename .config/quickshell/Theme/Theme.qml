pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import ShellModule

Singleton {
    Component.onCompleted: {
        FontsLoader.directory = Quickshell.shellPath("Assets/Fonts");
        FontsLoader.load();
        console.log(FontsLoader.families);
    }

    function getWorkspaceColor(modelData): color {
        if (modelData.active) return colors.accentPrimary;
        if (modelData.urgent) return colors.error;
        return colors.surface;
    }

    function getWorkspaceTextColor(modelData): color {
        if (modelData.active) return colors.textDark;
        return colors.textPrimary;
    }

    property QtObject colors: QtObject {
        property alias backgroundPrimary:   themeAdapter.backgroundPrimary
        property alias backgroundSecondary: themeAdapter.backgroundSecondary
        property alias backgroundTertiary:  themeAdapter.backgroundTertiary

        property alias accentPrimary:       themeAdapter.accentPrimary
        property alias accentSecondary:     themeAdapter.accentSecondary
        property alias accentTertiary:      themeAdapter.accentTertiary

        property alias textPrimary:         themeAdapter.textPrimary
        property alias textSecondary:       themeAdapter.textSecondary
        property alias textPrimaryInverted: themeAdapter.textPrimaryInverted
        property alias textDisabled:        themeAdapter.textDisabled
        property alias textDark:            themeAdapter.textDark
        property alias textLight:           themeAdapter.textLight

        property alias outline:             themeAdapter.outline
        property alias highlight:           themeAdapter.highlight

        property alias error:               themeAdapter.error
        property alias warning:             themeAdapter.warning
        property alias surface:             themeAdapter.surface
        property alias surfaceVariant:      themeAdapter.surfaceVariant
    }

    property alias fonts:    themeConfigAdapter.fonts
    property alias fontSize: themeConfigAdapter.fontSize
    property alias spacing:  themeConfigAdapter.spacing

    FileView {
        // TODO: allow the user to use a premade theme
        path: Quickshell.shellPath("Assets/Themes/Theme.json")

        watchChanges: true
        onFileChanged: reload()

        onLoadFailed: console.log("Error while loading theme (this may be a complete lie)")

        adapter: ColorsTheme { id: themeAdapter }
    }

    FileView {
        path: Quickshell.shellPath("theme.json")

        watchChanges: true
        onFileChanged: reload()

        onLoadFailed: console.log("Error while loading theme config (this may be a complete lie)")

        adapter: JsonAdapter {
            id: themeConfigAdapter

            property FontTheme     fonts:    FontTheme {}
            property FontSizeTheme fontSize: FontSizeTheme {}
            property SpacingTheme  spacing:  SpacingTheme {}
        }
    }
}
