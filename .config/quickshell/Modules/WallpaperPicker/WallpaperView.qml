pragma ComponentBehavior: Bound

import QtQuick
import qs.Components
import qs.Config
import qs.Theme

ListView {
    id: root

    required property list<string> filteredWallpaperNames

    orientation: ListView.Horizontal
    spacing: Config.wallpaperPicker.spacing

    cacheBuffer: width
    reuseItems: true

    highlightMoveDuration: 200
    highlightRangeMode: ListView.StrictlyEnforceRange
    preferredHighlightBegin: (width - Config.wallpaperPicker.wallpaperWidth) / 2
    preferredHighlightEnd: preferredHighlightBegin + Config.wallpaperPicker.wallpaperWidth

    keyNavigationWraps: true

    delegate: Item {
        id: wallpaperEntry

        required property string modelData
        required property int index

        anchors.verticalCenter: parent.verticalCenter

        width: Config.wallpaperPicker.wallpaperWidth
        height: Config.wallpaperPicker.wallpaperHeight

        // Wallpaper
        RoundedImage {
            readonly property bool isSelected: root.currentIndex === wallpaperEntry.index

            anchors.fill: parent

            radius: 16

            image.source: wallpaperEntry.modelData
            image.fillMode: Image.PreserveAspectCrop

            image.asynchronous: true
            image.smooth: true
            image.mipmap: true

            // Wallpaper name
            Text {
                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                    margins: 8
                }

                antialiasing: true
                smooth: true

                text: root.filteredWallpaperNames[wallpaperEntry.index] ?? "Placeholder name"

                color: "#ffffff"

                font.family: Config.fonts.sans
                font.pixelSize: Config.fontSizeSmaller

                elide: Text.ElideMiddle

                style: Text.Outline
                styleColor: Theme.backgroundPrimary
            }
        }
    }
}
