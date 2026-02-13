import QtQuick
import qs.Components
import qs.Services
import qs.Widgets
import qs.Theme

Pill {
    id: root

    width: text.width + 12
    height: 18

    color: Theme.color.secondary_container

    visible: BatteryService.isValidBattery

    Row {
        id: text

        anchors.centerIn: parent
        spacing: Theme.spacing.small

        LevelMaterialIcon {
            readonly property list<string> normalIcons: [
                "battery_0_bar",
                "battery_1_bar",
                "battery_2_bar",
                "battery_3_bar",
                "battery_4_bar",
                "battery_5_bar",
                "battery_6_bar"
            ]
            readonly property list<string> chargingIcons: [
                "battery_charging_20",
                "battery_charging_30",
                "battery_charging_50",
                "battery_charging_60",
                "battery_charging_80",
                "battery_charging_90",
                "battery_charging_full"
            ]
            icons: BatteryService.isCharging ? chargingIcons : normalIcons
            value: BatteryService.percentage
            min: 0.10
            max: 0.95

            anchors.verticalCenter: parent.verticalCenter

            color: Theme.color.on_surface
            font.pixelSize: Theme.fontSize.normal
        }

        StyledText {
            anchors.verticalCenter: parent.verticalCenter

            text: Math.round(BatteryService.percentage * 100) + '%'

            font.pixelSize: Theme.fontSize.small

            color: Theme.color.on_secondary_container
        }
    }
}
