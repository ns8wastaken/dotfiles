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

    Rectangle {
        anchors.fill: parent

        color: Theme.backgroundPrimary
        radius: 8

        border.color: Theme.outline
        border.width: 1
    }

    RowLayout {
        anchors.fill: parent
        spacing: bar.spacing

        // Left
        RowLayout {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            Layout.leftMargin: 10
            spacing: bar.spacing

            Workspaces {}
        }

        // Filler (pushes middle and right sections apart)
        Item { Layout.fillWidth: true }

        // Center
        RowLayout {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
            spacing: bar.spacing

            Clock {}
        }

        // Filler (pushes right section to the right)
        Item { Layout.fillWidth: true }

        // Right
        RowLayout {
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            Layout.rightMargin: 10
            spacing: bar.spacing

            Tray {}
            Battery {}
        }
    }
}
