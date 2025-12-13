import QtQuick
import Quickshell.Hyprland
import qs.Settings

Row {
    // Spacing between workspace buttons
    spacing: 8

    // Workspace button repeater
    Repeater {
        model: Hyprland.workspaces

        // Workspace button
        delegate: Rectangle {
            required property var modelData

            width: (modelData.active ? 40 : 20) + workspaceLabel.width
            height: 18
            radius: 40
            color: Theme.getWorkspaceColor(modelData)

            // Scaling animation
            Behavior on width {
                NumberAnimation {
                    duration: 75
                    easing.type: Easing.InOutCubic
                }
            }

            // Switch to workspace on click
            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + parent.modelData.id)
            }

            Text {
                id: workspaceLabel

                anchors.centerIn: parent

                color: Theme.getWorkspaceTextColor(parent.modelData)

                font.family: Settings.workspaces.fontFamily
                font.pixelSize: Settings.fontSizeSmall
                text: Icons.getWorkspaceLabel(parent.modelData.id)
            }
        }
    }
}
