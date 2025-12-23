pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import qs.Managers
import qs.Components
import qs.Modules.WallpaperPicker
import qs.Config
import qs.Theme
import "../Utils/Fuzzysort.js" as Fuzzysort
import "../Utils/Keys.js" as KeyUtils

WindowManager.WmWindow {
    id: root

    handle: "wallpaperPicker"

    Component.onCompleted: {
        WindowManager.register(handle, root);
    }

    onWmOpened: {
        searchBar.clear();
    }

    onWmFocused: {
        searchBar.focusField();
    }

    readonly property string wallpaperDir: Quickshell.env("HOME") + "/wallpapers"

    property list<string> wallpaperList: []

    readonly property list<string> filteredWallpaperList: Fuzzysort.sort(searchBar.text, wallpaperList);
    readonly property list<string> filteredWallpaperNames: filteredWallpaperList
        .map(w => w.slice(wallpaperDir.length + 1));

    width: Config.wallpaperPicker.width
    height: Config.wallpaperPicker.height

    color: Theme.backgroundPrimary
    radius: 30

    border.width: 1
    border.color: Theme.outline

    Process {
        workingDirectory: root.wallpaperDir
        command: ["fd", ".", "-a", "-t", "file", "-c", "never"]
        running: true
        stdout: SplitParser {
            onRead: line => root.wallpaperList.push(line)
        }
    }

    ColumnLayout {
        clip: true

        anchors.fill: parent
        anchors.margins: 12

        spacing: 12

        SearchBar {
            id: searchBar

            Layout.fillWidth: true
            Layout.preferredHeight: 40

            backgroundColor: Theme.backgroundPrimary
            borderColor: Theme.outline
            borderWidth: 1

            iconColor: Theme.textPrimary
            iconSize: Config.fontSizeLarge

            textColor: Theme.textPrimary
            placeholderColor: Theme.textPrimary
            placeholderText: "Search wallpapers..."

            textFont.family: Config.fonts.sans
            textFont.pixelSize: Config.fontSizeNormal
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true

            color: Theme.backgroundSecondary
            radius: searchBar.radius

            SlidingWallpapers {
                id: slidingWallpapers

                anchors.centerIn: parent

                width: parent.width

                filteredWallpaperNames: root.filteredWallpaperNames

                model: root.filteredWallpaperList
                pathItemCount: Config.wallpaperPicker.nVisible
            }
        }
    }

    Keys.onPressed: function(event) {
        if (!shortcutsEnabled)
            return;

        // Ctrl+W -> delete previous word
        if (KeyUtils.key(event, Qt.Key_W) && KeyUtils.ctrl(event)) {
            searchBar.deletePreviousWord();
            event.accepted = true;
            return;
        }

        // Escape -> close
        if (KeyUtils.key(event, Qt.Key_Escape)) {
            close();
            event.accepted = true;
            return;
        }

        // Ctrl+P -> previous wallpaper
        if (KeyUtils.key(event, Qt.Key_P) && KeyUtils.ctrl(event)) {
            slidingWallpapers.incrementCurrentIndex();
            event.accepted = true;
            return;
        }

        // Ctrl+N -> next wallpaper
        if (KeyUtils.key(event, Qt.Key_N) && KeyUtils.ctrl(event)) {
            slidingWallpapers.decrementCurrentIndex();
            event.accepted = true;
            return;
        }

        // Enter / Return -> set wallpaper
        if (
            KeyUtils.key(event, Qt.Key_Return)
            || KeyUtils.key(event, Qt.Key_Enter)
        ) {
            set_wallpaper();
            close();
            event.accepted = true;
            return;
        }
    }

    function set_wallpaper() {
        let path = filteredWallpaperList[slidingWallpapers.currentIndex];

        // Set the wallpaper
        Quickshell.execDetached({
            command: ["sh", "-c", `~/setwp.sh ${path}`]
        });
    }

    GlobalShortcut {
        name: "wallpaperPicker"
        onPressed: root.toggle()
    }
}
