import QtQuick
import Quickshell.Services.UPower
import qs.Components
import qs.Config
import qs.Theme

Pill {
    width: text.width + 12
    height: 18

    color: Theme.surface

    visible: UPower.displayDevice.isLaptopBattery

    Row {
        id: text

        anchors.centerIn: parent

        MaterialIcon {
            anchors.verticalCenter: parent.verticalCenter

            text: "battery_full"
            color: Theme.textPrimary
            font.pixelSize: Config.fontSizeSmall
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter

            text: Math.round(UPower.displayDevice.percentage * 100) + '%'

            font.pixelSize: Config.fontSizeSmall
            font.family: Config.fonts.sans

            color: Theme.textPrimary
        }
    }
}
