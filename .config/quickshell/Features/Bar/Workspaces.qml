pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Hyprland
import "../../Shared/Components"
import "../../Shared/Animations"
import "../../Shared/Theme"

Row {
    id: root

    spacing: Theme.spacing.normal

    function getWorkspaceColor(modelData: HyprlandWorkspace): color {
        if (modelData.active) return Theme.color.secondary;
        if (modelData.urgent) return Theme.color.error;
        return Theme.color.secondary_container;
    }

    Repeater {
        model: Hyprland.workspaces

        // Workspace button
        delegate: Pill {
            id: workspaceButton

            required property HyprlandWorkspace modelData

            readonly property int baseSize: 11

            width: (modelData.active ? 3 * baseSize : baseSize)
            height: baseSize
            color: modelData ? root.getWorkspaceColor(modelData) : "transparent"

            Behavior on width {
                NAnim { easing.type: Easing.OutCubic }
            }
            Behavior on color {
                ColorAnimation { duration: Theme.anim.fast; easing.type: Easing.OutCubic }
            }

            // Switch to workspace on click
            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch(`hl.dsp.focus({workspace=${parent.modelData.id}})`)
            }
        }
    }
}
