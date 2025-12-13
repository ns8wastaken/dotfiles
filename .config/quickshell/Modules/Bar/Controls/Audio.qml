import QtQuick
import qs.Settings
import qs.Components
import qs.Services

Item {
    anchors.verticalCenter: parent.verticalCenter

    width: text.implicitWidth
    height: text.implicitHeight

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        MaterialIcon {
            id: text

            anchors.centerIn: parent

            color: AudioService.muted ? Theme.textDisabled : Theme.textPrimary
            font.pointSize: Settings.fontSizeSmaller

            text: AudioService.volume < 0.05
                ? "volume_off"
                : AudioService.volume < 0.45
                ? "volume_mute"
                : AudioService.volume < 0.8
                ? "volume_down"
                : "volume_up";
        }

        acceptedButtons: Qt.LeftButton

        onClicked: function(mouse) {
            // mouse.button === Qt.LeftButton
            AudioService.toggleMute();
        }
    }
}
