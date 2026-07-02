import QtQuick
import QtQuick.Effects
import "../../Shared/Components"
import "../../Shared/Icons"
import "../../Services"
import "../../Services/Config"
import "../../Shared/Theme"

Pill {
    id: root

    width: textRow.width + Config.bar.spacing * 2
    height: 20

    color: Theme.color.surface

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

            color: Theme.color.on_surface
            font.pixelSize: Theme.fontSize.normal
        }

        StyledText {
            anchors.verticalCenter: parent.verticalCenter

            text: Math.round(BacklightService.brightnessPercentage) + '%'

            font.pixelSize: Theme.fontSize.small

            color: Theme.color.on_surface
        }
    }
}
