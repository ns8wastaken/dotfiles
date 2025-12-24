import QtQuick
import Quickshell
import Quickshell.Widgets

// Item {
//     id: root
//
//     property alias bgRect: bgRect
//     property alias image: imageSource
//
//     property real radius: 0
//
//     signal statusChanged(int status)
//
//     Rectangle {
//         id: bgRect
//
//         anchors.fill: parent
//         radius: root.radius
//         color: "transparent"
//         border.width: 0
//
//         Image {
//             id: imageSource
//             anchors.fill: parent
//             anchors.margins: bgRect.border.width
//             visible: false
//             smooth: true
//             asynchronous: true
//             antialiasing: true
//             onStatusChanged: root.statusChanged(status)
//         }
//
//         ShaderEffect {
//             anchors.fill: parent
//             anchors.margins: bgRect.border.width
//
//             property variant source: imageSource
//             property real itemWidth: width
//             property real itemHeight: height
//             property real sourceWidth: imageSource.sourceSize.width
//             property real sourceHeight: imageSource.sourceSize.height
//             property real cornerRadius: Math.max(0, root.radius - bgRect.border.width)
//             property real imageOpacity: 1.0
//             property int fillMode: imageSource.fillMode
//
//             fragmentShader: Qt.resolvedUrl(Quickshell.shellPath("Shaders/Qsb/RoundedImage.frag.qsb"))
//             supportsAtlasTextures: false
//             blending: true
//         }
//     }
// }

// Are you shitting me rn?
ClippingRectangle {
    property alias image: image

    Image {
        id: image
    }
}
