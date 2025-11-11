import QtQuick
import qs.Settings
import qs.Services
import qs.Modules.Widgets

Item {
    id: clock

    anchors.fill: parent

    property bool hover: false

    Text {
        anchors.centerIn: parent

        text: Time.time
        color: Theme.textPrimary
        font.pixelSize: 16
        font.family: Settings.clock.font

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: clock.hover = true
            onExited: clock.hover = false
        }
    }
}
