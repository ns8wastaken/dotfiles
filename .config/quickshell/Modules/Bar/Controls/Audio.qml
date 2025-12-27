import QtQuick
import qs.Services
import qs.Components
import qs.Config
import qs.Theme

Item {
    anchors.verticalCenter: parent.verticalCenter

    width: row.implicitWidth
    height: row.implicitHeight

    MouseArea {
        anchors.fill: row
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton

        onClicked: function(mouse) {
            AudioService.sink.toggleMute();
        }
    }

    Row {
        id: row

        anchors.centerIn: parent

        MaterialIcon {
            id: text

            readonly property real min: 0.05
            readonly property real max: 0.95
            readonly property real step: Math.round((max - min) / 2 * 100) / 100

            anchors.verticalCenter: parent.verticalCenter

            color: AudioService.sink.muted ? Theme.textDisabled : Theme.textPrimary
            font.pixelSize: Config.fontSizeNormal

            text: AudioService.sink.volume <= min
                ? "volume_off"
                : AudioService.sink.volume <= min + step
                ? "volume_mute"
                : AudioService.sink.volume < max
                ? "volume_down"
                : "volume_up";
        }

        Text {
            // TODO: add a setting for this
            visible: true

            anchors.verticalCenter: parent.verticalCenter
            text: AudioService.sink.percentage + '%'

            color: Theme.textPrimary

            font.family: Config.fonts.sans
            font.pixelSize: Config.fontSizeSmall
        }
    }
}
