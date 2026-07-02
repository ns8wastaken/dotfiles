pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import "../../Shared/Components"
import "../../Services"
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

    readonly property list<DesktopEntry> entries: Fuzzy.fuzzySort(
        searchBar.text,
        Array.from(ApplicationsService.applications)
            .sort((e1, e2) => e1.name.localeCompare(e2.name)),
        e => e.name
    );
    property int selectedIdx: 0
    readonly property DesktopEntry selectedEntry: entries[selectedIdx] ?? null

    WlrLayershell.namespace: "shellous:launcher"

    anchors.bottom: true

    implicitWidth: frp.width
    implicitHeight: frp.height + 16 // + (shadow.blurMax (32) * shadow.shadowBlur (0.5))

    exclusionMode: ExclusionMode.Ignore
    aboveWindows: true
    focusable: true
    color: "transparent"

    onVisibleChanged: {
        if (visible) {
            Qt.callLater(() => searchBar.focusField());
        }
    }

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
                offsetSelectedIdx(-1);
                event.accepted = true;
                return;
            }

            if (Key.match(event, Qt.Key_N, Qt.ControlModifier)) {
                offsetSelectedIdx(1);
                event.accepted = true;
                return;
            }

            if (Key.match(event, Qt.Key_Return) || Key.match(event, Qt.Key_Enter)) {
                run();
                closeRequested();
                event.accepted = true;
                return;
            }
        }

        FancyRoundedPanel {
            id: frp

            anchors.bottom: parent.bottom

            panelWidth: Config.launcher.width + 2 * rounding
            panelHeight: root.rounding + column.implicitHeight + root.tabSize + root.margins

            topLeftRadius: root.rounding
            topRightRadius: root.rounding
            bottomLeftRadius: -root.tabSize
            bottomRightRadius: -root.tabSize

            color: Theme.color.surface
            layer.enabled: true
            layer.effect: MultiEffect {
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
                    placeholderText: "Run program..."

                    textFont.family: Theme.fonts.sans
                    textFont.pixelSize: Theme.fontSize.normal
                }

                ListView {
                    id: entryListView

                    readonly property int appEntryHeight: 40

                    model: root.entries

                    spacing: Config.launcher.spacing
                    implicitHeight: (appEntryHeight + spacing) * Config.launcher.nVisible - spacing

                    delegate: AppEntry {
                        id: appEntry
                        width: searchBar.width
                        height: entryListView.appEntryHeight
                        isSelected: modelData.name === root.selectedEntry?.name
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        searchBar.clear();
        selectedIdx = 0;
    }

    function offsetSelectedIdx(n: int) {
        root.selectedIdx = Math.min(
            Math.max(
                root.selectedIdx + n,
                0
            ),
            root.entries.length - 1
        );
    }

    function centerScroll() {
        entryListView.positionViewAtIndex(root.selectedIdx, ListView.Contain);
    }

    Connections {
        target: root
        function onSelectedIdxChanged() {
            root.centerScroll();
        }
    }

    Connections {
        target: searchBar
        function onTextChanged() {
            root.offsetSelectedIdx(0);
            root.centerScroll();
        }
    }

    function run() {
        selectedEntry?.execute();
    }
}
