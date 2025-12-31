import QtQuick
import Quickshell.Widgets

ClippingRectangle {
    property alias image: image

    Image {
        id: image
        anchors.fill: parent
    }
}
