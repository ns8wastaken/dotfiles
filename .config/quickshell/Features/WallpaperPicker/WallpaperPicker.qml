pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import "../../Services"
import "../../Shared/Components"
import "../../Services/Config"
import "../../Shared/Theme"
import "../../Shared/Utils"
import "../../Shared/Utils/Fuzzy.js" as Fuzzy

PanelWindow {
    id: root

    signal closeRequested()

    readonly property int margins: 8
    readonly property real rounding: 12
    readonly property real tabSize: 18

    WlrLayershell.namespace: "shellous:wallpaperSwitcher"

    anchors.bottom: true

    implicitWidth: frp.width
    implicitHeight: frp.height + 16 // + (shadow.blurMax (32) * shadow.shadowBlur (0.5))

    exclusionMode: ExclusionMode.Ignore
    aboveWindows: true
    focusable: true
    color: "transparent"
    onVisibleChanged: if (visible) Qt.callLater(() => searchBar.focusField())

    Item {
        id: wrapper
        anchors.fill: parent
        focus: true
        Keys.onPressed: function(event) {
            if (Key.match(event, Qt.Key_W, Qt.ControlModifier)) {
                searchBar.deletePreviousWord();
                event.accepted = true;
                return;
            }

            if (Key.match(event, Qt.Key_Escape)) {
                closeRequested();
                event.accepted = true;
                return;
            }

            if (Key.match(event, Qt.Key_P, Qt.ControlModifier)) {
                wallpaperView.incrementCurrentIndex();
                event.accepted = true;
                return;
            }

            if (Key.match(event, Qt.Key_N, Qt.ControlModifier)) {
                wallpaperView.decrementCurrentIndex();
                event.accepted = true;
                return;
            }

            if (Key.match(event, Qt.Key_Return) || Key.match(event, Qt.Key_Enter)) {
                WallpaperService.setWallpaper(wallpaperView.currentItem.fileUrl);
                closeRequested();
                event.accepted = true;
                return;
            }
        }

        FancyRoundedPanel {
            id: frp

            anchors.bottom: parent.bottom

            panelWidth: Config.wallpaperPicker.width + 2 * rounding
            panelHeight: root.rounding + column.implicitHeight + root.tabSize + root.margins

            topLeftRadius: root.rounding
            topRightRadius: root.rounding
            bottomLeftRadius: -root.tabSize
            bottomRightRadius: -root.tabSize

            color: Theme.color.surface
            layer.enabled: true
            layer.effect: MultiEffect {
                id: shadow
                source: frp
                shadowEnabled: true
                shadowColor: Theme.color.shadow
                shadowOpacity: 1
                shadowVerticalOffset: 0
                shadowHorizontalOffset: 0
                shadowBlur: 0.5
            }

            ColumnLayout {
                id: column

                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    topMargin: parent.topExtension + root.rounding
                    leftMargin: parent.leftExtension + root.rounding
                    rightMargin: parent.rightExtension + root.rounding
                }

                spacing: Theme.spacing.normal

                SearchBar {
                    id: searchBar

                    Layout.fillWidth: true
                    Layout.preferredHeight: 40

                    backgroundColor: Theme.color.surface_container
                    borderColor: Theme.color.outline
                    borderWidth: 0

                    iconColor: Theme.color.on_surface
                    iconSize: Theme.fontSize.large

                    textColor: Theme.color.on_surface
                    placeholderColor: Theme.color.on_surface
                    placeholderText: "Search wallpapers..."

                    textFont.family: Theme.fonts.sans
                    textFont.pixelSize: Theme.fontSize.normal
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: Config.wallpaperPicker.spacing * 2 + wallpaperView.implicitHeight

                    color: Theme.color.surface_container
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

                                readonly property string query: searchBar.text.toLowerCase()

                                onQueryChanged: {
                                    invalidate();
                                    invalidateSorter();
                                    wallpaperView.currentIndex = 0;
                                }

                                component WEntry: QtObject { property string fileName }

                                sorters: FunctionSorter {
                                    function sort(lhsData: WEntry, rhsData: WEntry): int {
                                        let lhsMatch = Fuzzy.score(sorter.query, lhsData.fileName.toLowerCase());
                                        let rhsMatch = Fuzzy.score(sorter.query, rhsData.fileName.toLowerCase());

                                        return rhsMatch.score - lhsMatch.score;
                                    }
                                }

                                filters: FunctionFilter {
                                    function filter(data: WEntry): bool {
                                        if (!searchBar.text) return true;

                                        let match = Fuzzy.score(sorter.query, data.fileName.toLowerCase());

                                        return match.isValid;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        searchBar.clear();
    }
}
