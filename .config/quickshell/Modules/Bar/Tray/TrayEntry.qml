import Quickshell.Widgets
import QtQuick
import qs.Config

Item {
    id: root

    required property var modelData

    readonly property bool isHovered: trayEntryMouseArea.containsMouse

    width: Config.bar.tray.iconSize
    height: Config.bar.tray.iconSize

    signal clicked(event: MouseEvent)

    IconImage {
        id: trayEntryIcon

        anchors.centerIn: parent

        width: root.width
        height: root.width

        antialiasing: true
        asynchronous: true
        backer.fillMode: Image.PreserveAspectFit

        source: root.modelData.icon

        opacity: status === Image.Ready ? 1 : 0

        Behavior on opacity {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutCubic
            }
        }

        // Hover scale animation
        scale: root.isHovered ? 1.15 : 1.0
        Behavior on scale {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutCubic
            }
        }

        // Subtle rotation on hover
        rotation: root.isHovered ? 5 : 0
        Behavior on rotation {
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutCubic
            }
        }
    }

    MouseArea {
        id: trayEntryMouseArea

        anchors.fill: parent
        hoverEnabled: true

        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: function(event) {
            root.clicked(event);
        }
    }
}
