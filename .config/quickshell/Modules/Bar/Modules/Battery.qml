import QtQuick
import Quickshell.Services.UPower
import qs.Settings

Item {
    anchors.fill: parent

    visible: UPower.displayDevice.isLaptopBattery

    Rectangle {
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 100

        width: text.width + 10
        height: text.height + 5

        color: Theme.surfaceVariant
        radius: 4

        Text {
            id: text

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            text: (UPower.displayDevice.percentage * 100) + '%'
            color: Theme.textPrimary
            font.family: Settings.fontFamily
            font.pixelSize: Settings.fontSizeNormal
        }
    }
}
