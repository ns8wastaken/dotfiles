import QtQuick
import qs.Components
import qs.Widgets
import qs.Services
import qs.Theme

Pill {
    id: root

    width: textRow.width + 12
    height: 18

    color: Theme.color.secondary_container

    // visible: UPower.displayDevice.isLaptopBattery

    Row {
        id: textRow

        anchors.centerIn: parent
        spacing: Theme.spacing.small

        LevelLucideIcon {
            icons: ["circle-small", "sun-dim", "sun-medium", "sun"]
            value: BacklightService.brightnessNormalized
            min: 0.10
            max: 0.80

            anchors.verticalCenter: parent.verticalCenter

            color: Theme.color.on_secondary_container
            size: Theme.fontSize.normal
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter

            text: Math.round(BacklightService.brightnessPercentage) + '%'

            font.pixelSize: Theme.fontSize.small
            font.family: Theme.fonts.sans

            color: Theme.color.on_secondary_container
        }
    }
}
