import QtQuick
import qs.Settings
import qs.Services

Item {
    implicitWidth: text.width
    implicitHeight: text.height

    Text {
        id: text
        anchors.centerIn: parent

        text: TimeService.time
        color: Theme.textPrimary
        font.pixelSize: Settings.fontSizeNormal
        font.family: Settings.fontFamily

        // Show sytem info on hover
        // MouseArea {
        //     anchors.fill: parent
        //
        //     hoverEnabled: true
        // }
    }
}
