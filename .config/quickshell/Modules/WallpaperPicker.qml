pragma ComponentBehavior: Bound

import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.Services
import qs.Managers.Types
import qs.Components
import qs.Modules.WallpaperPicker
import qs.Config
import qs.Theme
import qs.Utils
import "../Utils/Scripts/Fuzzy.js" as Fuzzy

WmWindow {
    id: root

    Component.onCompleted: searchBar.clear();

    onWmFocused: searchBar.focusField();

    width: (
        pickerCol.anchors.margins
        + Config.wallpaperPicker.wallpaperWidth
        + Config.wallpaperPicker.spacing
    ) * 2;

    height: pickerCol.implicitHeight + pickerCol.anchors.margins * 2

    color: Theme.colors.backgroundPrimary
    radius: 30

    border.width: 1
    border.color: Theme.colors.outline

    ColumnLayout {
        id: pickerCol

        anchors.fill: parent
        anchors.margins: 12

        spacing: 12

        SearchBar {
            id: searchBar

            Layout.fillWidth: true
            Layout.preferredHeight: 40

            backgroundColor: Theme.colors.backgroundPrimary
            borderColor: Theme.colors.outline
            borderWidth: 1

            iconColor: Theme.colors.textPrimary
            iconSize: Theme.fontSize.large

            placeholderColor: Theme.colors.textPrimary
            placeholderText: "Search wallpapers..."
            textColor: Theme.colors.textPrimary

            textFont.family: Theme.fonts.sans
            textFont.pixelSize: Theme.fontSize.normal
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: Config.wallpaperPicker.spacing * 2
                + wallpaperView.implicitHeight;

            color: Theme.colors.backgroundSecondary
            radius: searchBar.radius

            ClippingRectangle {
                anchors.fill: parent
                anchors.margins: Config.wallpaperPicker.spacing

                radius: 16

                color: "transparent"

                WallpaperView {
                    id: wallpaperView
                    anchors.fill: parent

                    model: SortFilterProxyModel {
                        id: sorter
                        model: WallpaperService.wallpapers

                        readonly property string query: searchBar.text.toLowerCase();

                        onQueryChanged: {
                            invalidate();
                            invalidateSorter();
                            wallpaperView.currentIndex = 0;
                        }

                        component WEntry: QtObject { property string fileName }
                        sorters: FunctionSorter {
                            function sort(lhsData: WEntry, rhsData: WEntry) : int {
                                return Fuzzy.score(sorter.query, rhsData.fileName.toLowerCase())
                                    - Fuzzy.score(sorter.query, lhsData.fileName.toLowerCase());
                            }
                        }
                        filters: FunctionFilter {
                            function filter(data: WEntry): bool {
                                if (!searchBar.text) return true;
                                return Fuzzy.score(sorter.query, data.fileName) > 0;
                            }
                        }
                    }
                }
            }
        }
    }

    Keys.onPressed: function(event) {
        if (!focused)
            return;

        // Ctrl+W -> delete previous word
        if (Key.match(event, Qt.Key_W, Qt.ControlModifier)) {
            searchBar.deletePreviousWord();
            event.accepted = true;
            return;
        }

        // Escape -> close
        if (Key.match(event, Qt.Key_Escape)) {
            close();
            event.accepted = true;
            return;
        }

        // Ctrl+P -> next wallpaper
        if (Key.match(event, Qt.Key_P, Qt.ControlModifier)) {
            wallpaperView.incrementCurrentIndex();
            event.accepted = true;
            return;
        }

        // Ctrl+N -> previous wallpaper
        if (Key.match(event, Qt.Key_N, Qt.ControlModifier)) {
            wallpaperView.decrementCurrentIndex();
            event.accepted = true;
            return;
        }

        // Enter / Return -> set wallpaper
        if (Key.match(event, Qt.Key_Return) || Key.match(event, Qt.Key_Enter)) {
            WallpaperService.setWallpaper(wallpaperView.currentItem.fileUrl);
            close();
            event.accepted = true;
            return;
        }
    }
}
