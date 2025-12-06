pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import qs.Components
import qs.Settings

PanelWindow {
    id: launcher

    property var open: false

    readonly property list<DesktopEntry> visibleEntries: Array
        .from(DesktopEntries.applications.values)
        .sort((d1, d2) => d1.name.localeCompare(d2.name))
        // .filter(
        //     application => application.name
        //         .toLowerCase()
        //         .includes(searchBar.text.toLowerCase())
        // )
    property real selectedEntry: 0

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

    visible: open

    implicitWidth: 400
    implicitHeight: 600
    color: "#222222"

    ColumnLayout {
        anchors.centerIn: parent

        SearchBar {
            id: searchBar
            implicitWidth: 300
        }

        ListView {
            model: launcher.visibleEntries
            spacing: 8
            implicitHeight: 180

            delegate: Rectangle {
                id: appEntry

                required property var modelData

                implicitWidth: searchBar.implicitWidth
                implicitHeight: entryRow.implicitHeight + 4

                radius: 6

                color: modelData.name === launcher.visibleEntries[launcher.selectedEntry].name
                    ? Theme.highlight
                    : Theme.backgroundPrimary

                Row {
                    id: entryRow

                    anchors.fill: parent
                    anchors.centerIn: parent

                    spacing: 8

                    // Icon
                    Item {
                        implicitWidth: itemIcon.width
                        implicitHeight: itemIcon.height

                        Image {
                            id: itemIcon
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: 30
                            height: 30
                            source: Quickshell.iconPath(appEntry.modelData.icon, true)
                        }
                    }

                    // App name
                    Text {
                        anchors.verticalCenter: parent.verticalCenter

                        width: parent.width - itemIcon.width - parent.spacing

                        font.family: Settings.fontFamily
                        // font.pointSize: Size.launcherFontSize
                        color: Theme.textPrimary
                        elide: Text.ElideRight

                        text: appEntry.modelData.name
                    }
                }
            }
        }
    }

    Shortcut {
        sequences: [StandardKey.Cancel]
        onActivated: launcher.open = false
    }

    Shortcut {
        sequences: [StandardKey.MoveToPreviousLine]
        onActivated: launcher.selectedEntry = Math.max(
            launcher.selectedEntry - 1,
            0
        )
    }

    Shortcut {
        sequences: [StandardKey.MoveToNextLine]
        onActivated: launcher.selectedEntry = Math.min(
            launcher.selectedEntry + 1,
            launcher.visibleEntries.length - 1
        )
    }

    IpcHandler {
        target: "launcher"

        function toggle() {
            if (!launcher.open) {
                searchBar.clear();
                searchBar.setFocus();
                launcher.selectedEntry = 0;
            }
            launcher.open = !launcher.open;
        }
    }
}
