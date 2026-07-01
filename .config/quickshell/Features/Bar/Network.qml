import QtQuick
import "../../Shared/Components"
import "../../Shared/Icons"
import "../../Shared/Theme"

Item {
    width: text.width
    height: text.height

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        MaterialIcon {
            id: text

            anchors.centerIn: parent

            text: "signal_wifi_4_bar"

            color: Theme.color.on_secondary_container
            font.pixelSize: Theme.fontSize.normal
        }
    }
}
