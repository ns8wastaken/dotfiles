import Quickshell
import Quickshell.Widgets
import Qt5Compat.GraphicalEffects
import QtQuick

Item {
    id: root

    required property string source
    required property color color
    required property real size

    width: size
    height: size

    IconImage {
        id: icon
        anchors.fill: parent
        source: Qt.resolvedUrl(Quickshell.shellPath("assets/icons/" + root.source))
    }

    ColorOverlay {
        anchors.fill: parent
        source: icon
        color: root.color
    }
}
