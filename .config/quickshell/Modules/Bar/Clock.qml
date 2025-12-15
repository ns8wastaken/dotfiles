import Quickshell
import QtQuick
import qs.Services
import qs.Config
import qs.Theme

Item {
    id: root

    width: text.width
    height: text.height

    Text {
        id: text

        anchors.centerIn: parent

        color: Theme.textPrimary

        font.pixelSize: Config.fontSizeNormal
        font.family: Config.fonts.clock
        text: TimeService.time

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    PopupWindow {
        id: popup

        visible: mouseArea.containsMouse

        implicitWidth: 200
        implicitHeight: 100

        anchor {
            window: root.QsWindow.window
            rect.x: (parentWindow?.width - width) / 2
            rect.y: 50
        }
    }
}
