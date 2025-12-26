pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.Managers.Types
import qs.Components
import qs.Modules.Launcher
import qs.Config
import qs.Theme
import "../Utils/Fuzzysort.js" as Fuzzysort
import "../Utils/Keys.js" as KeyUtils

WmWindow {
    id: root

    onWmOpened: {
        searchBar.clear();
        selectedIdx = 0;
    }

    onWmFocused: searchBar.focusField()

    readonly property int margins: 8
    readonly property int appEntryRadius: 10

    readonly property list<DesktopEntry> entries: Fuzzysort.sort(
        searchBar.text,
        Array.from(DesktopEntries.applications.values)
            .sort((e1, e2) => e1.name.localeCompare(e2.name)),
        e => e.name
    );
    property int selectedIdx: 0
    readonly property DesktopEntry selectedEntry: entries[selectedIdx] ?? null

    implicitWidth: Config.launcher.width + 2 * margins
    implicitHeight: column.implicitHeight + 2 * margins

    color: Theme.backgroundPrimary

    topLeftRadius: root.margins + searchBar.radius
    topRightRadius: root.margins + searchBar.radius
    bottomLeftRadius: root.margins + root.appEntryRadius
    bottomRightRadius: root.margins + root.appEntryRadius

    border.color: Theme.outline
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

        // Ctrl+P -> previous entry
        if (KeyUtils.key(event, Qt.Key_P) && KeyUtils.ctrl(event)) {
            offsetSelectedIdx(-1);
            event.accepted = true;
            return;
        }

        // Ctrl+N -> next entry
        if (KeyUtils.key(event, Qt.Key_N) && KeyUtils.ctrl(event)) {
            offsetSelectedIdx(1);
            event.accepted = true;
            return;
        }

        // Enter / Return -> run program
        if (
            KeyUtils.key(event, Qt.Key_Return)
            || KeyUtils.key(event, Qt.Key_Enter)
        ) {
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
