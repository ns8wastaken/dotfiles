import QtQuick
import Quickshell
import qs.Settings
import qs.Modules.Bar

PanelWindow {
    id: bar
    color: "transparent"

    property int spacing: 8

    implicitHeight: 32

    anchors {
        top: true
        left: true
        right: true
    }

    margins {
        top: Settings.bar.margins.top
        left: Settings.bar.margins.left
        right: Settings.bar.margins.right
        bottom: Settings.bar.margins.bottom
    }

    // Background
    Rectangle {
        anchors.fill: parent

        color: Theme.backgroundPrimary
        radius: 8

        border.color: Theme.outline
        border.width: 1
    }

    // Left
    Row {
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 10
        }
        spacing: bar.spacing

        Workspaces { anchors.verticalCenter: parent.verticalCenter }
    }

    // Center
    Row {
        anchors.centerIn: parent
        spacing: bar.spacing

        Clock { anchors.verticalCenter: parent.verticalCenter }
    }

    // Right
    Row {
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 10
        }
        spacing: bar.spacing

        Tray { anchors.verticalCenter: parent.verticalCenter }
        Controls { anchors.verticalCenter: parent.verticalCenter }
        Battery { anchors.verticalCenter: parent.verticalCenter }
    }
}
