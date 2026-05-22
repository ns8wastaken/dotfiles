pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Hyprland
import qs.Components
import qs.Components.Animations
import qs.Utils
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
        delegate: Pill {
            id: workspaceButton

            required property HyprlandWorkspace modelData

            width: (modelData.active ? 50 : 20) + workspaceLabel.width
            height: 18
            color: modelData ? root.getWorkspaceColor(modelData) : "transparent"

            Behavior on width { NAnim { duration: Theme.anim.normal; easing.type: Easing.OutCubic } }
            Behavior on color { ColorAnimation { duration: Theme.anim.fast } }

            // Switch to workspace on click
            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("hl.dsp.focus({workspace=" + parent.modelData.id + "})")
            }

            StyledText {
                id: workspaceLabel

                anchors.centerIn: parent

                color: workspaceButton.modelData
                    ? root.getWorkspaceTextColor(workspaceButton.modelData)
                    : "transparent";

                font.family: Theme.fonts.japanese
                font.pixelSize: Theme.fontSize.small
                text: workspaceButton.modelData
                    ? Icons.getWorkspaceLabel(workspaceButton.modelData.id)
                    : "";

                Behavior on color { CAnim { duration: Theme.anim.fast } }
            }
        }
    }
}
