import QtQuick
import Quickshell.Services.UPower
import qs.Components
import qs.Widgets
import qs.Config
import qs.Theme

Pill {
    id: root

    width: text.width + 12
    height: 18

    color: Theme.surface

    visible: UPower.displayDevice.isLaptopBattery

    Row {
        id: text

        anchors.centerIn: parent
        spacing: 4

        LevelLucideIcon {
            icons: ["battery-warning", "battery", "battery-low", "battery-medium", "battery-full"]
            value: UPower.displayDevice.percentage
            min: 0.10
            max: 0.95

            anchors.verticalCenter: parent.verticalCenter

            color: Theme.textPrimary
            size: Config.fontSizeNormal
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
