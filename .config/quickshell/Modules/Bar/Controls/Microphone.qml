import QtQuick
import qs.Services
import qs.Components
import qs.Config
import qs.Theme

Item {
    anchors.verticalCenter: parent.verticalCenter

    width: text.width
    height: text.height

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        MaterialIcon {
            id: text

            anchors.centerIn: parent

            color: AudioService.sourceMuted ? Theme.textDisabled : Theme.textPrimary
            font.pointSize: Config.fontSizeSmaller

            text: AudioService.sourceMuted ? "mic_off" : "mic";
        }

        acceptedButtons: Qt.LeftButton

        onClicked: function(mouse) {
            // mouse.button === Qt.LeftButton
            AudioService.toggleSourceMute();
        }
    }
}
