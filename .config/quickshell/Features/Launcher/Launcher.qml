pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../Services/WindowManager"
import "../../Shared/Components"
import "../../Shared/Effects"
import "../../Services"
import "../../Services/Config"
import "../../Shared/Theme"
import "../../Shared/Utils"
import "../../Shared/Utils/Fuzzy.js" as Fuzzy

WmWindow {
    id: root

    Component.onCompleted: {
        searchBar.clear();
        selectedIdx = 0;
    }

    onWmFocused: searchBar.focusField()

    readonly property int margins: 8
    readonly property int appEntryRadius: 10

    readonly property list<DesktopEntry> entries: Fuzzy.fuzzySort(
        searchBar.text,
        Array.from(ApplicationsService.applications)
            .sort((e1, e2) => e1.name.localeCompare(e2.name)),
        e => e.name
    );
    property int selectedIdx: 0
    readonly property DesktopEntry selectedEntry: entries[selectedIdx] ?? null

    width: Config.launcher.width
    height: frp.height

    color: "transparent"

    FancyRoundedPanel {
        id: frp

        readonly property real rounding: 12
        readonly property real tabSize: 18

        panelWidth: root.width
        panelHeight: column.implicitHeight + 2 * root.margins

        topLeftRadius: rounding
        topRightRadius: rounding
        bottomLeftRadius: -tabSize
        bottomRightRadius: -tabSize

        color: Theme.color.surface

        // Search bar + app list
        Item {
            anchors.fill: parent

            anchors.leftMargin: frp.rounding
            anchors.rightMargin: frp.rounding
            // Rectangle {anchors.fill:parent}

            ColumnLayout {
                id: column

                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                    topMargin: root.margins
                    leftMargin: root.margins
                    rightMargin: root.margins
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

                // App list
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

    PanelShadow { target: frp }

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

    // Scroll the list when the selected index changes
    Connections {
        target: root
        function onSelectedIdxChanged() {
            root.centerScroll();
        }
    }

    // Clamp the selected index when typing (as the old idx may become > entries.length)
    Connections {
        target: searchBar
        function onTextChanged() {
            root.offsetSelectedIdx(0);
            root.centerScroll();
        }
    }

    Keys.onPressed: function(event: KeyEvent) {
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

        // Ctrl+P -> previous entry
        if (Key.match(event, Qt.Key_P, Qt.ControlModifier)) {
            offsetSelectedIdx(-1);
            event.accepted = true;
            return;
        }

        // Ctrl+N -> next entry
        if (Key.match(event, Qt.Key_N, Qt.ControlModifier)) {
            offsetSelectedIdx(1);
            event.accepted = true;
            return;
        }

        // Enter / Return -> run program
        if (Key.match(event, Qt.Key_Return) || Key.match(event, Qt.Key_Enter)) {
            run();
            close();
            event.accepted = true;
            return;
        }
    }

    function run() {
        selectedEntry?.execute();
    }
}
