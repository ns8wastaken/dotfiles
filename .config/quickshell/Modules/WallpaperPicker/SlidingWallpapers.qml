pragma ComponentBehavior: Bound

import QtQuick
import qs.Components
import qs.Config
import qs.Theme

PathView {
    id: root

    required property list<string> filteredWallpaperNames

    // Wallpaper entry
    delegate: Item {
        id: wallpaperEntry

        required property var modelData
        required property int index

        width: 400
        height: 300

        scale: PathView.scale
        z: PathView.z

        // Wallpaper
        RoundedImage {
            readonly property bool isSelected: root.currentIndex === wallpaperEntry.index

            anchors.fill: parent

            radius: 16

            image.source: wallpaperEntry.modelData
            image.fillMode: Image.PreserveAspectCrop

            image.asynchronous: true
            image.smooth: true

            bgRect.border.color: isSelected ? "#4a9eff" : "transparent"
            bgRect.border.width: 3

            // Wallpaper name
            Text {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: 8

                text: root.filteredWallpaperNames[wallpaperEntry.index]

                color: "#ffffff"

                font.family: Config.fonts.sans
                font.pixelSize: 12

                elide: Text.ElideMiddle

                style: Text.Raised
                styleColor: Theme.backgroundPrimary
            }
        }
    }

    path: Path {
        startX: -100
        startY: root.height / 2

        PathAttribute { name: "z";     value: 0   }
        PathAttribute { name: "scale"; value: 0.6 }

        PathLine      { x: root.width / 2; y: root.height / 2 }
        PathAttribute { name: "z";     value: 10  }
        PathAttribute { name: "scale"; value: 1.0 }

        PathLine      { x: root.width + 100; y: root.height / 2 }
        PathAttribute { name: "z";     value: 0   }
        PathAttribute { name: "scale"; value: 0.6 }
    }

    // Center the highlighted wallpaper
    preferredHighlightBegin: 0.5
    preferredHighlightEnd: 0.5
}
