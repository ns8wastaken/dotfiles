pragma ComponentBehavior: Bound

import QtQuick
import qs.Components
import qs.Config

ListView {
    id: root

    implicitHeight: Config.wallpaperPicker.wallpaperHeight

    orientation: ListView.Horizontal
    spacing: Config.wallpaperPicker.spacing

    // Preload 2 wallpapers before and after the visible ones
    cacheBuffer: Config.wallpaperPicker.wallpaperWidth * 2
    reuseItems: true

    highlightMoveDuration: 200
    highlightRangeMode: ListView.StrictlyEnforceRange
    preferredHighlightBegin: (width - Config.wallpaperPicker.wallpaperWidth) / 2
    preferredHighlightEnd: preferredHighlightBegin + Config.wallpaperPicker.wallpaperWidth

    keyNavigationWraps: true

    flickDeceleration: 2000

    // Wallpaper
    delegate: RoundedImage {
        id: wallpaperEntry

        required property int index
        required property url fileUrl
        required property url fileName

        width: Config.wallpaperPicker.wallpaperWidth
        height: Config.wallpaperPicker.wallpaperHeight

        radius: 16

        image.source: fileUrl
        image.sourceSize.height: Config.wallpaperPicker.wallpaperHeight
        image.fillMode: Image.PreserveAspectCrop
        image.asynchronous: true
        image.mipmap: true

        // Wallpaper name
        Text {
            anchors {
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                margins: 6
            }

            text: wallpaperEntry.fileName

            color: "#ffffff"

            font.family: Config.fonts.sans
            font.pixelSize: Config.fontSizeSmaller

            style: Text.Outline
            styleColor: "#000000"

            elide: Text.ElideMiddle

            horizontalAlignment: Text.AlignHCenter
        }
    }
}
