import QtQuick
import "../../Services"
import "../../Shared/Components"
import "../../Shared/Icons"
import "../../Shared/Theme"

Item {
    width: text.width
    height: text.height

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton

        onClicked: AudioService.source.toggleMute()
    }

    MaterialIcon {
        id: text

        anchors.centerIn: parent

        text: AudioService.source.muted ? "mic_off" : "mic";

        font.pixelSize: Theme.fontSize.normal
        color: Theme.color.on_secondary_container
        opacity: AudioService.source.muted ? 0.38 : 1.0
    }
}
