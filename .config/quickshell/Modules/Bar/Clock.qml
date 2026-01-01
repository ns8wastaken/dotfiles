import Quickshell
import QtQuick
import QtQuick.Controls
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

    Popup {
        id: popup

        visible: mouseArea.containsMouse

        background: Rectangle {
            color: Theme.backgroundPrimary
            radius: 12
            border.color: Theme.outline
            border.width: 1
        }

        padding: 6

        x: (parent.width - width) / 2
        y: 30

        Rectangle {
            implicitWidth: 100
            implicitHeight: 100
        }
    }
}
