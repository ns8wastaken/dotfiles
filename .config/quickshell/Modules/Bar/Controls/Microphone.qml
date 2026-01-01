import QtQuick
import qs.Services
import qs.Components
import qs.Config
import qs.Theme

Item {
    width: text.width
    height: text.height

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton

        onClicked: function(mouse) {
            AudioService.source.toggleMute();
        }
    }

    LucideIcon {
        id: text

        anchors.centerIn: parent

        source: AudioService.source.muted ? "mic-off" : "mic";

        color: AudioService.source.muted ? Theme.colors.textDisabled : Theme.colors.textPrimary
        size: Theme.fontSize.normal
    }
}
