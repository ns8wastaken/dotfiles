pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import QtQuick

Variants {
    id: root

    required property string text
    required property var color
    required property int size
    required property string fontFamily
    property panelAnchors anchors
    property margins margins

    // Create the panel once on each monitor.
    model: Quickshell.screens

    delegate: PanelWindow {
        required property var modelData

        screen: modelData

        anchors: root.anchors
        margins: root.margins

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

                font.family: root.fontFamily
                font.pointSize: root.size
            }
        }
    }
}
