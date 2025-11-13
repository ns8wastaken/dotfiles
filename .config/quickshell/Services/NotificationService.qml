pragma Singleton

import Quickshell
import QtQuick
import Quickshell.Services.Notifications

Singleton {
    id: root

    property list<Notification> rawServerNotifications: notificationServer.trackedNotifications.values
    property list<Notification> centerNotifications: []
    property list<Notification> popupNotifications: []

    onRawServerNotificationsChanged: {
        root.updateModels()
    }

    NotificationServer {
        id: notificationServer

        onNotification: notification => {
            notification.tracked = true;
            notification.popup = true;
            notificationExpireComponent.createObject(root, {
                notificationId: notification.id,
                timeout: notification.expireTimeout > 0 ? notification.expireTimeout : 5_000
            });
        }
    }

    function updateModels() {
        root.popupNotifications = notificationServer.trackedNotifications.values.filter(notif => notif.popup);
        root.centerNotifications = notificationServer.trackedNotifications.values.filter(notif => notif.desktopEntry !== "com.spotify.Client")
    }

    Component {
        id: notificationExpireComponent

        Timer {
            required property int notificationId
            required property int timeout

            interval: timeout
            running: true

            onTriggered: () => {
                const index = root.popupNotifications.findIndex(
                    notification => notification.id == notificationId
                );

                if (index >= 0) {
                    if (root.popupNotifications[index].desktopEntry === "com.spotify.Client") {
                        root.popupNotifications[index].expire()
                    } else {
                        root.popupNotifications[index].popup = false
                    }
                    root.updateModels()
                }

                destroy();
            }
        }
    }
}
