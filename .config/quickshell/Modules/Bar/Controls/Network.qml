import QtQuick
import qs.Components
import qs.Config
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
            color: Theme.textPrimary
            size: Config.fontSizeNormal
        }
    }
}
