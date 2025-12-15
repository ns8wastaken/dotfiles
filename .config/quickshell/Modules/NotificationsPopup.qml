pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.Modules.NotificationsPopup
import qs.Services
import qs.Config

Variants {
    id: root

    model: Quickshell.screens

    delegate: PanelWindow {
        required property var modelData

        WlrLayershell.layer: WlrLayer.Overlay

        anchors {
            top: true
            right: true
        }

        margins {
            top: Config.notifications.marginTop
            right: Config.notifications.marginRight
        }

        color: "transparent"

        mask: Region { item: notifList }

        implicitWidth: Config.notifications.width
        implicitHeight: (Config.notifications.height + Config.notifications.spacing)
            * Config.notifications.maxVisible - Config.notifications.spacing;

        Column {
            id: notifList

            anchors.top: parent.top
            spacing: Config.notifications.spacing

            Repeater {
                model: NotificationService.notifications
                delegate: NotificationEntry {}
            }
        }
    }
}
