import QtQuick
import qs.Services
import qs.Components
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

        size: Theme.fontSize.normal
        color: Theme.color.on_secondary_container
        opacity: AudioService.source.muted ? 0.38 : 1.0
    }
}
