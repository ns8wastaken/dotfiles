import QtQuick
import Quickshell.Services.UPower
import qs.Components
import qs.Settings

Pill {
    implicitWidth: text.width + 12
    implicitHeight: 18

    color: Theme.surface

    // visible: UPower.displayDevice.isLaptopBattery

    Row {
        id: text

        anchors.centerIn: parent

        MaterialIcon {
            anchors.verticalCenter: parent.verticalCenter

            text: "battery_full"
            color: Theme.textPrimary
            font.pixelSize: Settings.fontSizeSmall
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter

            text: Math.round(UPower.displayDevice.percentage * 100) + '%'

            font.pixelSize: Settings.fontSizeSmall
            font.family: Settings.bar.fontFamily

            color: Theme.textPrimary
        }
    }
}
