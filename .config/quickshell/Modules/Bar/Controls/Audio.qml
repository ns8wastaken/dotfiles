import QtQuick
import qs.Services
import qs.Widgets
import qs.Config
import qs.Theme

Item {
    width: row.implicitWidth
    height: row.implicitHeight

    MouseArea {
        anchors.fill: row
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton

        onClicked: function(mouse) {
            AudioService.sink.toggleMute();
        }

        onWheel: function(event) {
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
        spacing: 4

        LevelLucideIcon {
            icons: ["volume-off", "volume", "volume-1", "volume-2"]
            value: AudioService.sink.volume
            min: 0.05
            max: 0.95

            anchors.verticalCenter: parent.verticalCenter

            size: Theme.fontSize.normal
            color: AudioService.sink.muted ? Theme.colors.textDisabled : Theme.colors.textPrimary
        }

        Text {
            // TODO: add a setting for this
            visible: true

            anchors.verticalCenter: parent.verticalCenter
            text: AudioService.sink.percentage + '%'

            color: AudioService.sink.muted ? Theme.colors.textDisabled : Theme.colors.textPrimary

            font.family: Theme.fonts.sans
            font.pixelSize: Theme.fontSize.small
        }
    }
}
