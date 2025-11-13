import QtQuick
import Quickshell
import qs.Components

Squircle {
    roundness: 4.0
    fillColor: "#ffffff"

    implicitWidth: 20
    implicitHeight: 20

    MouseArea {
        id: mouseArea

        hoverEnabled: true
        anchors.fill: parent
    }

    PopupWindow {
        anchor {
            window: parentWindow
            // rect.x: parentWindow.implicitWidth / 2 - implicitWidth / 2
            // rect.y: parentWindow.implicitHeight
        }

        visible: mouseArea.containsMouse

        implicitWidth: 500
        implicitHeight: 500
    }

    PanelWindow {
        implicitWidth: squircle.width
        implicitHeight: squircle.height
        color: "transparent"

        visible: mouseArea.containsMouse

        Squircle {
            id: squircle

            roundness: 4.0
            fillColor: "#3498db"
            width: 200
            height: 200

            Squircle {
                roundness: 4.0
                fillColor: "#317fb3"
                anchors.centerIn: parent
                width: 100
                height: 100
            }
        }
    }
}
