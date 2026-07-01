import QtQuick
import "../../Shared/Components"
import "../../Shared/Icons"
import "../../Services"
import "../../Shared/Theme"

Item {
    width: row.implicitWidth
    height: row.implicitHeight

    MouseArea {
        anchors.fill: row
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton

        onClicked: AudioService.sink.toggleMute()

        onWheel: function(event: WheelEvent) {
            if (event.angleDelta.y > 0) {
                AudioService.sink.increaseVolume();
            } else if (event.angleDelta.y < 0) {
                AudioService.sink.decreaseVolume();
            }
            event.accepted = true;
        }
    }

    Row {
        id: row

        anchors.centerIn: parent
        spacing: Theme.spacing.small

        LevelMaterialIcon {
            icons: ["volume_off", "volume_mute", "volume_down", "volume_up"]
            value: AudioService.sink.volume
            min: 0.05
            max: 0.95

            anchors.verticalCenter: parent.verticalCenter

            color: Theme.color.on_secondary_container
            opacity: AudioService.sink.muted ? 0.38 : 1.0
            font.pixelSize: Theme.fontSize.normal
        }

        StyledText {
            // TODO: add a setting for this
            visible: true

            anchors.verticalCenter: parent.verticalCenter
            text: AudioService.sink.percentage + '%'

            color: Theme.color.on_secondary_container
            opacity: AudioService.sink.muted ? 0.38 : 1.0

            font.pixelSize: Theme.fontSize.small
        }
    }
}
