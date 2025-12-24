import QtQuick
import qs.Modules.Bar
import qs.Config
import qs.Theme

Rectangle {
    id: root

    color: Theme.backgroundPrimary
    radius: 8

    border.color: Theme.outline
    border.width: 1

    // Left
    Row {
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: 10
        }
        spacing: Config.bar.spacing

        Workspaces { anchors.verticalCenter: parent.verticalCenter }
    }

    // Center
    Row {
        anchors.centerIn: parent
        spacing: Config.bar.spacing

        Clock { anchors.verticalCenter: parent.verticalCenter }
    }

    // Right
    Row {
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
            rightMargin: 10
        }
        spacing: Config.bar.spacing

        Tray { anchors.verticalCenter: parent.verticalCenter }
        Controls { anchors.verticalCenter: parent.verticalCenter }
        Battery { anchors.verticalCenter: parent.verticalCenter }
        ExtraMenu { anchors.verticalCenter: parent.verticalCenter }
    }
}
