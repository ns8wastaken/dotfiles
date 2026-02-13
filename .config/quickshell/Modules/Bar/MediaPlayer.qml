import QtQuick
import qs.Components
import qs.Services
import qs.Theme

Pill {
    id: root

    width: activeMediaInfo.width + Theme.spacing.normal * 2
    height: 18

    Row {
        id: activeMediaInfo

        anchors.centerIn: parent
        spacing: Theme.spacing.normal

        StyledText {
            id: activeMediaName

            text: MprisService.active.identity
            font.pixelSize: Theme.fontSize.small
        }

        StyledText {
            id: activeMediaPosition

            text: Math.round(MprisService.active.position) + '/' + Math.round(MprisService.active.length)
            font.pixelSize: Theme.fontSize.small
        }
    }
}
