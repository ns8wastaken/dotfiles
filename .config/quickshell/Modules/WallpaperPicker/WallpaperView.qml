pragma ComponentBehavior: Bound

import QtQuick
import qs.Components
import qs.Config
import qs.Theme

ListView {
    id: root

    required property list<string> filteredWallpaperNames

    implicitHeight: Config.wallpaperPicker.wallpaperHeight

    orientation: ListView.Horizontal
    spacing: Config.wallpaperPicker.spacing

    cacheBuffer: width
    reuseItems: true

    highlightMoveDuration: 200
    highlightRangeMode: ListView.StrictlyEnforceRange
    preferredHighlightBegin: (width - Config.wallpaperPicker.wallpaperWidth) / 2
    preferredHighlightEnd: preferredHighlightBegin + Config.wallpaperPicker.wallpaperWidth

    keyNavigationWraps: true

    // Wallpaper
    delegate: RoundedImage {
        id: wallpaperEntry

        required property string modelData
        required property int index

        readonly property bool isSelected: root.currentIndex === index

        width: Config.wallpaperPicker.wallpaperWidth
        height: Config.wallpaperPicker.wallpaperHeight

        radius: 16

        image.source: modelData
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

            text: root.filteredWallpaperNames[wallpaperEntry.index] ?? "Placeholder name"

            color: "#ffffff"

            font.family: Config.fonts.sans
            font.pixelSize: Config.fontSizeSmaller

            style: Text.Outline
            styleColor: Theme.backgroundPrimary

            elide: Text.ElideMiddle

            horizontalAlignment: Text.AlignHCenter
        }
    }
}
