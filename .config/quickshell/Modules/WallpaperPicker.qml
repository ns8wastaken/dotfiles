pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.Services
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
        Wallpapers.reload();
    }
    onWmFocused: searchBar.focusField();

    readonly property list<string> filteredWallpaperList: Fuzzysort.sort(searchBar.text, Wallpapers.wallpaperList);
    readonly property list<string> filteredWallpaperNames: filteredWallpaperList
        .map(w => w.slice(Wallpapers.wallpaperDir.length + 1));

    width: (Config.wallpaperPicker.wallpaperWidth + Config.wallpaperPicker.spacing) * 2
    height: Config.wallpaperPicker.wallpaperHeight
        + Config.wallpaperPicker.spacing * 2
        + pickerCol.spacing
        + pickerCol.anchors.margins * 2
        + searchBar.height;

    color: Theme.backgroundPrimary
    radius: 30

    border.width: 1
    border.color: Theme.outline

    ColumnLayout {
        id: pickerCol

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

            ClippingRectangle {
                anchors.fill: parent
                anchors.margins: Config.wallpaperPicker.spacing

                radius: 16

                color: "transparent"

                WallpaperView {
                    id: slidingWallpapers
                    anchors.fill: parent
                    width: parent.width
                    filteredWallpaperNames: root.filteredWallpaperNames
                    model: root.filteredWallpaperList
                }
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

        // Ctrl+P -> next wallpaper
        if (KeyUtils.key(event, Qt.Key_P) && KeyUtils.ctrl(event)) {
            slidingWallpapers.incrementCurrentIndex();
            event.accepted = true;
            return;
        }

        // Ctrl+N -> previous wallpaper
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
            Wallpapers.setWallpaper(filteredWallpaperList[slidingWallpapers.currentIndex]);
            close();
            event.accepted = true;
            return;
        }
    }

    GlobalShortcut {
        name: "wallpaperPicker"
        onPressed: root.toggle()
    }
}
