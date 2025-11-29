import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Settings
import "./Modules"

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
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
        spacing: bar.spacing

        Workspaces {}
    }

    // Center
    RowLayout {
        anchors.centerIn: parent
        spacing: bar.spacing

        Clock {}
    }

    // Right
    RowLayout {
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
        spacing: bar.spacing

        Tray {}
        Controls {}
        Battery {}
    }
}
