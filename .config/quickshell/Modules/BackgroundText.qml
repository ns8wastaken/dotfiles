pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland

Variants {
    id: root

    required property string text
    required property string color
    required property int size
    property margins borderMargins
    property panelAnchors borderAnchors

    // Create the panel once on each monitor.
    model: Quickshell.screens

    PanelWindow {
        required property var modelData

        screen: modelData

        anchors: root.borderAnchors
        margins: root.borderMargins

        implicitWidth: content.width
        implicitHeight: content.height

        color: "transparent"

        // Give the window an empty click mask so all clicks pass through it.
        mask: Region {}

        WlrLayershell.layer: WlrLayer.Background

        Column {
            id: content

            Text {
                text: root.text

                color: root.color

                font.family: "HanyiSentyScholar"
                font.pointSize: root.size
            }
        }
    }
}
