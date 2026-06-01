pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import qs.Modules.NotificationPopups
import qs.Components.Animations
import qs.Core.Services
import qs.Core.Config
import qs.Theme

ListView {
    model: ScriptModel {
        values: NotificationService.popups.filter(n => !n.closed)
    }

    spacing: Theme.spacing.small
    width: Config.notifs.width
    height: contentHeight

    add: Transition {
        NAnim {
            property: "x"
            from: Config.notifs.width
            easing.type: Easing.OutBack
        }
    }

    remove: Transition {
        NAnim {
            property: "x"
            to: Config.notifs.width
            easing.type: Easing.InBack
        }
    }

    displaced: Transition {
        NAnim {
            property: "y"
            alwaysRunToEnd: false
            easing.type: Easing.OutBack
        }
    }

    delegate: NotificationEntry {}
}
