pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import QtQuick

// Variants {
//     id: root
//
//     // required property string text
//     // required property var color
//     // required property int size
//     // required property string fontFamily
//     property alias text: bgText
//     property panelAnchors anchors
//     property margins margins
//
//     // Create the panel once on each monitor.
//     model: Quickshell.screens
//
//     delegate: PanelWindow {
//         required property var modelData
//
//         screen: modelData
//
//         anchors: root.anchors
//         margins: root.margins
//
//         implicitWidth: bgText.width
//         implicitHeight: bgText.height
//
//         color: "transparent"
//
//         // Give the window an empty click mask so all clicks pass through it.
//         mask: Region {}
//
//         WlrLayershell.layer: WlrLayer.Background
//
//         Text {
//             id: bgText
//
//             // text: root.text
//             //
//             // font.family: root.fontFamily
//             // font.pointSize: root.size
//             //
//             // color: root.color
//         }
//     }
// }


PanelWindow {
    property alias text: bgText

    implicitWidth: bgText.width
    implicitHeight: bgText.height

    color: "transparent"

    // Give the window an empty click mask so all clicks pass through it.
    mask: Region {}

    WlrLayershell.layer: WlrLayer.Background

    Text {
        id: bgText
    }
}
