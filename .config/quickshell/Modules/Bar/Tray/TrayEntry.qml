import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import qs.Config
import qs.Theme

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
                duration: Theme.anim.normal
                easing.type: Easing.OutCubic
            }
        }

        // Hover scale animation
        scale: root.isHovered ? 1.15 : 1.0
        Behavior on scale {
            NumberAnimation {
                duration: Theme.anim.small
                easing.type: Easing.OutCubic
            }
        }

        // Subtle rotation on hover
        rotation: root.isHovered ? 5 : 0
        Behavior on rotation {
            NumberAnimation {
                duration: Theme.anim.small
                easing.type: Easing.OutCubic
            }
        }
    }

    ToolTip {
        id: trayEntryTooltip

        visible: root.isHovered

        delay: 300

        text: root.modelData.tooltipTitle
            || root.modelData.name
            || root.modelData.id
            || "Tray Item";

        font.family: Theme.fonts.sans
        font.pixelSize: Theme.fontSize.small

        contentItem: Text {
            anchors.centerIn: tooltipRect
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: trayEntryTooltip.text
            font: trayEntryTooltip.font
            color: Theme.color.on_surface
        }

        background: Rectangle {
            id: tooltipRect

            width: trayEntryTooltip.width + 24
            height: trayEntryTooltip.height + 16

            color: Theme.color.surface

            radius: 6

            border.color: Theme.color.outline
            border.width: 1
        }

        x: (root.width - tooltipRect.width) / 2
        y: root.height + 12
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
