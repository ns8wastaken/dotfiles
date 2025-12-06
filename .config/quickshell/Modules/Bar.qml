import QtQuick
import Quickshell
import qs.Settings
import qs.Modules.Bar

PanelWindow {
    id: bar
    color: "transparent"

    property int spacing: 8

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
