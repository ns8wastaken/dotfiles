import QtQuick
import Quickshell
import qs.Settings
import qs.Components
import qs.Services

Rectangle {
    id: root

    anchors.verticalCenter: parent.verticalCenter

    implicitWidth: text.implicitWidth
    implicitHeight: text.implicitHeight

    color: "transparent"

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        MaterialIcon {
            id: text

            anchors.centerIn: parent

            color: Theme.textPrimary
            font.pointSize: Settings.fontSizeSmall

            text: "signal_wifi_4_bar"
        }
    }
}
