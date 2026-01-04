pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Hyprland
import qs.Config
import qs.Theme

Row {
    id: root

    spacing: Theme.spacing.normal

    Repeater {
        model: Hyprland.workspaces

        // Workspace button
        delegate: Rectangle {
            required property HyprlandWorkspace modelData

            width: (modelData.active ? 40 : 20) + workspaceLabel.width
            height: 18
            radius: 40
            color: Theme.getWorkspaceColor(modelData)

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

                color: Theme.getWorkspaceTextColor(parent.modelData)

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
