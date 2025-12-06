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
            // width: modelData.active ? 52 : 32
            implicitWidth: (modelData.active ? 40 : 20) + workspaceLabel.width
            implicitHeight: 18
            radius: 40
            color: Theme.getWorkspaceColor(modelData)

            // Scaling animation
            NumberAnimation on implicitWidth {
                duration: 75
                easing.type: Easing.InOutQuad
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + modelData.id)
            }

            Text {
                id: workspaceLabel

                anchors.centerIn: parent

                color: Theme.getWorkspaceTextColor(modelData)

                font.family: Settings.workspaces.fontFamily
                font.pixelSize: Settings.fontSizeSmall
                text: Icons.getWorkspaceLabel(modelData.id)
            }
        }
    }
}
