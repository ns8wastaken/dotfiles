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

    property alias color:    themeAdapter.color
    property alias palette:  themeAdapter.palette

    property alias anim:     themeConfigAdapter.anim
    property alias fonts:    themeConfigAdapter.fonts
    property alias fontSize: themeConfigAdapter.fontSize
    property alias spacing:  themeConfigAdapter.spacing

    FileView {
        // TODO: allow the user to use a premade theme
        path: Quickshell.shellPath("Assets/Colors/Colors.json")

        watchChanges: true
        onFileChanged: reload()

        onLoadFailed: console.log("Error while loading theme (this may be a complete lie)")

        adapter: JsonAdapter {
            id: themeAdapter

            property ColorsTheme  color: ColorsTheme {}
            property PaletteTheme palette: PaletteTheme {}
        }
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
