import QtQuick
import Quickshell.Hyprland
import qs.Settings

Row {
    anchors {
        left: parent.left
        verticalCenter: parent.verticalCenter
        leftMargin: 10
    }

    // Spacing between workspace buttons
    spacing: 8

    // Workspace button repeater
    Repeater {
        model: Hyprland.workspaces

        // Workspace button
        delegate: Rectangle {
            width: modelData.active ? 52 : 32
            height: 18
            radius: 40
            color: Settings.workspaces.getButtonColor(modelData)

            Behavior on width {
                NumberAnimation { duration: 75; easing.type: Easing.InOutQuad }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + modelData.id)
            }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 2

                font.family: Settings.workspaces.labelFont

                color: Settings.workspaces.getButtonTextColor(modelData)

                text: Settings.workspaces.getLabel(modelData.id)
                font.pixelSize: 13
            }
        }
    }
}
