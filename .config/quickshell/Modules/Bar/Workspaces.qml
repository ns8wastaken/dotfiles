pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Hyprland
import qs.Config
import qs.Theme

Row {
    id: root

    spacing: 8

    readonly property int animationDuration: 75

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
                    duration: root.animationDuration
                    easing.type: Easing.InOutCubic
                }
            }

            Behavior on color {
                ColorAnimation {
                    duration: root.animationDuration
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

                font.family: Config.fonts.japanese
                font.pixelSize: Config.fontSizeSmall
                text: Icons.getWorkspaceLabel(parent.modelData.id)

                Behavior on color {
                    ColorAnimation {
                        duration: root.animationDuration
                    }
                }
            }
        }
    }
}
