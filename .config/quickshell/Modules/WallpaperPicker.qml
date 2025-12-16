pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.Components
import qs.Modules.WallpaperPicker
import qs.Config
import qs.Theme
import "../Utils/Fuzzysort.js" as Fuzzysort

Scope {
    id: root

    property bool open: false

    readonly property string wallpaperDir: "/home/renzo/wallpapers"

    property list<string> wallpaperList: []

    readonly property list<string> filteredWallpaperList: Fuzzysort.sort(searchBar.text, wallpaperList);
    readonly property list<string> filteredWallpaperNames: filteredWallpaperList
        .map(w => w.slice(wallpaperDir.length + 1));

    Process {
        workingDirectory: root.wallpaperDir
        command: ["fd", ".", "-a", "-t", "file", "-c", "never"]
        running: true
        stdout: SplitParser {
            onRead: line => root.wallpaperList.push(line)
        }
    }

    PanelWindow {
        implicitWidth: Config.wallpaperPicker.width
        implicitHeight: Config.wallpaperPicker.height

        visible: root.open
        color: "transparent"

        // Background
        Rectangle {
            anchors.fill: parent
            color: Theme.backgroundPrimary
            radius: 30
        }

        WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

        ColumnLayout {
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

            SlidingWallpapers {
                id: slidingWallpapers

                Layout.fillWidth: true
                Layout.fillHeight: true

                filteredWallpaperNames: root.filteredWallpaperNames

                model: root.filteredWallpaperList
                pathItemCount: Config.wallpaperPicker.nVisible
            }
        }

        // Border
        Rectangle {
            anchors.fill: parent

            color: "transparent"

            radius: 30
            border.width: 1
            border.color: Theme.outline
        }

        Shortcut {
            sequences: [StandardKey.Cancel]
            onActivated: root.open = false
        }

        Shortcut {
            sequences: [StandardKey.MoveToPreviousLine, "Ctrl+P"]
            onActivated: slidingWallpapers.incrementCurrentIndex()
        }

        Shortcut {
            sequences: [StandardKey.MoveToNextLine, "Ctrl+N"]
            onActivated: slidingWallpapers.decrementCurrentIndex()
        }

        Shortcut {
            sequences: ["Return", "Enter"]
            onActivated: root.set_wallpaper()
        }
    }

    function set_wallpaper() {
        let path = filteredWallpaperList[slidingWallpapers.currentIndex];

        // Close the wallpaper picker
        open = false;

        // Set the wallpaper
        Quickshell.execDetached({
            command: ["sh", "-c", `~/setwp.sh ${path}`]
        });
    }

    IpcHandler {
        target: "wallpaper-picker"

        function toggle(): void {
            if (!root.open) {
                searchBar.clear();
                searchBar.focusField();
            }
            root.open = !root.open;
        }
    }
}
