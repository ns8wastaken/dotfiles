pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Singleton {
    id: root

    property alias notifications: notifServer.trackedNotifications

    signal notification(notif: Notification)

    NotificationServer {
        id: notifServer

        actionsSupported: false
        bodySupported: true
        bodyMarkupSupported: true // TODO: missing href and img
        bodyImagesSupported: false
        bodyHyperlinksSupported: false
        persistenceSupported: false
        imageSupported: true

        onNotification: function(notif: Notification) {
            notif.tracked = true;
            root.notification(notif);
        }
    }
}
