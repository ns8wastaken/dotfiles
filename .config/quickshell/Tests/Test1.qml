import QtQuick
import Quickshell

PanelWindow {
    id: root
    width: 200
    height: 200
    visible: true
    color: "#1e1e2e"

    mask: Region {}

    ShaderEffect {
        anchors.fill: parent

        property vector2d resolution: Qt.vector2d(width, height)
        property real radius: 4.0
        property real jointRadius: 4.0
        property color shapeColor: "#89b4fa"
        property int rectCount: 3

        property vector4d rect0: Qt.vector4d(0.0, 0.0, 0.0, 0.0)
        property vector4d rect1: Qt.vector4d(0.0, 0.0, 0.0, 0.0)
        property vector4d rect2: Qt.vector4d(0.0, 0.0, 0.0, 0.0)
        property vector4d rect3: Qt.vector4d(0.0, 0.0, 0.0, 0.0)

        fragmentShader: Quickshell.shellPath("Shaders/Qsb/RoundedJoints.frag.qsb")
    }
}
