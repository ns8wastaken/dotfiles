import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.Services
import qs.Components
import qs.Settings

PanelWindow {
    anchors {
        top: true
        right: true
    }

    implicitWidth: notifList.width
    implicitHeight: notifList.height

    Item {
        id: notifList

        implicitWidth: notifications.implicitWidth + (Settings.notificationPadding * 2)
        implicitHeight: notifications.implicitHeight + (Settings.notificationPadding * 2)

        ColumnLayout {
            id: notifications

            anchors.centerIn: parent
            spacing: Settings.notificationPadding

            Repeater {
                model: NotificationService.popupNotifications
                delegate: NotificationWrapper {}
            }
        }
    }
}
