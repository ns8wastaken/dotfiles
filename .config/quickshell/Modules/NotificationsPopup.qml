pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.Modules.NotificationsPopup
import qs.Services
import qs.Settings

Variants {
    id: root

    model: Quickshell.screens

    property int marginTop: Settings.notifications.marginTop
    property int marginRight: Settings.notifications.marginRight

    delegate: PanelWindow {
        required property var modelData

        WlrLayershell.layer: WlrLayer.Overlay

        anchors {
            top: true
            right: true
        }

        margins.top: root.marginTop
        margins.right: root.marginRight

        color: "transparent"

        mask: Region { item: notifList }

        implicitWidth: Settings.notifications.width
        implicitHeight: (Settings.notifications.height + Settings.notifications.spacing)
            * Settings.notifications.maxVisible - Settings.notifications.spacing

        Column {
            id: notifList

            anchors.top: parent.top
            spacing: Settings.notifications.spacing

            Repeater {
                model: NotificationService.notifications
                delegate: NotificationEntry {}
            }
        }
    }
}
