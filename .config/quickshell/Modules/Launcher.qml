pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.Managers.Types
import qs.Components
import qs.Modules.Launcher
import qs.Config
import qs.Theme
import qs.Utils
import "../Utils/Scripts/Fuzzy.js" as Fuzzy

WmWindow {
    id: root

    Component.onCompleted: {
        searchBar.clear();
        selectedIdx = 0;
    }

    onWmFocused: searchBar.focusField()

    readonly property int margins: 8
    readonly property int appEntryRadius: 10

    readonly property list<DesktopEntry> entries: Fuzzy.sort(
        searchBar.text,
        Array.from(DesktopEntries.applications.values)
            .sort((e1, e2) => e1.name.localeCompare(e2.name)),
        e => e.name
    );
    property int selectedIdx: 0
    readonly property DesktopEntry selectedEntry: entries[selectedIdx] ?? null

    implicitWidth: Config.launcher.width + 2 * margins
    implicitHeight: column.implicitHeight + 2 * margins

    color: Theme.colors.backgroundPrimary

    topLeftRadius: root.margins + searchBar.radius
    topRightRadius: root.margins + searchBar.radius
    bottomLeftRadius: root.margins + root.appEntryRadius
    bottomRightRadius: root.margins + root.appEntryRadius

    border.color: Theme.colors.outline
    border.width: 1

    // Search bar + app list
    ColumnLayout {
        id: column

        anchors.centerIn: parent
        anchors.fill: parent
        anchors.margins: root.margins

        spacing: 8

        SearchBar {
            id: searchBar

            Layout.fillWidth: true
            Layout.preferredHeight: 40

            backgroundColor: Theme.colors.backgroundPrimary
            borderColor: Theme.colors.outline
            borderWidth: 1

            iconColor: Theme.colors.textPrimary
            iconSize: Theme.fontSize.large

            textColor: Theme.colors.textPrimary
            placeholderColor: Theme.colors.textPrimary
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
                radius: root.appEntryRadius
                isSelected: modelData.name === root.selectedEntry?.name
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
