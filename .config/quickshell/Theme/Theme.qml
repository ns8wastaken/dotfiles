pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick
import ShellModule

Singleton {
    Component.onCompleted: {
        FontsLoader.directory = Quickshell.shellPath("Assets/Fonts");
        FontsLoader.load();
        console.log("Loaded fonts:", FontsLoader.families);
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

    property alias colors:   themeAdapter

    property alias anim:     themeConfigAdapter.anim
    property alias fonts:    themeConfigAdapter.fonts
    property alias fontSize: themeConfigAdapter.fontSize
    property alias spacing:  themeConfigAdapter.spacing

    FileView {
        // TODO: allow the user to use a premade theme
        path: Quickshell.shellPath("Assets/Themes/Wallust/Theme.json")

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

            property AnimTheme     anim:     AnimTheme {}
            property FontTheme     fonts:    FontTheme {}
            property FontSizeTheme fontSize: FontSizeTheme {}
            property SpacingTheme  spacing:  SpacingTheme {}
        }
    }
}
