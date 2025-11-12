import QtQuick
import Quickshell
import qs.Settings
import "./Modules"

PanelWindow {
    color: "transparent"

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 32

    margins {
        top: 4
        left: 4
        right: 4
    }

    Rectangle {
        anchors.fill: parent

        color: Theme.backgroundPrimary
        radius: 8

        border.color: Theme.outline
        border.width: 1

        Workspaces {}
        Clock {}
        Tray {}
        Battery {}
    }
}
