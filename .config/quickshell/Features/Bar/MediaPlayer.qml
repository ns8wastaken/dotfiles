import QtQuick
import QtQuick.Effects
import "../../Shared/Components"
import "../../Services"
import "../../Shared/Theme"
import "../../Services/Config"

Pill {
    id: root

    visible: MprisService.active.identity !== ""

    width: activeMediaInfo.width + Config.bar.spacing * 2
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
        id: activeMediaInfo

        anchors.centerIn: parent
        spacing: Theme.spacing.normal

        StyledText {
            text: MprisService.active.identity
            font.pixelSize: Theme.fontSize.small
            color: Theme.color.on_surface
        }

        StyledText {
            text: Math.round(MprisService.active.position) + '/' + Math.round(MprisService.active.length)
            font.pixelSize: Theme.fontSize.small
            color: Theme.color.on_surface
        }
    }
}
