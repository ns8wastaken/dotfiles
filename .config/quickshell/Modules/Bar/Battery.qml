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

    color: Theme.colors.surface

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

            color: Theme.colors.textPrimary
            size: Theme.fontSize.normal
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter

            text: Math.round(UPower.displayDevice.percentage * 100) + '%'

            font.pixelSize: Theme.fontSize.small
            font.family: Theme.fonts.sans

            color: Theme.colors.textPrimary
        }
    }
}
