pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

Item {
    width: 400
    height: 400

    Rectangle {
        id: sourceRect
        width: 200
        height: 100
        anchors.centerIn: parent
        
        // 1. Apply your radius and rotation here
        radius: 20
        rotation: 45 

        // 2. Enable layering so the radius mask is baked into the texture
        layer.enabled: true
        layer.effect: ShaderEffect {
            property var source: sourceRect // Pass the rounded rect texture

            // 3. Define your uniform properties matching the shader buffer
            property color colorTop: "#ff007f"
            property color colorBottom: "#7f00ff"
            property double angle: 1.0 // in radians
            property double hovered: mixArea.containsMouse ? 1.0 : 0.0

            // Link your fragment shader (separate .frag file or QSB binary)
            fragmentShader: Qt.resolvedUrl(
                Quickshell.shellPath("Shaders/Qsb/WLogoutCardGradient.frag.qsb")
            )

            Behavior on hovered {
                NumberAnimation { duration: 200 }
            }
        }

        MouseArea {
            id: mixArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }
}
