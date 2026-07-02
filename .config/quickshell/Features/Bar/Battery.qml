import QtQuick
import QtQuick.Effects
import "../../Shared/Components"
import "../../Shared/Icons"
import "../../Services"
import "../../Services/Config"
import "../../Shared/Theme"

Pill {
    id: root

    width: text.width + Config.bar.spacing * 2
    height: 20

    color: Theme.color.surface

    visible: BatteryService.isValidBattery

    layer.enabled: true
    layer.effect: MultiEffect {
        source: root
        shadowEnabled: true
        shadowColor: Theme.color.shadow
        shadowOpacity: 1
        shadowVerticalOffset: 0
        shadowHorizontalOffset: 0
        shadowBlur: 0.5
    }

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

            color: Theme.color.on_surface
        }
    }
}
