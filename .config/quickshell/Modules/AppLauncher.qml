pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.Components
import qs.Modules.AppLauncher
import qs.Config
import qs.Theme
import "../Utils/Fuzzysort.js" as Fuzzysort

PanelWindow {
    id: root

    readonly property int padding: 8
    readonly property int appEntryRadius: 10

    property var open: false

    readonly property list<DesktopEntry> entries: Fuzzysort.sort(
        searchBar.text,
        Array.from(DesktopEntries.applications.values)
            .sort((e1, e2) => e1.name.localeCompare(e2.name)),
        e => e.name
    );
    property int selectedIdx: 0
    readonly property DesktopEntry selectedEntry: entries[selectedIdx] ?? null

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    visible: open
    color: "transparent"

    implicitWidth: launcherPanel.implicitWidth + 2 * padding
    implicitHeight: launcherPanel.implicitHeight + 2 * padding

    // Background
    Rectangle {
        id: launcherPanel

        implicitWidth: 500
        implicitHeight: column.implicitHeight

        color: Theme.backgroundPrimary
        anchors.fill: parent

        topLeftRadius: root.padding + searchBar.radius
        topRightRadius: root.padding + searchBar.radius
        bottomLeftRadius: root.padding + root.appEntryRadius
        bottomRightRadius: root.padding + root.appEntryRadius

        border.color: Theme.outline
        border.width: 1

        // Search bar + app list
        ColumnLayout {
            id: column

            anchors.centerIn: parent
            spacing: 8

            SearchBar {
                id: searchBar

                Layout.preferredWidth: launcherPanel.implicitWidth
                Layout.preferredHeight: 40

                backgroundColor: Theme.backgroundPrimary
                borderColor: Theme.outline
                borderWidth: 1

                iconColor: Theme.textPrimary
                iconSize: Config.fontSizeLarge

                textColor: Theme.textPrimary
                placeholderColor: Theme.textPrimary
                placeholderText: "Run program..."

                textFont.family: Config.fonts.sans
                textFont.pixelSize: Config.fontSizeNormal
            }

            // App list
            ListView {
                id: entryListView

                readonly property int appEntryHeight: 40

                model: root.entries

                spacing: 8
                implicitHeight: (appEntryHeight + spacing) * Config.appLauncher.nVisible - spacing

                delegate: AppEntry {
                    id: appEntry
                    width: launcherPanel.implicitWidth
                    height: entryListView.appEntryHeight
                    radius: root.appEntryRadius
                    isSelected: modelData.name === root.selectedEntry?.name
                }
            }
        }
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

    function run() {
        selectedEntry?.execute();
        open = false;
    }

    function toggle() {
        if (!root.open) {
            searchBar.clear();
            // searchBar.setFocus();
            searchBar.focus = true;
            selectedIdx = 0;
        }
        open = !open;
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

    Shortcut {
        sequences: [StandardKey.Cancel]
        onActivated: root.open = false
    }

    Shortcut {
        sequences: [StandardKey.MoveToPreviousLine, "Ctrl+P"]
        onActivated: root.offsetSelectedIdx(-1)
    }

    Shortcut {
        sequences: [StandardKey.MoveToNextLine, "Ctrl+N"]
        onActivated: root.offsetSelectedIdx(1)
    }

    Shortcut {
        sequence: "Return"
        onActivated: root.run()
    }

    IpcHandler {
        target: "launcher"

        function toggle(): void {
            if (!root.open) {
                searchBar.clear();
                searchBar.focusField();
                root.selectedIdx = 0;
            }
            root.open = !root.open;
        }
    }
}
