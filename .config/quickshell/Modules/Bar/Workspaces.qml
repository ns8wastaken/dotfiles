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
            width: (modelData.active ? 40 : 20) + workspaceNameText.width
            height: 18
            radius: 40
            color: Settings.workspaces.getButtonColor(modelData)

            // Scaling animation
            Behavior on width {
                NumberAnimation { duration: 75; easing.type: Easing.InOutQuad }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + modelData.id)
            }

            Text {
                id: workspaceNameText

                anchors.centerIn: parent

                font.family: Settings.workspaces.labelFont

                color: Settings.workspaces.getButtonTextColor(modelData)

                text: Settings.workspaces.getLabel(modelData.id)
                font.pixelSize: Settings.fontSizeSmall
            }
        }
    }
}
