import QtQuick
import qs.Modules.NotificationPopups
import qs.Services
import qs.Config
import qs.Theme

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
                duration: Theme.anim.small
                easing.type: Easing.InOutCubic
            }
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: Theme.anim.normal
                easing.type: Easing.InOutCubic
            }
        }
    }

    addDisplaced: Transition {
        PropertyAnimation {
            property: "y"
            duration: Theme.anim.small
            easing.type: Easing.InOutCubic
        }
    }

    removeDisplaced: addDisplaced

    orientation: ListView.Vertical

    // Causes a bit of flickering
    // model: ScriptModel {
    //     values: [...NotificationService.notifications.values].reverse()
    // }
    model: NotificationService.notifications

    delegate: NotificationEntry {}
}
