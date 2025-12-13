import Quickshell
import QtQuick
import qs.Settings
import qs.Services

Item {
    id: root

    width: text.width
    height: text.height

    Text {
        id: text

        anchors.centerIn: parent

        color: Theme.textPrimary

        font.pixelSize: Settings.fontSizeNormal
        font.family: Settings.bar.fontFamily
        text: TimeService.time

        // Show date on hover
        MouseArea {
            id: mouseArea

            anchors.fill: parent

            hoverEnabled: true
        }
    }

    // Behavior {
    //     NumberAnimation {
    //         id: slideIn
    //         target: popup.anchor.rect
    //         property: "y"
    //         duration: 20
    //         // from: 0
    //         // to: 100
    //         easing.type: Easing.InOutQuad
    //         // running: true
    //         // running: false
    //     }
    // }

    PopupWindow {
        id: popup

        readonly property int spacing: 4

        visible: mouseArea.containsMouse

        // onVisibleChanged: slideIn.start()

        implicitWidth: 200
        implicitHeight: 100

        anchor {
            window: root.QsWindow.window
            // rect.x: (parentWindow.width - width) / 2
            // rect.y: 100 * (mouseArea.containsMouse)
        }
    }
}
