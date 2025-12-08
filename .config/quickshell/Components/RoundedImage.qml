import Quickshell.Widgets
import QtQuick
import qs.Settings

ClippingRectangle {
    property alias image: image

    Image {
        id: image
        height: parent.height
        width: parent.height
    }
}

