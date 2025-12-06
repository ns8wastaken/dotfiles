import QtQuick
import Quickshell.Services.UPower
import qs.Components
import qs.Settings

Pill {
    implicitWidth: text.width + 10
    implicitHeight: text.height + 5

    color: Theme.surfaceVariant

    // visible: UPower.displayDevice.isLaptopBattery

    Text {
        id: text

        anchors.centerIn: parent

        color: Theme.textPrimary
        font.pixelSize: Settings.fontSizeNormal
        font.family: Settings.fontFamily
        text: Math.round(UPower.displayDevice.percentage * 100) + '%'
    }
}
