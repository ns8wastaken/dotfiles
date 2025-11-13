import QtQuick
import Quickshell.Services.UPower
import qs.Settings

Rectangle {
    implicitWidth: text.width + 10
    implicitHeight: text.height + 5

    color: Theme.surfaceVariant
    radius: 4

    // visible: UPower.displayDevice.isLaptopBattery

    Text {
        id: text

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        text: Math.round(UPower.displayDevice.percentage * 100) + '%'
        color: Theme.textPrimary
        font.family: Settings.fontFamily
        font.pixelSize: Settings.fontSizeNormal
    }
}
