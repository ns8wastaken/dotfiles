pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Singleton {
    id: root

    property alias notifications: notifServer.trackedNotifications

    NotificationServer {
        id: notifServer

        imageSupported: true

        bodySupported: true
        bodyMarkupSupported: true
        bodyImagesSupported: true

        actionsSupported: true

        onNotification: function(notif) {
            notif.tracked = true;
            root.notification(notif);
        }
    }

    signal notification(notification: Notification)
}
