import QtQuick
import qs.Settings
import qs.Components

Item {
    anchors.verticalCenter: parent.verticalCenter

    implicitWidth: text.implicitWidth
    implicitHeight: text.implicitHeight

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        MaterialIcon {
            id: text

            anchors.centerIn: parent

            color: Theme.textPrimary
            font.pointSize: Settings.fontSizeSmaller

            text: "signal_wifi_4_bar"
        }
    }
}
