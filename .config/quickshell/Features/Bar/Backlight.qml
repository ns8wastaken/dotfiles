import QtQuick
import "../../Shared/Components"
import "../../Shared/Icons"
import "../../Services"
import "../../Shared/Theme"

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

        LevelMaterialIcon {
            icons: [
                "brightness_1",
                "brightness_2",
                "brightness_3",
                "brightness_4",
                "brightness_5",
                "brightness_6",
                "brightness_7"
            ]
            value: BacklightService.brightnessNormalized
            min: 0.10
            max: 0.80

            anchors.verticalCenter: parent.verticalCenter

            color: Theme.color.on_secondary_container
            font.pixelSize: Theme.fontSize.normal
        }

        StyledText {
            anchors.verticalCenter: parent.verticalCenter

            text: Math.round(BacklightService.brightnessPercentage) + '%'

            font.pixelSize: Theme.fontSize.small

            color: Theme.color.on_secondary_container
        }
    }
}
