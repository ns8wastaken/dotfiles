pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.Modules.AppLauncher
import qs.Settings
import "../Utils/Fuzzysort.js" as Fuzzysort

PanelWindow {
    id: launcher

    property var open: false

    property int nVisibleItems: 8

    readonly property list<DesktopEntry> entries: Fuzzysort.sort(
        searchBar.text,
        Array.from(DesktopEntries.applications.values)
            .sort((e1, e2) => e1.name.localeCompare(e2.name)),
        e => e.name
    )
    property real selectedIdx: 0
    readonly property DesktopEntry selectedEntry: launcher.entries[launcher.selectedIdx] ?? null

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    color: "transparent"
    visible: open

    implicitWidth: launcherPanel.implicitWidth + 2 * 8
    implicitHeight: launcherPanel.implicitHeight + 2 * 8

    Rectangle {
        id: launcherPanel

        implicitWidth: 500
        implicitHeight: column.implicitHeight

        color: Theme.backgroundPrimary
        anchors.fill: parent

        radius: 18
        border {
            color: Theme.outline
            width: 1
        }

        ColumnLayout {
            id: column

            anchors.centerIn: parent
            spacing: 8

            SearchBar {
                id: searchBar
                readonly property int searchBarHeight: 40
                implicitWidth: launcherPanel.implicitWidth
                implicitHeight: searchBarHeight
                z: 1
            }

            ListView {
                id: entryListView

                readonly property int appEntryHeight: 40

                model: launcher.entries

                spacing: 8
                implicitHeight: (appEntryHeight + spacing) * launcher.nVisibleItems - spacing

                z: 0

                delegate: AppEntry {
                    id: appEntry
                    width: launcherPanel.implicitWidth
                    height: entryListView.appEntryHeight
                    isSelected: modelData.name === launcher.selectedEntry?.name
                }
            }
        }
    }

    function offsetSelected(n: int) {
        launcher.selectedIdx = Math.min(
            Math.max(
                launcher.selectedIdx + n,
                0
            ),
            launcher.entries.length - 1
        );
    }

    function run() {
        selectedEntry?.execute();
        open = false;
    }

    function toggle() {
        if (!launcher.open) {
            searchBar.clear();
            searchBar.setFocus();
            selectedIdx = 0;
        }
        open = !open;
    }

    function centerScroll() {
        entryListView.positionViewAtIndex(launcher.selectedIdx, ListView.Contain);
    }

    // Scroll the list when the selected index changes
    Connections {
        target: launcher
        function onSelectedIdxChanged() {
            launcher.centerScroll();
        }
    }

    // Clamp the selected index when typing (as the old idx may become > entries.length)
    Connections {
        target: searchBar
        function onTextChanged() {
            launcher.offsetSelected(0);
            launcher.centerScroll();
        }
    }

    Shortcut {
        sequences: [StandardKey.Cancel]
        onActivated: launcher.open = false
    }

    Shortcut {
        sequences: [StandardKey.MoveToPreviousLine, "Ctrl+P"]
        onActivated: launcher.offsetSelected(-1)
    }

    Shortcut {
        sequences: [StandardKey.MoveToNextLine, "Ctrl+N"]
        onActivated: launcher.offsetSelected(1)
    }

    Shortcut {
        sequence: "Return"
        onActivated: launcher.run()
    }

    IpcHandler {
        target: "launcher"

        function toggle(): void {
            if (!launcher.open) {
                searchBar.clear();
                searchBar.setFocus();
                launcher.selectedIdx = 0;
            }
            launcher.open = !launcher.open;
        }
    }
}
