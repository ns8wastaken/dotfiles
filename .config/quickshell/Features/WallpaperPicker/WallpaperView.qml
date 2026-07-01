pragma ComponentBehavior: Bound

import QtQuick
import Quickshell.Widgets
import "../../Shared/Components"
import "../../Services/Config"
import "../../Shared/Theme"

ListView {
    id: root

    implicitHeight: Config.wallpaperPicker.wallpaperHeight

    orientation: ListView.Horizontal
    spacing: Config.wallpaperPicker.spacing

    // Preload 2 wallpapers before and after the visible ones
    cacheBuffer: Config.wallpaperPicker.wallpaperWidth * 2
    reuseItems: true

    highlightMoveDuration: Theme.anim.normal
    highlightRangeMode: ListView.StrictlyEnforceRange
    preferredHighlightBegin: (width - Config.wallpaperPicker.wallpaperWidth) / 2
    preferredHighlightEnd: preferredHighlightBegin + Config.wallpaperPicker.wallpaperWidth

    keyNavigationWraps: true

    flickDeceleration: 2000

    // Wallpaper
    delegate: ClippingRectangle {
        id: wallpaperEntry

        required property int index
        required property url fileUrl
        required property url fileName

        width: Config.wallpaperPicker.wallpaperWidth
        height: Config.wallpaperPicker.wallpaperHeight

        radius: 16

        Rectangle {
            anchors.fill: parent
            color: Theme.color.surface
        }

        Image {
            anchors.centerIn: parent
            source: wallpaperEntry.fileUrl
            sourceSize.height: Config.wallpaperPicker.wallpaperHeight
            fillMode: Image.PreserveAspectCrop
            asynchronous: true
            cache: false
        }

        // Wallpaper name
        StyledText {
            anchors {
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                margins: 6
            }

            text: wallpaperEntry.fileName

            color: "#ffffff"

            font.pixelSize: Theme.fontSize.smaller

            style: Text.Outline
            styleColor: "#000000"

            elide: Text.ElideMiddle

            horizontalAlignment: Text.AlignHCenter
        }
    }
}
