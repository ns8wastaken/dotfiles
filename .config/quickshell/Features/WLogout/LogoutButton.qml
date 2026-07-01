import QtQuick
import Quickshell.Io

Item {
    id: root

    property color cardColor1: Qt.rgba(1, 1, 1, 0.145)
    property color cardColor2: Qt.rgba(1, 1, 1, 0.145)
    property real gradientAngle: 0.0

    property real rotationAngle: 0.0
    property string labelText: ""
    property string iconSource: ""

    property string command: ""
    property var keybind: null

    readonly property Process process: Process {
        command: ["sh", "-c", root.command]
    }

    function exec() { process.startDetached(); }
}
