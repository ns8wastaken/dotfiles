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

            text: UPower.displayDevice.percentage < 0.05
                ? "battery_0_bar"
                : UPower.displayDevice.percentage < 0.2
                ? "battery_1_bar"
                : UPower.displayDevice.percentage < 0.35
                ? "battery_2_bar"
                : UPower.displayDevice.percentage < 0.5
                ? "battery_3_bar"
                : UPower.displayDevice.percentage < 0.65
                ? "battery_5_bar"
                : UPower.displayDevice.percentage < 0.8
                ? "battery_5_bar"
                : UPower.displayDevice.percentage < 0.95
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
