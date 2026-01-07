import QtQuick
import qs.Components
import qs.Theme

Item {
    width: text.width
    height: text.height

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        LucideIcon {
            id: text

            anchors.centerIn: parent

            source: "wifi"
            color: Theme.color.on_primary_container
            size: Theme.fontSize.normal
        }
    }
}
