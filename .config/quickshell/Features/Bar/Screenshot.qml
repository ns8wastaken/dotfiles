import QtQuick
import "../../Services"
import "../../Shared/Icons"
import "../../Shared/Theme"

Item {
    width: text.width
    height: text.height

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        acceptedButtons: Qt.LeftButton | Qt.RightButton

        onClicked: function(mouse) {
            if (mouse.button === Qt.LeftButton) {
                ScreenCaptureService.screenshot("area")
            } else {
                ScreenCaptureService.ocr("area")
            }
        }
    }

    MaterialIcon {
        id: text

        anchors.centerIn: parent

        text: "screenshot"

        font.pixelSize: Theme.fontSize.normal
        color: Theme.color.on_secondary_container
    }
}
