import QtQuick
import QtQuick.Controls
import qs.Services
import qs.Theme

Item {
    id: root

    width: text.width
    height: text.height

    Text {
        id: text

        anchors.centerIn: parent

        color: Theme.colors.textPrimary

        font.pixelSize: Theme.fontSize.normal
        font.family: Theme.fonts.clock
        text: TimeService.time

        HoverHandler {
            id: hoverHandler
        }
    }

    Popup {
        id: popup

        visible: hoverHandler.hovered

        background: Rectangle {
            color: Theme.colors.backgroundPrimary
            radius: 12
            border.color: Theme.colors.outline
            border.width: 1
        }

        padding: 6

        x: (parent.width - width) / 2
        y: 30

        Rectangle {
            implicitWidth: 200
            implicitHeight: 100
        }
    }
}
