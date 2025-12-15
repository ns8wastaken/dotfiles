import QtQuick
import qs.Components
import qs.Config
import qs.Theme

Item {
    anchors.verticalCenter: parent.verticalCenter

    width: text.width
    height: text.height

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        MaterialIcon {
            id: text

            anchors.centerIn: parent

            color: Theme.textPrimary
            font.pointSize: Config.fontSizeSmaller

            text: "signal_wifi_4_bar"
        }
    }
}
