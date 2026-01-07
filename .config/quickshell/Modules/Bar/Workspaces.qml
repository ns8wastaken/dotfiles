pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Hyprland
import qs.Config
import qs.Theme

Row {
    id: root

    spacing: Theme.spacing.normal

    function getWorkspaceColor(modelData: HyprlandWorkspace): color {
        if (modelData.active) return Theme.color.secondary;
        if (modelData.urgent) return Theme.color.error;
        return Theme.color.secondary_container;
    }

    function getWorkspaceTextColor(modelData: HyprlandWorkspace): color {
        if (modelData.active) return Theme.color.on_secondary;
        if (modelData.urgent) return Theme.color.on_error;
        return Theme.color.on_secondary_container;
    }

    Repeater {
        model: Hyprland.workspaces

        // Workspace button
        delegate: Rectangle {
            required property HyprlandWorkspace modelData

            width: (modelData.active ? 40 : 20) + workspaceLabel.width
            height: 18
            radius: 40
            color: root.getWorkspaceColor(modelData)

            // Scaling animation
            Behavior on width {
                NumberAnimation {
                    duration: Theme.anim.small
                    easing.type: Easing.InOutCubic
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: Theme.anim.small
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

                color: root.getWorkspaceTextColor(parent.modelData)

                font.family: Theme.fonts.japanese
                font.pixelSize: Theme.fontSize.small
                text: Icons.getWorkspaceLabel(parent.modelData.id)

                Behavior on color {
                    ColorAnimation {
                        duration: Theme.anim.small
                    }
                }
            }
        }
    }
}
