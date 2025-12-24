import Quickshell
import QtQuick
import qs.Modules.NotificationsPopup
import qs.Services
import qs.Config

ListView {
    id: root

    implicitWidth: Config.notifications.width
    implicitHeight: Math.min(contentHeight, parent.height)

    spacing: Config.notifications.spacing

    add: Transition {
        ParallelAnimation {
            PropertyAnimation {
                property: "x"
                from: root.implicitWidth
                duration: 200
                easing.type: Easing.InOutCubic
            }
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 300
                easing.type: Easing.InOutCubic
            }
        }
    }

    addDisplaced: Transition {
        PropertyAnimation {
            property: "y"
            duration: 200
            easing.type: Easing.InOutCubic
        }
    }

    removeDisplaced: addDisplaced

    orientation: ListView.Vertical
    // verticalLayoutDirection: ListView.BottomToTop

    // Causes a bit of flickering
    // model: ScriptModel {
    //     values: [...NotificationService.notifications.values].reverse()
    // }
    model: NotificationService.notifications

    delegate: NotificationEntry {}
}
