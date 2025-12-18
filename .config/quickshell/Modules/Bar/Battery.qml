import QtQuick
import Quickshell.Services.UPower
import qs.Components
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

        MaterialIcon {
            readonly property real min: 0.05
            readonly property real max: 0.95
            readonly property real step: (max - min) / 6

            anchors.verticalCenter: parent.verticalCenter

            text: UPower.displayDevice.percentage < min
                ? "battery_0_bar"
                : UPower.displayDevice.percentage < min + step
                ? "battery_1_bar"
                : UPower.displayDevice.percentage < min + step * 2
                ? "battery_2_bar"
                : UPower.displayDevice.percentage < min + step * 3
                ? "battery_3_bar"
                : UPower.displayDevice.percentage < min + step * 4
                ? "battery_5_bar"
                : UPower.displayDevice.percentage < min + step * 5
                ? "battery_5_bar"
                : UPower.displayDevice.percentage < max
                ? "battery_6_bar"
                : "battery_full";

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
