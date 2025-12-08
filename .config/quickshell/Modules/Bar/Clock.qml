import QtQuick
import qs.Settings
import qs.Services

Item {
    implicitWidth: text.width
    implicitHeight: text.height

    Text {
        id: text
        anchors.centerIn: parent

        color: Theme.textPrimary

        font.pixelSize: Settings.fontSizeNormal
        font.family: Settings.bar.fontFamily
        text: TimeService.time

        // Show sytem info on hover
        // MouseArea {
        //     anchors.fill: parent
        //
        //     hoverEnabled: true
        // }
    }
}
