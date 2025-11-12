import Quickshell.Widgets
import QtQuick
import qs.Settings

Item {
    id: root

    property alias source: image.source
    property alias fillMode: image.fillMode
    property real radius

    ClippingRectangle {
        height: parent.height
        width: parent.height
        radius: root.radius
        border.width: 2

        border.color: Theme.outline
        color: Theme.backgroundPrimary

        Image {
            id: image
            height: parent.height
            width: parent.height
        }
    }
}
